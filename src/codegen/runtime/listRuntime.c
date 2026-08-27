#ifdef _WIN32
#define strdup _strdup
#endif
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <openssl/rand.h>
#include <inttypes.h>
#include <openssl/evp.h>
#include <openssl/hmac.h>
#include <openssl/rand.h>


void **zen_args_new(int count) {
  return (void **)malloc(sizeof(void *) * count);
}

void zen_args_set(void **args, int index, void *value) { args[index] = value; }

typedef struct {
  void *data;
  int size;
  int capacity;
  size_t element_size;

  int depth;
  int deepestType;
} ZenList;


#define ZEN_LIST_STRING 4

void _zen_map_free_internal(void *map); 
void _zen_list_free(ZenList *list);

static void _zen_list_free_leaf(ZenList *list, int i) {
  if (list->deepestType == ZEN_LIST_STRING) {
    free(*(char **)((char *)list->data + i * list->element_size));
  } 
}

ZenList *_zen_list_new(size_t element_size) {

  ZenList *list = (ZenList *)malloc(sizeof(ZenList));
  
  if (list == NULL) {
    fprintf(stderr,
        "[Zen RuntimeError]\n"
        "  └── Out of memory\n");
    exit(1);
}

  list->data = NULL;
  list->size = 0;
  list->capacity = 0;
  list->element_size = element_size;
  list->depth = 1;
  list->deepestType = 0;

  return list;
}

void _zen_list_grow(ZenList *list) {

  int new_capacity;

  if (list->capacity == 0) {
    new_capacity = 4;
  } else {
    new_capacity = list->capacity * 2;
  }

  void *new_data = malloc(new_capacity * list->element_size);
  

if (new_data == NULL) {
    fprintf(stderr,
        "[Zen RuntimeError]\n"
        "  └── Out of memory\n");
    exit(1);
}

  // copy old
  if (list->data != NULL) {

    memcpy(new_data, list->data, list->size * list->element_size);

    free(list->data);
  }

  list->data = new_data;
  list->capacity = new_capacity;
}

void _zen_list_push(ZenList *list, void *value) {

  if (list == NULL) {
    fprintf(stderr, "[Zen RuntimeError]\n  └── Attempted to use an "
                    "uninitialized List — did you forget 'field = [...]'?\n");
    exit(1);
  }

  if (list->size >= list->capacity) {
    _zen_list_grow(list);
  }

  char *base = (char *)list->data;

  memcpy(base + (list->size * list->element_size), value, list->element_size);

  list->size++;
}

void *_zen_list_get(ZenList *list, int index) {

  if (list == NULL) {
    fprintf(stderr, "\033[1;31m[Zen RuntimeError]\n"
                    "  └── Attempted to access a null List\033[0m\n");
    exit(1);
  }

  if (list->size < 0) {
    fprintf(stderr,
            "\033[1;31m[Zen RuntimeError]\n"
            "  └── List metadata is corrupted (length=%d)\033[0m\n",
            list->size);
    exit(1);
  }

  if (index < 0 || index >= list->size) {
    fprintf(stderr,
            "\033[1;31m[Zen IndexError]\n"
            "  └── Index %d is out of bounds for List of length %d",
            index, list->size);

    if (list->size > 0)
      fprintf(stderr, " — valid range is 0 to %d", list->size - 1);

    fprintf(stderr, "\033[0m\n");
    exit(1);
  }

  char *base = (char *)list->data;
  return base + (index * list->element_size);
}

void _zen_list_set(ZenList *list, int index, void *value) {

  if (index < 0 || index >= list->size) {
    fprintf(stderr,
            "\033[1;31m[Zen  IndexError]\n  └── Index %d is out of bounds for "
            "List of length %d — valid range is 0 to %d\033[0m\n",
            index, list->size, list->size - 1);
    exit(1);
  }

  if (list->depth > 1) {
    ZenList *old = ((ZenList **)list->data)[index];
    if (old) _zen_list_free(old);
  } else {
    _zen_list_free_leaf(list, index);
  }

  char *base = (char *)list->data;

  memcpy(base + (index * list->element_size), value, list->element_size);
}

void _zen_list_pop(ZenList *list, void *out) {

  if (list->size == 0) {
    fprintf(stderr, "\033[1;31m[Zen  IndexError]\n  └── Cannot pop from an "
                    "empty List\033[0m\n");
    exit(1);
  }

  char *base = (char *)list->data;

  memcpy(out, base + ((list->size - 1) * list->element_size),
         list->element_size);

  list->size--;
}

