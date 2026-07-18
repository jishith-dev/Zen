#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum {
  ZEN_JSON_NULL,
  ZEN_JSON_BOOL,
  ZEN_JSON_INT,
  ZEN_JSON_DOUBLE,
  ZEN_JSON_STRING,
  ZEN_JSON_ARRAY,
  ZEN_JSON_OBJECT
} ZenJsonType;

typedef struct ZenJson ZenJson;

typedef struct {
  ZenJson **items;
  size_t count;
  size_t cap;
} ZenJsonArray;

typedef struct {
  char **keys;
  ZenJson **values;
  size_t count;
  size_t cap;
} ZenJsonObject;

struct ZenJson {
  ZenJsonType type;
  union {
    int b;
    int i;
    double d;
    char *s;
    ZenJsonArray arr;
    ZenJsonObject obj;
  } as;
};

static void zen_error(const char *type, const char *msg) {
  fprintf(stderr, "\033[1;31m[Zen  %s]\n  └── %s\033[0m\n", type, msg);
  exit(1);
}

static void json_check_alive(ZenJson *j) {
  if (!j)
    zen_error("MemoryError", "Json is null");
}

static ZenJson *json_new(ZenJsonType type) {
  ZenJson *j = malloc(sizeof(ZenJson));
  if (!j)
    zen_error("MemoryError", "Failed to allocate memory for Json node");

  j->type = type;
  return j;
}

typedef struct {
  const char *src;
  size_t pos;
  size_t len;
} JsonParser;

static void skip_ws(JsonParser *p) {
  while (p->pos < p->len) {
    char c = p->src[p->pos];
    if (c == ' ' || c == '\t' || c == '\n' || c == '\r')
      p->pos++;
    else
      break;
  }
}

static ZenJson *parse_value(JsonParser *p);

static void parse_fail(JsonParser *p, const char *what) {
  char buf[256];
  snprintf(buf, sizeof(buf), "Invalid JSON: expected %s at position %zu", what,
           p->pos);
  zen_error("JsonError", buf);
}

static char *parse_raw_string(JsonParser *p) {
  if (p->src[p->pos] != '"')
    parse_fail(p, "'\"'");
  p->pos++;

  size_t start = p->pos;
  size_t cap = 32;
  size_t len = 0;
  char *buf = malloc(cap);
  if (!buf)
    zen_error("MemoryError", "Failed to allocate memory for Json string");

  while (p->pos < p->len && p->src[p->pos] != '"') {
    char c = p->src[p->pos];

    if (c == '\\') {
      p->pos++;
      if (p->pos >= p->len)
        parse_fail(p, "escape sequence");
      char esc = p->src[p->pos];
      char out;

      switch (esc) {
      case '"':
        out = '"';
        break;
      case '\\':
        out = '\\';
        break;
      case '/':
        out = '/';
        break;
      case 'n':
        out = '\n';
        break;
      case 't':
        out = '\t';
        break;
      case 'r':
        out = '\r';
        break;
      case 'b':
        out = '\b';
        break;
      case 'f':
        out = '\f';
        break;
      case 'u': {
        if (p->pos + 4 >= p->len)
          parse_fail(p, "unicode escape");
        char hex[5] = {p->src[p->pos + 1], p->src[p->pos + 2],
                       p->src[p->pos + 3], p->src[p->pos + 4], 0};
        int code = (int)strtol(hex, NULL, 16);
        p->pos += 4;
        out = (code < 128) ? (char)code : '?';
        break;
      }
      default:
        parse_fail(p, "valid escape character");
        out = 0;
      }

      if (len + 1 >= cap) {
        cap *= 2;
        char *tmp = realloc(buf, cap);
        if (!tmp)
          zen_error("MemoryError", "Failed to allocate memory for Json string");
        buf = tmp;
      }
      buf[len++] = out;
      p->pos++;
    } else {
      if (len + 1 >= cap) {
        cap *= 2;
        char *tmp = realloc(buf, cap);
        if (!tmp)
          zen_error("MemoryError", "Failed to allocate memory for Json string");
        buf = tmp;
      }
      buf[len++] = c;
      p->pos++;
    }
  }

  if (p->pos >= p->len)
    parse_fail(p, "closing '\"'");
  p->pos++;

  buf[len] = '\0';
  (void)start;
  return buf;
}

static ZenJson *parse_string(JsonParser *p) {
  ZenJson *j = json_new(ZEN_JSON_STRING);
  j->as.s = parse_raw_string(p);
  return j;
}

