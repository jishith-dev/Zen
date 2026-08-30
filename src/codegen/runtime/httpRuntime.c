// w_httpRuntime.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#ifdef _WIN32
#include <winsock2.h>
#include <ws2tcpip.h>
#pragma comment(lib, "ws2_32.lib")
typedef SOCKET socket_t;
typedef int socklen_t_compat;
#define SOCK_INVALID(fd) ((fd) == INVALID_SOCKET)
#define CLOSESOCK(fd) closesocket(fd)
#define strncasecmp _strnicmp
#define strdup _strdup
static char *strtok_r_compat(char *str, const char *delim, char **saveptr) {
    return strtok_s(str, delim, saveptr);
}
#define strtok_r strtok_r_compat
#else
#include <unistd.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <sys/socket.h>
#include <strings.h>
typedef int socket_t;
typedef socklen_t socklen_t_compat;
#define SOCK_INVALID(fd) ((fd) < 0)
#define CLOSESOCK(fd) close(fd)
#endif

#define HEADER_BUF_SIZE      4096
#define RESPONSE_HDR_SIZE    8192
#define RECV_CHUNK_SIZE      8192
#define MAX_REQUEST_LINE     8192
#define MAX_HEADERS_SECTION  65536
#define MAX_BODY_SIZE        (16 * 1024 * 1024) /* 16MB cap */

typedef struct {
    socket_t serverFd;
    int port;
    int running;
} HttpServer;

typedef struct {
    socket_t clientFd;

    char *method;
    char *path;
    char *body;
    size_t bodyLen;

    char *requestHeaders;
    size_t requestHeadersLen;

    int status;
    int responded;   /* guards against double-send / double-free */

    char headers[HEADER_BUF_SIZE];
    size_t headersLen;
} HttpRequest;

HttpServer* _httpServer_create(int port) {

    HttpServer *server = (HttpServer*)malloc(sizeof(HttpServer));
    if (!server) return NULL;

#ifdef _WIN32
    WSADATA wsa;
    if (WSAStartup(MAKEWORD(2, 2), &wsa) != 0) {
        free(server);
        return NULL;
    }
#endif

    server->serverFd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (SOCK_INVALID(server->serverFd)) {
        perror("socket failed");
        free(server);
        return NULL;
    }

    server->port = port;
    server->running = 0;

    return server;
}

