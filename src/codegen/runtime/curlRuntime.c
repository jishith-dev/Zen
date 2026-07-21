
#include <curl/curl.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#ifdef _WIN32
#include <string.h>
#define strncasecmp _strnicmp
#else
#include <strings.h>
#endif

static void http_error(const char *type, const char *msg) {
    fprintf(stderr, "\033[1;31m[Zen %s]\n  └── %s\033[0m\n", type, msg);
    exit(1);
}

void _http_freeResponse(char *ptr) {
    if (ptr)
        free(ptr);
}

char *_http_urlEncode(const char *str) {
    if (!str) return NULL;

    static const char HEX[] = "0123456789ABCDEF";
    size_t len = 0;

    for (const unsigned char *p = (const unsigned char *)str; *p; p++) {
        unsigned char c = *p;
        if ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') ||
            (c >= '0' && c <= '9') || c == '-' || c == '_' || c == '.' || c == '~') {
            len++;
        } else {
            len += 3;
        }
    }

    char *out = malloc(len + 1);
    if (!out) http_error("MemoryError", "Failed to allocate memory for URL encode");

    char *dst = out;
    for (const unsigned char *p = (const unsigned char *)str; *p; p++) {
        unsigned char c = *p;
        if ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') ||
            (c >= '0' && c <= '9') || c == '-' || c == '_' || c == '.' || c == '~') {
            *dst++ = (char)c;
        } else {
            *dst++ = '%';
            *dst++ = HEX[(c >> 4) & 0x0F];
            *dst++ = HEX[c & 0x0F];
        }
    }
    *dst = '\0';
    return out;
}

char *_http_urlDecode(const char *str) {
    if (!str) return NULL;

    size_t len = strlen(str);
    char *out = malloc(len + 1);
    if (!out) http_error("MemoryError", "Failed to allocate memory for URL decode");

    const char *src = str;
    char *dst = out;

    while (*src) {
        if (*src == '%' && isxdigit((unsigned char)src[1]) && isxdigit((unsigned char)src[2])) {
            char hex[3] = { src[1], src[2], 0 };
            *dst++ = (char)strtol(hex, NULL, 16);
            src += 3;
        } else if (*src == '+') {
            *dst++ = ' ';
            src++;
        } else {
            *dst++ = *src++;
        }
    }
    *dst = '\0';
    return out;
}

typedef struct {
    char *data;
    size_t len;
    size_t cap;
} HttpBuffer;

static size_t write_callback(void *ptr, size_t size, size_t nmemb, void *userdata) {
    HttpBuffer *buf = (HttpBuffer *)userdata;
    size_t total = size * nmemb;

    if (buf->len + total + 1 > buf->cap) {
        size_t newcap = buf->cap ? buf->cap * 2 : 4096;
        while (newcap < buf->len + total + 1) newcap *= 2;

        char *tmp = realloc(buf->data, newcap);
        if (!tmp) return 0;

        buf->data = tmp;
        buf->cap = newcap;
    }

    memcpy(buf->data + buf->len, ptr, total);
    buf->len += total;
    buf->data[buf->len] = '\0';

    return total;
}

static struct curl_slist *custom_headers = NULL;
static long last_status = 0;

void _http_setHeader(const char *key, const char *value) {
    if (!key || !value) return;

    size_t len = strlen(key) + strlen(value) + 3;
    char *line = malloc(len);
    if (!line) http_error("MemoryError", "Failed to allocate memory for header");

    snprintf(line, len, "%s: %s", key, value);
    custom_headers = curl_slist_append(custom_headers, line);
    free(line);
}

void _http_clearHeaders(void) {
    if (custom_headers) {
        curl_slist_free_all(custom_headers);
        custom_headers = NULL;
    }
}

long _http_lastStatus(void) {
    return last_status;
}

static int has_content_type(void) {
    for (struct curl_slist *n = custom_headers; n; n = n->next) {
        if (strncasecmp(n->data, "Content-Type:", 13) == 0) return 1;
    }
    return 0;
}

static char *zen_request(const char *method, const char *url, const char *body) {
    CURL *curl = curl_easy_init();
    if (!curl) http_error("NetworkError", "Failed to initialize curl");

    HttpBuffer buf = { malloc(1), 0, 1 };
    if (!buf.data) http_error("MemoryError", "Failed to allocate memory for HTTP response");
    buf.data[0] = '\0';

    struct curl_slist *headers = NULL;
    if (!has_content_type()) {
        headers = curl_slist_append(headers, "Content-Type: application/json");
    }
    for (struct curl_slist *n = custom_headers; n; n = n->next) {
        headers = curl_slist_append(headers, n->data);
    }

    curl_easy_setopt(curl, CURLOPT_URL, url);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, (void *)&buf);
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);
    curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
    curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT, 10L);
    curl_easy_setopt(curl, CURLOPT_TIMEOUT, 30L);

    if (strcmp(method, "POST") == 0) {
        curl_easy_setopt(curl, CURLOPT_POST, 1L);
        if (body) curl_easy_setopt(curl, CURLOPT_POSTFIELDS, body);
    } else {
        curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, method);
        if (body) curl_easy_setopt(curl, CURLOPT_POSTFIELDS, body);
    }

    CURLcode result = curl_easy_perform(curl);

    if (result != CURLE_OK) {
        free(buf.data);
        curl_slist_free_all(headers);
        curl_easy_cleanup(curl);
        last_status = 0;
        http_error("NetworkError", curl_easy_strerror(result));
    }

    curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &last_status);

    curl_slist_free_all(headers);
    curl_easy_cleanup(curl);

    return buf.data;
}

const char *_http_get(const char *url) {
    return zen_request("GET", url, NULL);
}

const char *_http_post(const char *url, const char *body) {
    return zen_request("POST", url, body);
}

const char *_http_put(const char *url, const char *body) {
    return zen_request("PUT", url, body);
}

const char *_http_patch(const char *url, const char *body) {
    return zen_request("PATCH", url, body);
}

const char *_http_delete(const char *url) {
    return zen_request("DELETE", url, NULL);
}