void _zen_list_remove(ZenList *list, int index) {

  if (index < 0 || index >= list->size) {
    fprintf(stderr,
            "\033[1;31m[Zen  IndexError]\n  └── Index %d is out of bounds for "
            "List of length %d — valid range is 0 to %d\033[0m\n",
            index, list->size, list->size - 1);
    exit(1);
  }

  if (list->depth > 1) {
    ZenList *old = ((ZenList **)list->data)[index];
    if (old) _zen_list_free(old);
  } else {
    _zen_list_free_leaf(list, index);
  }

  char *base = (char *)list->data;

  memmove(base + (index * list->element_size),
          base + ((index + 1) * list->element_size),
          (list->size - index - 1) * list->element_size);

  list->size--;
}

void _zen_list_free(ZenList *list) {

  if (!list)
    return;

  if (list->data) {
    if (list->depth > 1) {
      for (int i = 0; i < list->size; i++) {
        ZenList *child = ((ZenList **)list->data)[i];
        if (child)
          _zen_list_free(child);
      }
    } else {
      for (int i = 0; i < list->size; i++) {
        _zen_list_free_leaf(list, i);
      }
    }
  }

  free(list->data);
  free(list);
}

void _zen_list_clear(ZenList *list) {

  if (!list)
    return;

  if (list->data) {
    if (list->depth > 1) {
      for (int i = 0; i < list->size; i++) {
        ZenList *child = ((ZenList **)list->data)[i];
        if (child)
          _zen_list_free(child);
      }
    } else {
      for (int i = 0; i < list->size; i++) {
        _zen_list_free_leaf(list, i);
      }
    }
  }

  list->size = 0;
}

ZenList *zen_va_ints(int count, va_list args) {

  ZenList *list = _zen_list_new(sizeof(int));

  for (int i = 0; i < count; i++) {

    int value = va_arg(args, int);

    _zen_list_push(list, &value);
  }

  return list;
}

ZenList *zen_va_doubles(int count, va_list args) {

  ZenList *list = _zen_list_new(sizeof(double));

  for (int i = 0; i < count; i++) {

    double value = va_arg(args, double);

    _zen_list_push(list, &value);
  }

  return list;
}

ZenList *zen_va_strings(int count, va_list args) {

  ZenList *list = _zen_list_new(sizeof(char *));

  for (int i = 0; i < count; i++) {

    char *value = va_arg(args, char *);

    _zen_list_push(list, &value);
  }

  return list;
}

ZenList *zen_va_bools(int count, va_list args) {

  ZenList *list = _zen_list_new(sizeof(bool));

  for (int i = 0; i < count; i++) {

    int promoted = va_arg(args, int);

    bool value = promoted ? true : false;

    _zen_list_push(list, &value);
  }

  return list;
}

ZenList *_sys_argv(int argc, char **argv) {
    ZenList *list = _zen_list_new(sizeof(char *));

    for (int i = 0; i < argc; i++) {
        char *arg = strdup(argv[i]);
        _zen_list_push(list, &arg);
    }

    return list;
}

char *_zen_list_join(ZenList *list, const char *sep) {

  if (list->size == 0) {
    return strdup("");
  }

  size_t total = 1;

  for (int i = 0; i < list->size; i++) {

    char *s = *(char **)_zen_list_get(list, i);

    total += strlen(s);

    if (i != list->size - 1) {
      total += strlen(sep);
    }
  }

  char *result = malloc(total);
  result[0] = '\0';

  for (int i = 0; i < list->size; i++) {

    char *s = *(char **)_zen_list_get(list, i);

    strcat(result, s);

    if (i != list->size - 1) {
      strcat(result, sep);
    }
  }

  return result;
}

// bytes

ZenList *_fs_readFileBytes(const char *path) {

  FILE *f = fopen(path, "rb");
  if (!f) {
    return _zen_list_new(sizeof(uint8_t));
  }

  fseek(f, 0, SEEK_END);
  long size = ftell(f);
  rewind(f);

  ZenList *list = _zen_list_new(sizeof(uint8_t));

  for (long i = 0; i < size; i++) {

    uint8_t b;

    if (fread(&b, 1, 1, f) != 1) {
      break;
    }

    _zen_list_push(list, &b);
  }

  fclose(f);

  return list;
}