static ZenJson *parse_number(JsonParser *p) {
  size_t start = p->pos;
  int is_double = 0;

  if (p->src[p->pos] == '-')
    p->pos++;
  while (p->pos < p->len && isdigit((unsigned char)p->src[p->pos]))
    p->pos++;

  if (p->pos < p->len && p->src[p->pos] == '.') {
    is_double = 1;
    p->pos++;
    while (p->pos < p->len && isdigit((unsigned char)p->src[p->pos]))
      p->pos++;
  }

  if (p->pos < p->len && (p->src[p->pos] == 'e' || p->src[p->pos] == 'E')) {
    is_double = 1;
    p->pos++;
    if (p->pos < p->len && (p->src[p->pos] == '+' || p->src[p->pos] == '-'))
      p->pos++;
    while (p->pos < p->len && isdigit((unsigned char)p->src[p->pos]))
      p->pos++;
  }

  size_t numlen = p->pos - start;
  char *numbuf = malloc(numlen + 1);
  if (!numbuf)
    zen_error("MemoryError", "Failed to allocate memory for Json number");
  memcpy(numbuf, p->src + start, numlen);
  numbuf[numlen] = '\0';

  ZenJson *j;
  if (is_double) {
    j = json_new(ZEN_JSON_DOUBLE);
    j->as.d = strtod(numbuf, NULL);
  } else {
    j = json_new(ZEN_JSON_INT);
    j->as.i = strtoll(numbuf, NULL, 10);
  }

  free(numbuf);
  return j;
}

static ZenJson *parse_array(JsonParser *p) {
  p->pos++;
  ZenJson *j = json_new(ZEN_JSON_ARRAY);
  j->as.arr.items = NULL;
  j->as.arr.count = 0;
  j->as.arr.cap = 0;

  skip_ws(p);
  if (p->pos < p->len && p->src[p->pos] == ']') {
    p->pos++;
    return j;
  }

  while (1) {
    skip_ws(p);
    ZenJson *item = parse_value(p);

    if (j->as.arr.count + 1 >= j->as.arr.cap) {
      j->as.arr.cap = j->as.arr.cap ? j->as.arr.cap * 2 : 4;
      ZenJson **tmp =
          realloc(j->as.arr.items, j->as.arr.cap * sizeof(ZenJson *));
      if (!tmp)
        zen_error("MemoryError", "Failed to allocate memory for Json array");
      j->as.arr.items = tmp;
    }
    j->as.arr.items[j->as.arr.count++] = item;

    skip_ws(p);
    if (p->pos >= p->len)
      parse_fail(p, "',' or ']'");

    if (p->src[p->pos] == ',') {
      p->pos++;
      continue;
    }
    if (p->src[p->pos] == ']') {
      p->pos++;
      break;
    }
    parse_fail(p, "',' or ']'");
  }

  return j;
}

static ZenJson *parse_object(JsonParser *p) {
  p->pos++;
  ZenJson *j = json_new(ZEN_JSON_OBJECT);
  j->as.obj.keys = NULL;
  j->as.obj.values = NULL;
  j->as.obj.count = 0;
  j->as.obj.cap = 0;

  skip_ws(p);
  if (p->pos < p->len && p->src[p->pos] == '}') {
    p->pos++;
    return j;
  }

  while (1) {
    skip_ws(p);
    if (p->pos >= p->len || p->src[p->pos] != '"')
      parse_fail(p, "string key");
    char *key = parse_raw_string(p);

    skip_ws(p);
    if (p->pos >= p->len || p->src[p->pos] != ':')
      parse_fail(p, "':'");
    p->pos++;

    skip_ws(p);
    ZenJson *val = parse_value(p);

    if (j->as.obj.count + 1 >= j->as.obj.cap) {
      j->as.obj.cap = j->as.obj.cap ? j->as.obj.cap * 2 : 4;
      char **ktmp = realloc(j->as.obj.keys, j->as.obj.cap * sizeof(char *));
      ZenJson **vtmp =
          realloc(j->as.obj.values, j->as.obj.cap * sizeof(ZenJson *));
      if (!ktmp || !vtmp)
        zen_error("MemoryError", "Failed to allocate memory for Json object");
      j->as.obj.keys = ktmp;
      j->as.obj.values = vtmp;
    }
    j->as.obj.keys[j->as.obj.count] = key;
    j->as.obj.values[j->as.obj.count] = val;
    j->as.obj.count++;

    skip_ws(p);
    if (p->pos >= p->len)
      parse_fail(p, "',' or '}'");

    if (p->src[p->pos] == ',') {
      p->pos++;
      continue;
    }
    if (p->src[p->pos] == '}') {
      p->pos++;
      break;
    }
    parse_fail(p, "',' or '}'");
  }

  return j;
}

