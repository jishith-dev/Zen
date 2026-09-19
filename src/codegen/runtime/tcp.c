#ifndef _WIN32
#define _POSIX_C_SOURCE 200112L
#endif
/* Production TCP runtime for Zen */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>

#ifdef _WIN32
  #include <winsock2.h>
  #include <ws2tcpip.h>
  typedef SOCKET zen_socket_t;
  #define ZEN_INVALID_SOCKET INVALID_SOCKET
  #define zen_close_socket closesocket
  #define zen_socket_error() WSAGetLastError()
#else
  #include <sys/types.h>
  #include <sys/socket.h>
  #include <netdb.h>
  #include <unistd.h>
  #include <errno.h>
  #include <signal.h>
  #include <pthread.h>
  typedef int zen_socket_t;
  #define ZEN_INVALID_SOCKET (-1)
  #define zen_close_socket close
  #define zen_socket_error() errno
#endif

/* Must match Zen's existing List runtime layout. */
typedef struct {
  void *data;
  int size;
  int capacity;
  size_t element_size;
  int depth;
  int deepestType;
} ZenList;

extern ZenList *_zen_list_new(size_t element_size);
extern void _zen_list_push(ZenList *list, void *value);

struct ZenTcp {
  zen_socket_t socket;
  bool open;
};

typedef struct ZenTcp ZenTcp;

typedef struct ZenTcpServer {
  zen_socket_t socket;
  bool open;
} ZenTcpServer;

static void tcp_error(const char *message) {
  fprintf(stderr, "[Zen NetworkError] %s (code=%d)\n", message,
          zen_socket_error());
}

/* ---- Platform init: thread-safe, one-time ---- */

#ifdef _WIN32

static BOOL CALLBACK tcp_win_init_once(PINIT_ONCE initOnce, PVOID param,
                                        PVOID *context) {
  (void)initOnce;
  (void)param;
  (void)context;

  WSADATA data;
  if (WSAStartup(MAKEWORD(2, 2), &data) != 0) {
    fprintf(stderr, "[Zen NetworkError] WSAStartup failed\n");
    return FALSE;
  }

  return TRUE;
}

static bool tcp_platform_init(void) {
  static INIT_ONCE once = INIT_ONCE_STATIC_INIT;
  BOOL ok = InitOnceExecuteOnce(&once, tcp_win_init_once, NULL, NULL);
  return ok != FALSE;
}

#else

static void tcp_posix_init_once(void) {
  /* A send() to a peer that has closed its end raises SIGPIPE, whose
     default action terminates the whole process. We check send()'s
     return value ourselves, so ignore it globally instead. */
  signal(SIGPIPE, SIG_IGN);
}

static bool tcp_platform_init(void) {
  static pthread_once_t once = PTHREAD_ONCE_INIT;
  pthread_once(&once, tcp_posix_init_once);
  return true;
}

#endif

/* ---- Connect ---- */

ZenTcp *_net_connect(const char *host, int port) {
  if (!host || port < 1 || port > 65535 || !tcp_platform_init())
    return NULL;

  char port_text[16];
  snprintf(port_text, sizeof(port_text), "%d", port);

  struct addrinfo hints;
  struct addrinfo *results = NULL;
  memset(&hints, 0, sizeof(hints));
  hints.ai_family = AF_UNSPEC;
  hints.ai_socktype = SOCK_STREAM;

  int status = getaddrinfo(host, port_text, &hints, &results);
  if (status != 0) {
    fprintf(stderr, "[Zen NetworkError] Cannot resolve host: %s\n", host);
    return NULL;
  }

  zen_socket_t connected = ZEN_INVALID_SOCKET;

  for (struct addrinfo *it = results; it; it = it->ai_next) {
    zen_socket_t s = (zen_socket_t)socket(it->ai_family, it->ai_socktype,
                                          it->ai_protocol);
    if (s == ZEN_INVALID_SOCKET)
      continue;

    if (connect(s, it->ai_addr, (int)it->ai_addrlen) == 0) {
      connected = s;
      break;
    }

    zen_close_socket(s);
  }

  freeaddrinfo(results);

  if (connected == ZEN_INVALID_SOCKET) {
    tcp_error("Connection failed");
    return NULL;
  }

  ZenTcp *tcp = malloc(sizeof(ZenTcp));
  if (!tcp) {
    zen_close_socket(connected);
    return NULL;
  }

  tcp->socket = connected;
  tcp->open = true;
  return tcp;
}

/* ---- Listen ---- */