void _fs_writeFileBytes(const char *path, ZenList *list) {

  FILE *f = fopen(path, "wb");

  if (!f) {
    return;
  }

  for (int i = 0; i < list->size; i++) {

    uint8_t b = *(uint8_t *)_zen_list_get(list, i);

    fwrite(&b, 1, 1, f);
  }

  fclose(f);
}

bool _zen_list_contains_primitive(ZenList *list, void *value) {
  if (!list || !list->data)
    return false;
  char *base = (char *)list->data;
  for (int i = 0; i < list->size; i++) {
    if (memcmp(base + i * list->element_size, value, list->element_size) == 0)
      return true;
  }
  return false;
}

int _zen_list_indexOf_primitive(ZenList *list, void *value) {
  if (!list || !list->data)
    return -1;
  char *base = (char *)list->data;
  for (int i = 0; i < list->size; i++) {
    if (memcmp(base + i * list->element_size, value, list->element_size) == 0)
      return i;
  }
  return -1;
}

bool _zen_list_contains_string(ZenList *list, char **valuePtr) {
  if (!list || !list->data)
    return false;
  char *value = *valuePtr;
  char **base = (char **)list->data;
  for (int i = 0; i < list->size; i++) {
    if (base[i] == value)
      return true;
    if (base[i] && value && strcmp(base[i], value) == 0)
      return true;
  }
  return false;
}

int _zen_list_indexOf_string(ZenList *list, char **valuePtr) {
  if (!list || !list->data)
    return -1;
  char *value = *valuePtr;
  char **base = (char **)list->data;
  for (int i = 0; i < list->size; i++) {
    if (base[i] == value)
      return i;
    if (base[i] && value && strcmp(base[i], value) == 0)
      return i;
  }
  return -1;
}

// pretty print

enum {
  ZEN_INT = 1,
  ZEN_BOOL,
  ZEN_DOUBLE,
  ZEN_STRING,
  ZEN_LIST,
  ZEN_MAP,
  ZEN_LONG,
  ZEN_BYTE
};

void _debug_pretty_list_impl(ZenList *list, int depth, int deepestType) {
  printf("[");

  for (int i = 0; i < list->size; i++) {

    if (i)
      printf(", ");

    if (depth > 1) {
      ZenList *inner = *(ZenList **)_zen_list_get(list, i);
      _debug_pretty_list_impl(inner, depth - 1, deepestType);
    } else {

      switch (deepestType) {

      case ZEN_INT:
        printf("%d", *(int *)_zen_list_get(list, i));
        break;

      case ZEN_BOOL:
        printf("%s", *(bool *)_zen_list_get(list, i) ? "true" : "false");
        break;

      case ZEN_DOUBLE:
        printf("%g", *(double *)_zen_list_get(list, i));
        break;

      case ZEN_STRING:
        printf("\"%s\"", *(char **)_zen_list_get(list, i));
        break;

      case ZEN_BYTE:
    printf("%u", (unsigned)*(uint8_t *)_zen_list_get(list, i));
    break;

case ZEN_LONG:
    printf("%lld", (long long)*(int64_t *)_zen_list_get(list, i));
    break;

      default:
        printf("<unknown>");
      }
    }
  }

  printf("]");
}

void _debug_pretty_list(ZenList *list, int depth, int deepestType) {
  _debug_pretty_list_impl(list, depth, deepestType);

  printf("\n");
}


typedef void (*ZenPrintFn)(void*);

void _debug_print_indent(int n) {
    for (int i = 0; i < n; i++) {
        printf(" ");
    }
}

void _debug_pretty_list_struct_impl(
    ZenList* list,
    int depth,
    ZenPrintFn printFn
) {
    printf("[");
    printf("\n");

    for (int i = 0; i < list->size; i++) {

      _debug_print_indent(2);

        if (i)
            printf(", ");

        if (depth > 1) {

            ZenList* inner =
                *(ZenList**)_zen_list_get(list, i);

            _debug_pretty_list_struct_impl(
                inner,
                depth - 1,
                printFn
            );

        } else {

            printFn(_zen_list_get(list, i));
        }
        
    }
    
    printf("]");
}

void _debug_pretty_list_struct(ZenList* list, int depth, ZenPrintFn printFn) {
    _debug_pretty_list_struct_impl(list, depth, printFn);
    printf("\n");
}

void _debug_pretty_map(void* map, int depth);

void _debug_pretty_map_elem(void* slot, int depth) {
    void* handle = *(void**)slot;
    _debug_pretty_map(handle, depth);
}

