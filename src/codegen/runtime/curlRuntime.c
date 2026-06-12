#include <curl/curl.h>
#include <string.h>

static char response[65536];
static size_t response_len = 0;

size_t write_callback(
    void *ptr,
    size_t size,
    size_t nmemb,
    void *userdata
) {
    size_t total = size * nmemb;

    // prevent overflow
    if (response_len + total >= sizeof(response) - 1) {
        total = sizeof(response) - response_len - 1;
    }

    memcpy(response + response_len, ptr, total);

    response_len += total;
    response[response_len] = '\0';

    return size * nmemb;
}

const char* zen_request(
    const char *method,
    const char *url,
    const char *body
) {
    response[0] = '\0';
    response_len = 0;

    CURL *curl = curl_easy_init();
    if (!curl) return "";

    struct curl_slist *headers = NULL;
    headers = curl_slist_append(
        headers,
        "Content-Type: application/json"
    );

    curl_easy_setopt(curl, CURLOPT_URL, url);

    curl_easy_setopt(
        curl,
        CURLOPT_WRITEFUNCTION,
        write_callback
    );

    curl_easy_setopt(
        curl,
        CURLOPT_WRITEDATA,
       (void*)response
    );

    if (strcmp(method, "POST") == 0) {

        curl_easy_setopt(curl, CURLOPT_POST, 1L);

        if (body) {
            curl_easy_setopt(
                curl,
                CURLOPT_POSTFIELDS,
                body
            );
        }

    } else {

        curl_easy_setopt(
            curl,
            CURLOPT_CUSTOMREQUEST,
            method
        );

        if (body) {
            curl_easy_setopt(
                curl,
                CURLOPT_POSTFIELDS,
                body
            );
        }
    }

    curl_easy_setopt(
        curl,
        CURLOPT_HTTPHEADER,
        headers
    );

    CURLcode result = curl_easy_perform(curl);

    if (result != CURLE_OK) {
        snprintf(
            response,
            sizeof(response),
            "CURL_ERROR: %s",
            curl_easy_strerror(result)
        );
    }

    curl_slist_free_all(headers);
    curl_easy_cleanup(curl);

    return response;
}

const char* _http_get(const char *url) {
    return zen_request("GET", url, NULL);
}

const char* _http_post(
    const char *url,
    const char *body
) {
    return zen_request("POST", url, body);
}

const char* _http_update(
    const char *url,
    const char *body
) {
    return zen_request("PUT", url, body);
}

const char* _http_patch(
    const char *url,
    const char *body
) {
    return zen_request("PATCH", url, body);
}

const char* _http_delete(const char *url) {
    return zen_request("DELETE", url, NULL);
}