static ZenJson *parse_value(JsonParser *p) {
  skip_ws(p);
  if (p->pos >= p->len)
    parse_fail(p, "value");

  char c = p->src[p->pos];

  if (c == '"')
    return parse_string(p);
  if (c == '{')
    return parse_object(p);
  if (c == '[')
    return parse_array(p);
  if (c == '-' || isdigit((unsigned char)c))
    return parse_number(p);

  if (strncmp(p->src + p->pos, "true", 4) == 0) {
    p->pos += 4;
    ZenJson *j = json_new(ZEN_JSON_BOOL);
    j->as.b = 1;
    return j;
  }
  if (strncmp(p->src + p->pos, "false", 5) == 0) {
    p->pos += 5;
    ZenJson *j = json_new(ZEN_JSON_BOOL);
    j->as.b = 0;
    return j;
  }
  if (strncmp(p->src + p->pos, "null", 4) == 0) {
    p->pos += 4;
    return json_new(ZEN_JSON_NULL);
  }

  parse_fail(p, "value");
  return NULL;
}

ZenJson *_zen_json_parse(const char *str) {
  if (!str)
    zen_error("JsonError", "Cannot parse null string as Json");

  JsonParser p = {str, 0, strlen(str)};
  ZenJson *result = parse_value(&p);

  skip_ws(&p);
  if (p.pos != p.len)
    zen_error("JsonError", "Trailing data after Json value");

  return result;
}

static ZenJson *json_lookup(ZenJson *obj, const char *key) {
  if (obj->type != ZEN_JSON_OBJECT) {
    char buf[256];
    snprintf(buf, sizeof(buf),
             "Cannot get key '%s': value is not a Json object", key);
    zen_error("JsonError", buf);
  }

  for (size_t i = 0; i < obj->as.obj.count; i++) {
    if (strcmp(obj->as.obj.keys[i], key) == 0) {
      return obj->as.obj.values[i];
    }
  }

  char buf[256];
  snprintf(buf, sizeof(buf), "Key '%s' not found in Json object", key);
  zen_error("JsonError", buf);
  return NULL;
}

static void expect_type(ZenJson *j, ZenJsonType want, const char *key,
                        const char *typeName) {
  if (j->type != want) {
    char buf[256];
    snprintf(buf, sizeof(buf), "Expected %s for key '%s'", typeName, key);
    zen_error("JsonError", buf);
  }
}

int _zen_json_getInt(ZenJson *obj, const char *key) {
  json_check_alive(obj);
  ZenJson *v = json_lookup(obj, key);
  expect_type(v, ZEN_JSON_INT, key, "int");
  return v->as.i;
}

double _zen_json_getDouble(ZenJson *obj, const char *key) {
  json_check_alive(obj);
  ZenJson *v = json_lookup(obj, key);
  if (v->type == ZEN_JSON_INT)
    return (double)v->as.i;
  expect_type(v, ZEN_JSON_DOUBLE, key, "double");
  return v->as.d;
}

int _zen_json_getBool(ZenJson *obj, const char *key) {
  json_check_alive(obj);
  ZenJson *v = json_lookup(obj, key);
  expect_type(v, ZEN_JSON_BOOL, key, "bool");
  return v->as.b;
}

char *_zen_json_getString(ZenJson *obj, const char *key) {
  json_check_alive(obj);
  ZenJson *v = json_lookup(obj, key);
  expect_type(v, ZEN_JSON_STRING, key, "string");

  size_t len = strlen(v->as.s);
  char *copy = malloc(len + 1);
  if (!copy)
    zen_error("MemoryError", "Failed to allocate memory for Json string");
  memcpy(copy, v->as.s, len + 1);
  return copy;
}

ZenJson *_zen_json_getArray(ZenJson *obj, const char *key) {
  json_check_alive(obj);
  ZenJson *v = json_lookup(obj, key);
  expect_type(v, ZEN_JSON_ARRAY, key, "array");
  return v;
}

ZenJson *_zen_json_getObject(ZenJson *obj, const char *key) {
  json_check_alive(obj);
  ZenJson *v = json_lookup(obj, key);
  expect_type(v, ZEN_JSON_OBJECT, key, "object");
  return v;
}