void _zen_list_set_meta(ZenList *list, int depth, int deepestType) {
  list->depth = depth;
  list->deepestType = deepestType;
}


// crypto

static void _crypto_error(const char *msg) {
    fprintf(stderr, "CryptoError: %s\n", msg);
    exit(1);
}

static ZenList *_crypto_bytes_to_list(const unsigned char *data, size_t len) {
    ZenList *list = _zen_list_new(sizeof(uint8_t));

    for (size_t i = 0; i < len; i++) {
        uint8_t byte = data[i];
        _zen_list_push(list, &byte);
    }

    return list;
}

ZenList *_crypto_randomBytes(int length) {
    if (length < 0)
        return _zen_list_new(sizeof(uint8_t));

    ZenList *list = _zen_list_new(sizeof(uint8_t));

    for (int i = 0; i < length; i++) {
        uint8_t byte;

        if (RAND_bytes(&byte, 1) != 1) {
            fprintf(stderr,
                    "[Zen CryptoError]\n"
                    "  └── Failed to generate random bytes\n");
            exit(1);
        }

        _zen_list_push(list, &byte);
    }

    return list;
}

int _crypto_randomInt(int min, int max) {
    if (min >= max)
        _crypto_error("randomInt min must be less than max");

    uint32_t range =
        (uint32_t)max - (uint32_t)min;

    uint32_t threshold =
        (uint32_t)(-range) % range;

    uint32_t value;

    do {
        if (RAND_bytes(
                (unsigned char *)&value,
                sizeof(value)
            ) != 1) {
            _crypto_error("failed to generate random integer");
        }
    } while (value < threshold);

    return min + (int)(value % range);
}

ZenList *_crypto_sha256(const char *data) {
    if (!data)
        _crypto_error("sha256 data cannot be null");

    unsigned char digest[EVP_MAX_MD_SIZE];
    unsigned int digestLen = 0;

    EVP_MD_CTX *ctx = EVP_MD_CTX_new();

    if (!ctx)
        _crypto_error("failed to create SHA-256 context");

    int ok =
        EVP_DigestInit_ex(ctx, EVP_sha256(), NULL) == 1 &&
        EVP_DigestUpdate(ctx, data, strlen(data)) == 1 &&
        EVP_DigestFinal_ex(ctx, digest, &digestLen) == 1;

    EVP_MD_CTX_free(ctx);

    if (!ok)
        _crypto_error("SHA-256 failed");

    return _crypto_bytes_to_list(digest, digestLen);
}

ZenList *_crypto_sha512(const char *data) {
    if (!data)
        _crypto_error("sha512 data cannot be null");

    unsigned char digest[EVP_MAX_MD_SIZE];
    unsigned int digestLen = 0;

    EVP_MD_CTX *ctx = EVP_MD_CTX_new();

    if (!ctx)
        _crypto_error("failed to create SHA-512 context");

    int ok =
        EVP_DigestInit_ex(ctx, EVP_sha512(), NULL) == 1 &&
        EVP_DigestUpdate(ctx, data, strlen(data)) == 1 &&
        EVP_DigestFinal_ex(ctx, digest, &digestLen) == 1;

    EVP_MD_CTX_free(ctx);

    if (!ok)
        _crypto_error("SHA-512 failed");

    return _crypto_bytes_to_list(digest, digestLen);
}

static ZenList *_crypto_hmac(
    const char *key,
    const char *data,
    const EVP_MD *md
) {
    if (!key || !data)
        _crypto_error("HMAC key and data cannot be null");

    unsigned char digest[EVP_MAX_MD_SIZE];
    unsigned int digestLen = 0;

    unsigned char *result = HMAC(
        md,
        key,
        (int)strlen(key),
        (const unsigned char *)data,
        strlen(data),
        digest,
        &digestLen
    );

    if (!result)
        _crypto_error("HMAC failed");

    return _crypto_bytes_to_list(digest, digestLen);
}

ZenList *_crypto_hmacSha256(
    const char *key,
    const char *data
) {
    return _crypto_hmac(key, data, EVP_sha256());
}

ZenList *_crypto_hmacSha512(
    const char *key,
    const char *data
) {
    return _crypto_hmac(key, data, EVP_sha512());
}

static int _crypto_base64_value(char c) {
    if (c >= 'A' && c <= 'Z') return c - 'A';
    if (c >= 'a' && c <= 'z') return c - 'a' + 26;
    if (c >= '0' && c <= '9') return c - '0' + 52;
    if (c == '+') return 62;
    if (c == '/') return 63;

    return -1;
}