ZenTcpServer *_net_listen(int port) {
  if (port < 1 || port > 65535 || !tcp_platform_init())
    return NULL;

  zen_socket_t s = (zen_socket_t)socket(AF_INET6, SOCK_STREAM, 0);

  if (s == ZEN_INVALID_SOCKET)
    s = (zen_socket_t)socket(AF_INET, SOCK_STREAM, 0);

  if (s == ZEN_INVALID_SOCKET) {
    tcp_error("Socket creation failed");
    return NULL;
  }

  int reuse = 1;
  setsockopt(s, SOL_SOCKET, SO_REUSEADDR, (const char *)&reuse, sizeof(reuse));

#ifdef IPV6_V6ONLY
  int v6only = 0;
  setsockopt(s, IPPROTO_IPV6, IPV6_V6ONLY, (const char *)&v6only,
             sizeof(v6only));
#endif

  struct addrinfo hints;
  struct addrinfo *results = NULL;
  char port_text[16];
  snprintf(port_text, sizeof(port_text), "%d", port);

  memset(&hints, 0, sizeof(hints));
  hints.ai_family = AF_UNSPEC;
  hints.ai_socktype = SOCK_STREAM;
  hints.ai_flags = AI_PASSIVE;

  if (getaddrinfo(NULL, port_text, &hints, &results) != 0) {
    zen_close_socket(s);
    tcp_error("Address preparation failed");
    return NULL;
  }

  int bound = -1;
  for (struct addrinfo *it = results; it; it = it->ai_next) {
    if (bind(s, it->ai_addr, (int)it->ai_addrlen) == 0) {
      bound = 0;
      break;
    }
  }
  freeaddrinfo(results);

  if (bound != 0 || listen(s, 128) != 0) {
    tcp_error("Bind/listen failed");
    zen_close_socket(s);
    return NULL;
  }

  ZenTcpServer *server = malloc(sizeof(ZenTcpServer));
  if (!server) {
    zen_close_socket(s);
    return NULL;
  }

  server->socket = s;
  server->open = true;
  return server;
}

/* ---- Send ---- */

long _zen_tcp_send(ZenTcp *tcp, ZenList *data) {
  if (!tcp || !tcp->open || !data || data->size <= 0)
    return 0;

  int total = 0;
  const char *bytes = (const char *)data->data;

  while (total < data->size) {
    int sent = (int)send(tcp->socket, bytes + total, data->size - total, 0);

    if (sent <= 0) {
      tcp_error("Send failed");
      tcp->open = false;   /* peer is gone; don't let caller keep writing */
      return total > 0 ? total : -1;
    }

    total += sent;
  }

  return total;
}

/* ---- Receive ---- */

ZenList *_zen_tcp_receive(ZenTcp *tcp, int maxBytes) {
  if (!tcp || !tcp->open || maxBytes <= 0)
    return _zen_list_new(sizeof(uint8_t));

  uint8_t *buffer = malloc((size_t)maxBytes);
  if (!buffer)
    return _zen_list_new(sizeof(uint8_t));   /* consistent with every other failure path */

  int received = (int)recv(tcp->socket, (char *)buffer, maxBytes, 0);

  if (received < 0) {
    tcp_error("Receive failed");
    free(buffer);
    tcp->open = false;   /* a receive error means this connection is done */
    return _zen_list_new(sizeof(uint8_t));
  }

  ZenList *list = _zen_list_new(sizeof(uint8_t));
  for (int i = 0; i < received; i++)
    _zen_list_push(list, &buffer[i]);

  free(buffer);

  if (received == 0)
    tcp->open = false;   /* peer performed an orderly shutdown */

  return list;
}

/* ---- Close / status ---- */

void _zen_tcp_close(ZenTcp *tcp) {
  if (!tcp)
    return;

  if (tcp->open) {
#ifndef _WIN32
    shutdown(tcp->socket, SHUT_RDWR);
#else
    shutdown(tcp->socket, SD_BOTH);
#endif
    zen_close_socket(tcp->socket);
    tcp->open = false;
  }

  free(tcp);
}

bool _zen_tcp_isOpen(ZenTcp *tcp) {
  return tcp != NULL && tcp->open;
}

ZenTcp *_zen_tcp_accept(ZenTcpServer *server) {
  if (!server || !server->open)
    return NULL;

  zen_socket_t client = accept(server->socket, NULL, NULL);
  if (client == ZEN_INVALID_SOCKET) {
    tcp_error("Accept failed");
    return NULL;
  }

  ZenTcp *tcp = malloc(sizeof(ZenTcp));
  if (!tcp) {
    zen_close_socket(client);
    return NULL;
  }

  tcp->socket = client;
  tcp->open = true;
  return tcp;
}

void _zen_tcp_server_close(ZenTcpServer *server) {
  if (!server)
    return;

  if (server->open) {
    zen_close_socket(server->socket);
    server->open = false;
  }

  free(server);
}

bool _zen_tcp_server_isOpen(ZenTcpServer *server) {
  return server != NULL && server->open;
}