int _zen_json_has(ZenJson *obj, const char *key) {
  json_check_alive(obj);
  if (obj->type != ZEN_JSON_OBJECT)
    return 0;

  for (size_t i = 0; i < obj->as.obj.count; i++) {
    if (strcmp(obj->as.obj.keys[i], key) == 0)
      return 1;
  }
  return 0;
}

int _zen_json_isNull(ZenJson *obj) {
  json_check_alive(obj);
  return obj->type == ZEN_JSON_NULL;
}

int _zen_json_arrayLength(ZenJson *arr) {
  json_check_alive(arr);
  if (arr->type != ZEN_JSON_ARRAY)
    zen_error("JsonError", "Value is not a Json array");
  return (int)arr->as.arr.count;
}

static ZenJson *array_at(ZenJson *arr, int index) {
  if (arr->type != ZEN_JSON_ARRAY)
    zen_error("JsonError", "Value is not a Json array");
  if (index < 0 || (size_t)index >= arr->as.arr.count) {
    char buf[256];
    snprintf(buf, sizeof(buf), "Json array index %d out of bounds (length %zu)",
             index, arr->as.arr.count);
    zen_error("JsonError", buf);
  }
  return arr->as.arr.items[index];
}

int _zen_json_arrayGetInt(ZenJson *arr, int index) {
  json_check_alive(arr);
  ZenJson *v = array_at(arr, index);
  if (v->type != ZEN_JSON_INT)
    zen_error("JsonError", "Expected int in Json array");
  return v->as.i;
}

double _zen_json_arrayGetDouble(ZenJson *arr, int index) {
  json_check_alive(arr);
  ZenJson *v = array_at(arr, index);
  if (v->type == ZEN_JSON_INT)
    return (double)v->as.i;
  if (v->type != ZEN_JSON_DOUBLE)
    zen_error("JsonError", "Expected double in Json array");
  return v->as.d;
}

int _zen_json_arrayGetBool(ZenJson *arr, int index) {
  json_check_alive(arr);
  ZenJson *v = array_at(arr, index);
  if (v->type != ZEN_JSON_BOOL)
    zen_error("JsonError", "Expected bool in Json array");
  return v->as.b;
}

char *_zen_json_arrayGetString(ZenJson *arr, int index) {
  json_check_alive(arr);
  ZenJson *v = array_at(arr, index);
  if (v->type != ZEN_JSON_STRING)
    zen_error("JsonError", "Expected string in Json array");

  size_t len = strlen(v->as.s);
  char *copy = malloc(len + 1);
  if (!copy)
    zen_error("MemoryError", "Failed to allocate memory for Json string");
  memcpy(copy, v->as.s, len + 1);
  return copy;
}

ZenJson *_zen_json_arrayGetObject(ZenJson *arr, int index) {
  json_check_alive(arr);
  ZenJson *v = array_at(arr, index);
  if (v->type != ZEN_JSON_OBJECT)
    zen_error("JsonError", "Expected object in Json array");
  return v;
}

ZenJson *_zen_json_arrayGetArray(ZenJson *arr, int index) {
  json_check_alive(arr);
  ZenJson *v = array_at(arr, index);
  if (v->type != ZEN_JSON_ARRAY)
    zen_error("JsonError", "Expected array in Json array");
  return v;
}

void _zen_json_free(ZenJson *j) {
  if (!j)
    return;

  switch (j->type) {
  case ZEN_JSON_STRING:
    free(j->as.s);
    break;
  case ZEN_JSON_ARRAY:
    for (size_t i = 0; i < j->as.arr.count; i++) {
      _zen_json_free(j->as.arr.items[i]);
    }
    free(j->as.arr.items);
    break;
  case ZEN_JSON_OBJECT:
    for (size_t i = 0; i < j->as.obj.count; i++) {
      free(j->as.obj.keys[i]);
      _zen_json_free(j->as.obj.values[i]);
    }
    free(j->as.obj.keys);
    free(j->as.obj.values);
    break;
  default:
    break;
  }

  free(j);
}

// root accessor

ZenJson *_zen_json_getRootArray(ZenJson *json) {
  json_check_alive(json);
  if (json->type != ZEN_JSON_ARRAY) {
    zen_error("JsonError", "Root value is not a Json array");
  }

  return json;
}

ZenJson *_zen_json_getRootObject(ZenJson *json) {
  json_check_alive(json);
  if (json->type != ZEN_JSON_OBJECT) {
    zen_error("JsonError", "Root value is not a Json object");
  }

  return json;
}