static ZenList *_crypto_base64_decode(
    const char *data,
    bool urlSafe
) {
    if (!data) {
        fprintf(stderr,
                "[Zen CryptoError]\n"
                "  └── Base64 data cannot be null\n");
        exit(1);
    }

    size_t len = strlen(data);

    ZenList *list = _zen_list_new(sizeof(uint8_t));

    if (len == 0)
        return list;

    size_t i = 0;

    while (i < len) {
        char c1 = i < len ? data[i++] : '=';
        char c2 = i < len ? data[i++] : '=';
        char c3 = i < len ? data[i++] : '=';
        char c4 = i < len ? data[i++] : '=';

        if (urlSafe) {
            if (c1 == '-') c1 = '+';
            else if (c1 == '_') c1 = '/';

            if (c2 == '-') c2 = '+';
            else if (c2 == '_') c2 = '/';

            if (c3 == '-') c3 = '+';
            else if (c3 == '_') c3 = '/';

            if (c4 == '-') c4 = '+';
            else if (c4 == '_') c4 = '/';
        }

        int a = c1 == '=' ? 0 : _crypto_base64_value(c1);
        int b = c2 == '=' ? 0 : _crypto_base64_value(c2);
        int c = c3 == '=' ? 0 : _crypto_base64_value(c3);
        int d = c4 == '=' ? 0 : _crypto_base64_value(c4);

        if (a < 0 || b < 0 || c < 0 || d < 0) {
            fprintf(stderr,
                    "[Zen CryptoError]\n"
                    "  └── Invalid Base64 data\n");
            exit(1);
        }

        uint32_t triple =
            ((uint32_t)a << 18) |
            ((uint32_t)b << 12) |
            ((uint32_t)c << 6) |
            (uint32_t)d;

        uint8_t byte = (triple >> 16) & 0xff;
        _zen_list_push(list, &byte);

        if (c3 != '=') {
            byte = (triple >> 8) & 0xff;
            _zen_list_push(list, &byte);
        }

        if (c4 != '=') {
            byte = triple & 0xff;
            _zen_list_push(list, &byte);
        }
    }

    return list;
}

ZenList *_crypto_base64Decode(const char *data) {
    return _crypto_base64_decode(data, false);
}

ZenList *_crypto_base64UrlDecode(const char *data) {
    return _crypto_base64_decode(data, true);
}

static const char _crypto_base64_table[] =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    "abcdefghijklmnopqrstuvwxyz"
    "0123456789+/";

static char *_crypto_base64_encode(
    ZenList *list,
    bool urlSafe
) {
  
    if (!list) {
        fprintf(stderr,
                "[Zen CryptoError]\n"
                "  └── Byte list cannot be null\n");
        exit(1);
    }

    if (list->element_size != sizeof(uint8_t)) {
        fprintf(stderr,
                "[Zen CryptoError]\n"
                "  └── Base64 encoding expects List<byte>\n");
        exit(1);
    }

    size_t len = (size_t)list->size;
    size_t outLen = 4 * ((len + 2) / 3);

    char *out = malloc(outLen + 1);

    if (!out) {
        fprintf(stderr,
                "[Zen RuntimeError]\n"
                "  └── Out of memory\n");
        exit(1);
    }

    const uint8_t *data =
        (const uint8_t *)list->data;

    size_t i = 0;
    size_t j = 0;

    while (i < len) {
        size_t remaining = len - i;

        uint32_t a = data[i++];

        uint32_t b = remaining > 1
            ? data[i++]
            : 0;

        uint32_t c = remaining > 2
            ? data[i++]
            : 0;

        uint32_t triple =
            (a << 16) |
            (b << 8) |
            c;

        char c1 =
            _crypto_base64_table[(triple >> 18) & 0x3f];

        char c2 =
            _crypto_base64_table[(triple >> 12) & 0x3f];

        char c3 =
            remaining > 1
                ? _crypto_base64_table[(triple >> 6) & 0x3f]
                : '=';

        char c4 =
            remaining > 2
                ? _crypto_base64_table[triple & 0x3f]
                : '=';

        if (urlSafe) {
            if (c1 == '+') c1 = '-';
            else if (c1 == '/') c1 = '_';

            if (c2 == '+') c2 = '-';
            else if (c2 == '/') c2 = '_';

            if (c3 == '+') c3 = '-';
            else if (c3 == '/') c3 = '_';

            if (c4 == '+') c4 = '-';
            else if (c4 == '/') c4 = '_';
        }

        out[j++] = c1;
        out[j++] = c2;
        out[j++] = c3;
        out[j++] = c4;
    }

    if (urlSafe) {
    while (j > 0 && out[j - 1] == '=') {
        j--;
    }
}

out[j] = '\0';

return out;
}