int _httpServer_listen(HttpServer *server) {

    if (!server) return 0;

    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons((unsigned short)server->port);
    addr.sin_addr.s_addr = htonl(INADDR_ANY);

    int opt = 1;
#ifdef _WIN32
    setsockopt(server->serverFd, SOL_SOCKET, SO_REUSEADDR, (const char*)&opt, sizeof(opt));
#else
    setsockopt(server->serverFd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
#endif

    if (bind(server->serverFd, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
#ifdef _WIN32
        fprintf(stderr, "bind failed: %d\n", WSAGetLastError());
#else
        fprintf(stderr, "bind failed: %s\n", strerror(errno));
#endif
        return 0;
    }

    if (listen(server->serverFd, 64) < 0) {
#ifdef _WIN32
        fprintf(stderr, "listen failed: %d\n", WSAGetLastError());
#else
        fprintf(stderr, "listen failed: %s\n", strerror(errno));
#endif
        return 0;
    }

    server->running = 1;
    return 1;
}

void _httpServer_close(HttpServer *server) {

    if (!server) return;

    server->running = 0;
    CLOSESOCK(server->serverFd);

#ifdef _WIN32
    WSACleanup();
#endif

    free(server);
}

/* Reads until CRLFCRLF is found (end of headers) or limits are hit.
   Returns a heap buffer (caller frees) containing everything read so far*/
static char* readUntilHeadersEnd(socket_t fd, size_t *outLen, size_t *headerEnd) {

    size_t cap = RECV_CHUNK_SIZE;
    size_t len = 0;
    char *buf = (char*)malloc(cap);
    if (!buf) return NULL;

    for (;;) {
        if (len + RECV_CHUNK_SIZE > cap) {
            size_t newCap = cap * 2;
            char *nbuf = (char*)realloc(buf, newCap);
            if (!nbuf) { free(buf); return NULL; }
            buf = nbuf;
            cap = newCap;
        }

        int n = recv(fd, buf + len, (int)(cap - len - 1), 0);

        if (n < 0) {
#ifndef _WIN32
            if (errno == EINTR) continue;
#endif
            free(buf);
            return NULL;
        }
        if (n == 0) {
            /* peer closed before we saw end of headers */
            free(buf);
            return NULL;
        }

        len += (size_t)n;
        buf[len] = '\0';

        /* look for \r\n\r\n */
        for (size_t i = 0; i + 3 < len; i++) {
            if (buf[i] == '\r' && buf[i+1] == '\n' &&
                buf[i+2] == '\r' && buf[i+3] == '\n') {
                *outLen = len;
                *headerEnd = i + 4;
                return buf;
            }
        }

        if (len > MAX_HEADERS_SECTION) {
            free(buf);
            return NULL;
        }
    }
}

/* Case-insensitive search for a header value within the raw header block.
   Returns 1 and fills outVal (bounded, null-terminated) if found. */
static int findHeaderValue(const char *headerBlock, size_t headerBlockLen,
                            const char *headerName,
                            char *outVal, size_t outValCap) {

    size_t nameLen = strlen(headerName);
    const char *p = headerBlock;
    const char *end = headerBlock + headerBlockLen;

    while (p < end) {
        const char *lineEnd = memchr(p, '\n', (size_t)(end - p));
        if (!lineEnd) break;

        size_t lineLen = (size_t)(lineEnd - p);
        if (lineLen > 0 && p[lineLen - 1] == '\r') lineLen--;

        if (lineLen > nameLen && p[nameLen] == ':' &&
            strncasecmp(p, headerName, nameLen) == 0) {

            const char *valStart = p + nameLen + 1;
            size_t valLen = lineLen - nameLen - 1;

            while (valLen > 0 && (*valStart == ' ' || *valStart == '\t')) {
                valStart++;
                valLen--;
            }

            if (valLen >= outValCap) valLen = outValCap - 1;
            memcpy(outVal, valStart, valLen);
            outVal[valLen] = '\0';
            return 1;
        }

        p = lineEnd + 1;
    }

    return 0;
}

static void appendResponseHeader(HttpRequest *req, const char *name, const char *value) {

    if (!req || !name || !value) return;

    int n = snprintf(
        req->headers + req->headersLen,
        HEADER_BUF_SIZE - req->headersLen,
        "%s: %s\r\n",
        name, value
    );

    if (n < 0) return; /* encoding error, skip */

    if ((size_t)n >= HEADER_BUF_SIZE - req->headersLen) {
        /* would have truncated — clamp headersLen to end, drop this header */
        req->headersLen = HEADER_BUF_SIZE - 1;
        req->headers[req->headersLen] = '\0';
        return;
    }

    req->headersLen += (size_t)n;
}

static void freeRequestFields(HttpRequest *req) {
    if (!req) return;

    free(req->method);
    free(req->path);
    free(req->body);
    free(req->requestHeaders);

    req->method = NULL;
    req->path = NULL;
    req->body = NULL;
    req->requestHeaders = NULL;
}

static void sendResponse(HttpRequest *req, int statusOverrideOrNeg,
                          const char *contentType,
                          const char *body, size_t bodyLen) {

    if (!req) return;
    if (req->responded) return; /* guard against double-send */
    req->responded = 1;

    int status = (statusOverrideOrNeg >= 0) ? statusOverrideOrNeg : req->status;
    if (!body) { body = ""; bodyLen = 0; }
    if (!contentType) contentType = "text/plain; charset=UTF-8";

    char header[RESPONSE_HDR_SIZE];
    int n = snprintf(
        header, sizeof(header),
        "HTTP/1.1 %d %s\r\n"
        "Content-Type: %s\r\n"
        "%s"
        "Content-Length: %zu\r\n"
        "Connection: close\r\n"
        "\r\n",
        status,
        (status >= 200 && status < 300) ? "OK" :
        (status >= 300 && status < 400) ? "Found" :
        (status >= 400 && status < 500) ? "Client Error" : "Server Error",
        contentType,
        req->headers,
        bodyLen
    );

    if (n > 0 && (size_t)n < sizeof(header)) {
        send(req->clientFd, header, (size_t)n, 0);
    } else {
        /* headers section too large for buffer — send a minimal safe header */
        char fallback[256];
        int fn = snprintf(fallback, sizeof(fallback),
            "HTTP/1.1 %d Internal Server Error\r\nContent-Length: 0\r\nConnection: close\r\n\r\n",
            status);
        if (fn > 0) send(req->clientFd, fallback, (size_t)fn, 0);
        bodyLen = 0;
    }

    if (bodyLen > 0) {
        size_t sent = 0;
        while (sent < bodyLen) {
            int s = send(req->clientFd, body + sent, (int)(bodyLen - sent), 0);
            if (s <= 0) break;
            sent += (size_t)s;
        }
    }

    CLOSESOCK(req->clientFd);

    freeRequestFields(req);
    free(req);
}

HttpRequest* _httpServer_next(HttpServer *server) {

    if (!server) return NULL;

    HttpRequest *req = (HttpRequest*)calloc(1, sizeof(HttpRequest));
    if (!req) return NULL;

    struct sockaddr_in client;
    socklen_t_compat len = sizeof(client);

    req->clientFd = accept(server->serverFd, (struct sockaddr*)&client, &len);

    if (SOCK_INVALID(req->clientFd)) {
        free(req);
        return NULL;
    }

    req->status = 200;
    req->responded = 0;
    req->headersLen = 0;
    req->headers[0] = '\0';

    size_t totalLen = 0, headerEnd = 0;
    char *raw = readUntilHeadersEnd(req->clientFd, &totalLen, &headerEnd);

    if (!raw) {
        CLOSESOCK(req->clientFd);
        free(req);
        return NULL;
    }

  req->requestHeaders = (char*)malloc(headerEnd + 1);

if (!req->requestHeaders) {
    free(raw);
    CLOSESOCK(req->clientFd);
    free(req);
    return NULL;
}

memcpy(req->requestHeaders, raw, headerEnd);
req->requestHeaders[headerEnd] = '\0';
req->requestHeadersLen = headerEnd;

    /* Parse request line: "METHOD /path HTTP/1.1\r\n" */
    char lineBuf[MAX_REQUEST_LINE];
    size_t lineLen = 0;
    for (size_t i = 0; i < headerEnd && i < totalLen; i++) {
        if (raw[i] == '\r' || raw[i] == '\n') break;
        if (lineLen < sizeof(lineBuf) - 1) lineBuf[lineLen++] = raw[i];
    }
    lineBuf[lineLen] = '\0';

    char *saveptr = NULL;
    char *methodTok = strtok_r(lineBuf, " ", &saveptr);
    char *pathTok = methodTok ? strtok_r(NULL, " ", &saveptr) : NULL;

    req->method = methodTok ? strdup(methodTok) : strdup("");
    req->path = pathTok ? strdup(pathTok) : strdup("/");

    /* Determine body length from Content-Length, if present */
    char clVal[32];
    size_t contentLength = 0;
    if (findHeaderValue(raw, headerEnd, "Content-Length", clVal, sizeof(clVal))) {
        long parsed = strtol(clVal, NULL, 10);
        if (parsed > 0 && (size_t)parsed <= MAX_BODY_SIZE) {
            contentLength = (size_t)parsed;
        }
    }

    if (contentLength > 0) {

        char *bodyBuf = (char*)malloc(contentLength + 1);
        if (!bodyBuf) {
            free(raw);
            CLOSESOCK(req->clientFd);
            freeRequestFields(req);
            free(req);
            return NULL;
        }

        size_t alreadyHave = totalLen - headerEnd;
        if (alreadyHave > contentLength) alreadyHave = contentLength;
        memcpy(bodyBuf, raw + headerEnd, alreadyHave);

        size_t have = alreadyHave;
        while (have < contentLength) {
            int n = recv(req->clientFd, bodyBuf + have, (int)(contentLength - have), 0);
            if (n <= 0) {
#ifndef _WIN32
                if (n < 0 && errno == EINTR) continue;
#endif
                break;
            }
            have += (size_t)n;
        }

        bodyBuf[have] = '\0';
        req->body = bodyBuf;
        req->bodyLen = have;
    }

    free(raw);
    return req;
}

void _httpRequest_status(HttpRequest *req, int status) {
    if (!req) return;
    req->status = status;
}

void _httpRequest_setHeader(HttpRequest *req, const char *name, const char *value) {
    appendResponseHeader(req, name, value);
}

void _httpRequest_send(HttpRequest *req, const char *body) {
    if (!req) return;
    size_t bodyLen = body ? strlen(body) : 0;
    sendResponse(req, -1, "text/plain; charset=UTF-8", body, bodyLen);
}

void _httpRequest_json(HttpRequest *req, const char *json) {
    if (!req) return;
    size_t bodyLen = json ? strlen(json) : 0;
    sendResponse(req, -1, "application/json", json, bodyLen);
}

void _httpRequest_html(HttpRequest *req, const char *html) {
    if (!req) return;
    size_t bodyLen = html ? strlen(html) : 0;
    sendResponse(req, -1, "text/html; charset=UTF-8", html, bodyLen);
}

void _httpRequest_css(HttpRequest *req, const char *css) {
    if (!req) return;
    size_t bodyLen = css ? strlen(css) : 0;
    sendResponse(req, -1, "text/css", css, bodyLen);
}

void _httpRequest_redirect(HttpRequest *req, const char *url) {
    if (!req) return;
    appendResponseHeader(req, "Location", url ? url : "/");
    sendResponse(req, 302, "text/plain; charset=UTF-8", "", 0);
}

void _httpRequest_sendFile(HttpRequest *req, const char *path, const char *contentType) {

    if (!req) return;

    if (!path || strstr(path, "..") != NULL) {
        sendResponse(req, 400, "text/plain; charset=UTF-8", "Bad path", 8);
        return;
    }

    FILE *fp = fopen(path, "rb");
    if (!fp) {
        sendResponse(req, 404, "text/plain; charset=UTF-8", "Not found", 9);
        return;
    }

    if (fseek(fp, 0, SEEK_END) != 0) {
        fclose(fp);
        sendResponse(req, 500, "text/plain; charset=UTF-8", "Read error", 10);
        return;
    }

    long size = ftell(fp);
    if (size < 0) {
        fclose(fp);
        sendResponse(req, 500, "text/plain; charset=UTF-8", "Read error", 10);
        return;
    }
    rewind(fp);

    char *buf = (char*)malloc((size_t)size + 1);
    if (!buf) {
        fclose(fp);
        sendResponse(req, 500, "text/plain; charset=UTF-8", "Out of memory", 13);
        return;
    }

    size_t readBytes = fread(buf, 1, (size_t)size, fp);
    fclose(fp);
    buf[readBytes] = '\0';

    sendResponse(req, -1, contentType ? contentType : "application/octet-stream", buf, readBytes);

    free(buf);
}

const char* _httpRequest_method(HttpRequest *req) { return (req && req->method) ? req->method : ""; }
const char* _httpRequest_path(HttpRequest *req)   { return (req && req->path)   ? req->path   : ""; }
const char* _httpRequest_body(HttpRequest *req)   { return (req && req->body)   ? req->body   : ""; }

const char* _httpRequest_getHeader(
    HttpRequest *req,
    const char *name
) {
    static char value[4096];

    value[0] = '\0';

    if (!req || !name || !req->requestHeaders) {
        return value;
    }

    findHeaderValue(
        req->requestHeaders,
        req->requestHeadersLen,
        name,
        value,
        sizeof(value)
    );

    return value;
}

void _httpRequest_discard(HttpRequest *req) {
    if (!req) return;
    if (req->responded) return;
    req->responded = 1;
    CLOSESOCK(req->clientFd);
    freeRequestFields(req);
    free(req);
}