char *_crypto_base64Encode(ZenList *list) {
    return _crypto_base64_encode(list, false);
}

char *_crypto_base64UrlEncode(ZenList *list) {
    return _crypto_base64_encode(list, true);
}

typedef struct {
    char *buf;
    size_t len;
    size_t cap;
} JsonBuf;

void jbuf_init(JsonBuf *jb) {
    jb->cap = 64;
    jb->len = 0;
    jb->buf = malloc(jb->cap);

    if (!jb->buf) { fprintf(stderr, "[Zen MemoryError]\n  └── Failed to allocate JSON buffer\n"); exit(1); }
    jb->buf[0] = '\0';
}

void jbuf_ensure(JsonBuf *jb, size_t extra) {
    if (jb->len + extra + 1 > jb->cap) {
        while (jb->len + extra + 1 > jb->cap) jb->cap *= 2;
        char *newBuf = realloc(jb->buf, jb->cap);
        if (!newBuf) { fprintf(stderr, "[Zen MemoryError]\n  └── Failed to grow JSON buffer\n"); exit(1); }
        jb->buf = newBuf;
    }
}

void jbuf_append(JsonBuf *jb, const char *s) {
    size_t n = strlen(s);
    jbuf_ensure(jb, n);
    memcpy(jb->buf + jb->len, s, n + 1);
    jb->len += n;
}

void jbuf_append_char(JsonBuf *jb, char c) {
    jbuf_ensure(jb, 1);
    jb->buf[jb->len++] = c;
    jb->buf[jb->len] = '\0';
}

void jbuf_append_json_string(JsonBuf *jb, const char *s) {
    jbuf_append_char(jb, '"');
    for (const unsigned char *p = (const unsigned char *)s; *p; p++) {
        switch (*p) {
            case '"':  jbuf_append(jb, "\\\""); break;
            case '\\': jbuf_append(jb, "\\\\"); break;
            case '\n': jbuf_append(jb, "\\n");  break;
            case '\r': jbuf_append(jb, "\\r");  break;
            case '\t': jbuf_append(jb, "\\t");  break;
            default:
                if (*p < 0x20) {
                    char esc[8];
                    snprintf(esc, sizeof(esc), "\\u%04x", *p);
                    jbuf_append(jb, esc);
                } else {
                    jbuf_append_char(jb, (char)*p);
                }
        }
    }
    jbuf_append_char(jb, '"');
}

void _zen_list_append_json(JsonBuf *jb, ZenList *list, int depth, int deepestType) {
    jbuf_append_char(jb, '[');

    for (int i = 0; i < list->size; i++) {
        if (i) jbuf_append_char(jb, ',');

        if (depth > 1) {
            ZenList *inner = *(ZenList **)_zen_list_get(list, i);
            _zen_list_append_json(jb, inner, depth - 1, deepestType);
        } else {
            char numBuf[64];

            switch (deepestType) {
                case ZEN_INT:
                    snprintf(numBuf, sizeof(numBuf), "%d", *(int *)_zen_list_get(list, i));
                    jbuf_append(jb, numBuf);
                    break;
                case ZEN_BOOL:
                    jbuf_append(jb, *(bool *)_zen_list_get(list, i) ? "true" : "false");
                    break;
                case ZEN_DOUBLE:
                    snprintf(numBuf, sizeof(numBuf), "%g", *(double *)_zen_list_get(list, i));
                    jbuf_append(jb, numBuf);
                    break;
                case ZEN_STRING:
                    jbuf_append_json_string(jb, *(char **)_zen_list_get(list, i));
                    break;
                case ZEN_BYTE:
                    snprintf(numBuf, sizeof(numBuf), "%u", (unsigned)*(uint8_t *)_zen_list_get(list, i));
                    jbuf_append(jb, numBuf);
                    break;
                case ZEN_LONG:
                    snprintf(numBuf, sizeof(numBuf), "%" PRId64, *(int64_t *)_zen_list_get(list, i));
                    jbuf_append(jb, numBuf);
                    break;
                default:
                    jbuf_append(jb, "null");
            }
        }
    }

    jbuf_append_char(jb, ']');
}