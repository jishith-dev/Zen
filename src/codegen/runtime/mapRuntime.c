
#include <stdint.h>

#ifdef _WIN32
#define strdup _strdup
#endif

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INITIAL_CAPACITY 8

#define INT2PTR(x) ((void *)(intptr_t)(x))
#define PTR2INT(x) ((int)(intptr_t)(x))

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

typedef struct ZenList ZenList;

typedef struct {
  char *key;
  void *value;
  int type;
  int depth;
  int deepestType;
} MapEntry;

typedef struct {
  MapEntry *entries;
  int count;
  int capacity;
} ZenMap;

static void zen_error(const char *type, const char *msg) {
  fprintf(stderr, "\033[1;31m[Zen  %s]\n  └── %s\033[0m\n", type, msg);
  exit(1);
}

static void zen_errorf(const char *type, const char *fmt, const char *arg) {
  fprintf(stderr, "\033[1;31m[Zen  %s]\n  └── ", type);
  fprintf(stderr, fmt, arg);
  fprintf(stderr, "\033[0m\n");
  exit(1);
}

static void _zen_map_check_alive(ZenMap *map) {
  if (!map)
    zen_error("MemoryError", "Map is null");
    
}

void _debug_print_indent(int n);
void _debug_pretty_list_impl(ZenList *list, int depth, int deepestType);
void _zen_list_free(ZenList *list);
void _zen_map_free_internal(ZenMap *map);

ZenMap *_zen_map_new() {
  ZenMap *map = malloc(sizeof(ZenMap));
  if (!map)
    zen_error("MemoryError", "Failed to allocate memory for Map");

  map->count = 0;
  map->capacity = INITIAL_CAPACITY;
  map->entries = calloc(map->capacity, sizeof(MapEntry));
  if (!map->entries)
    zen_error("MemoryError", "Failed to allocate memory for Map entries");

  return map;
}

void _zen_map_resize(ZenMap *map) {
  _zen_map_check_alive(map);

  int newCapacity = map->capacity * 2;
  MapEntry *newEntries =
      realloc(map->entries, sizeof(MapEntry) * newCapacity);

  if (!newEntries)
    zen_error("MemoryError", "Failed to allocate memory for Map — realloc failed");

  map->entries = newEntries;
  map->capacity = newCapacity;
}

const char *_zen_type_name(int type) {
  switch (type) {
    case ZEN_INT: return "Int";
    case ZEN_BOOL: return "Bool";
    case ZEN_DOUBLE: return "Double";
    case ZEN_STRING: return "String";
    case ZEN_LIST: return "List";
    case ZEN_MAP: return "Map";
    case ZEN_LONG: return "Long";
    case ZEN_BYTE: return "Byte";
    default: return "Unknown";
  }
}

void _zen_map_free_value(int type, void *value) {
  if (!value) return;

  switch (type) {
    case ZEN_INT:
    case ZEN_BOOL:
    case ZEN_DOUBLE:
    case ZEN_STRING:
    case ZEN_LONG:
    case ZEN_BYTE:
      free(value);
      break;

    case ZEN_LIST:
      _zen_list_free((ZenList *)value);
      break;

    case ZEN_MAP:
      _zen_map_free_internal((ZenMap *)value);
      break;

    default:
      break;
  }
}

MapEntry *_zen_map_find(ZenMap *map, char *key) {
  for (int i = 0; i < map->count; i++) {
    if (strcmp(map->entries[i].key, key) == 0) {
      return &map->entries[i];
    }
  }
  return NULL;
}

MapEntry *_zen_map_get_entry(ZenMap *map, char *key) {
  _zen_map_check_alive(map);

  MapEntry *e = _zen_map_find(map, key);

  if (!e)
    zen_errorf("ReferenceError", "Key '%s' is not defined in Map", key);

  return e;
}

void _zen_map_expect_type(char *key, MapEntry *e, int expected) {
  if (e->type != expected) {
    fprintf(stderr,
            "\033[1;31m[Zen  TypeError]\n  └── Key '%s' is %s, not %s\033[0m\n",
            key, _zen_type_name(e->type), _zen_type_name(expected));
    exit(1);
  }
}

void _zen_map_set(ZenMap *map, char *key, void *value, int type, int depth,
                  int deepestType) {
  _zen_map_check_alive(map);

  if (!key)
    zen_error("TypeError", "Map key cannot be null");

  MapEntry *e = _zen_map_find(map, key);

  if (e) {
    _zen_map_free_value(e->type, e->value);

    e->value = value;
    e->type = type;
    e->depth = depth;
    e->deepestType = deepestType;

    return;
  }

  if (map->count >= map->capacity) {
    _zen_map_resize(map);
  }

  char *dupKey = strdup(key);
  if (!dupKey)
    zen_error("MemoryError", "Failed to allocate memory for Map key");

  map->entries[map->count].key = dupKey;
  map->entries[map->count].value = value;
  map->entries[map->count].type = type;
  map->entries[map->count].depth = depth;
  map->entries[map->count].deepestType = deepestType;

  map->count++;
}

void *_zen_map_get(ZenMap *map, char *key) {
  return _zen_map_get_entry(map, key)->value;
}

bool _zen_map_has(ZenMap *map, char *key) {
  _zen_map_check_alive(map);
  return _zen_map_find(map, key) != NULL;
}

void _zen_map_remove(ZenMap *map, char *key) {
  _zen_map_check_alive(map);

  for (int i = 0; i < map->count; i++) {
    if (strcmp(map->entries[i].key, key) == 0) {
      free(map->entries[i].key);
      _zen_map_free_value(map->entries[i].type, map->entries[i].value);

      for (int j = i; j < map->count - 1; j++) {
        map->entries[j] = map->entries[j + 1];
      }

      map->count--;
      return;
    }
  }

  zen_errorf("ReferenceError", "Key '%s' is not defined in Map", key);
}

void _zen_map_free_internal(ZenMap *map) {
    if (!map) return;

    for (int i = 0; i < map->count; i++) {
        free(map->entries[i].key);
        _zen_map_free_value(map->entries[i].type,
                            map->entries[i].value);
    }

    free(map->entries);
    free(map);
}

void _zen_map_free(ZenMap *map) {
  _zen_map_check_alive(map);
  _zen_map_free_internal(map);
}

int zen_map_get_type(ZenMap *map, char *key) {
  return _zen_map_get_entry(map, key)->type;
}

void zen_map_set_int(ZenMap *map, char *key, int value) {
  int *v = malloc(sizeof(int));
  if (!v)
    zen_error("MemoryError", "Failed to allocate memory for Int value");
  *v = value;
  _zen_map_set(map, key, v, ZEN_INT, 0, 0);
}

void zen_map_set_long(ZenMap *map, char *key, long value) {
  long *v = malloc(sizeof(long));
  if (!v)
    zen_error("MemoryError", "Failed to allocate memory for Long value");

  *v = value;
  _zen_map_set(map, key, v, ZEN_LONG, 0, 0);
}

void zen_map_set_byte(ZenMap *map, char *key, unsigned char value) {
  unsigned char *v = malloc(sizeof(unsigned char));
  if (!v)
    zen_error("MemoryError", "Failed to allocate memory for Byte value");

  *v = value;
  _zen_map_set(map, key, v, ZEN_BYTE, 0, 0);
}

void zen_map_set_bool(ZenMap *map, char *key, bool value) {
  bool *v = malloc(sizeof(bool));
  if (!v)
    zen_error("MemoryError", "Failed to allocate memory for Bool value");
  *v = value;
  _zen_map_set(map, key, v, ZEN_BOOL, 0, 0);
}

void zen_map_set_double(ZenMap *map, char *key, double value) {
  double *v = malloc(sizeof(double));
  if (!v)
    zen_error("MemoryError", "Failed to allocate memory for Double value");
  *v = value;
  _zen_map_set(map, key, v, ZEN_DOUBLE, 0, 0);
}

void zen_map_set_string(ZenMap *map, char *key, char *value) {
  if (!value)
    zen_error("TypeError", "Cannot set null String value in Map");

  char *dupValue = strdup(value);
  if (!dupValue)
    zen_error("MemoryError", "Failed to allocate memory for String value");

  _zen_map_set(map, key, dupValue, ZEN_STRING, 0, 0);
}

void zen_map_set_list(ZenMap *map, char *key, ZenList *value, int depth,
                       int deepestType) {
  if (!value)
    zen_error("TypeError", "Cannot set null List value in Map");

  _zen_map_set(map, key, value, ZEN_LIST, depth, deepestType);
}

long zen_map_get_long(ZenMap *map, char *key) {
  MapEntry *e = _zen_map_get_entry(map, key);
  _zen_map_expect_type(key, e, ZEN_LONG);
  return *(long *)e->value;
}

unsigned char zen_map_get_byte(ZenMap *map, char *key) {
  MapEntry *e = _zen_map_get_entry(map, key);
  _zen_map_expect_type(key, e, ZEN_BYTE);
  return *(unsigned char *)e->value;
}

void zen_map_set_map(ZenMap *map, char *key, ZenMap *value) {
  if (!value)
    zen_error("TypeError", "Cannot set null Map value in Map");
  
  if (value == map)
    zen_error("TypeError", "Map cannot contain itself");

  _zen_map_set(map, key, value, ZEN_MAP, 0, 0);
}

int zen_map_get_int(ZenMap *map, char *key) {
  MapEntry *e = _zen_map_get_entry(map, key);
  _zen_map_expect_type(key, e, ZEN_INT);
  return *(int *)e->value;
}

bool zen_map_get_bool(ZenMap *map, char *key) {
  MapEntry *e = _zen_map_get_entry(map, key);
  _zen_map_expect_type(key, e, ZEN_BOOL);
  return *(bool *)e->value;
}

double zen_map_get_double(ZenMap *map, char *key) {
  MapEntry *e = _zen_map_get_entry(map, key);
  _zen_map_expect_type(key, e, ZEN_DOUBLE);
  return *(double *)e->value;
}

char *zen_map_get_string(ZenMap *map, char *key) {
  MapEntry *e = _zen_map_get_entry(map, key);
  _zen_map_expect_type(key, e, ZEN_STRING);
  return (char *)e->value;
}

ZenList *zen_map_get_list(ZenMap *map, char *key) {
  MapEntry *e = _zen_map_get_entry(map, key);
  _zen_map_expect_type(key, e, ZEN_LIST);
  return (ZenList *)e->value;
}

ZenMap *zen_map_get_map(ZenMap *map, char *key) {
  MapEntry *e = _zen_map_get_entry(map, key);
  _zen_map_expect_type(key, e, ZEN_MAP);
  ZenMap *child = (ZenMap *)e->value;
  _zen_map_check_alive(child);
  return child;
}

void _debug_pretty_map(ZenMap *map, int indent) {
  _zen_map_check_alive(map);

  printf("{\n");

  int fieldIndent = indent + 2;

  for (int i = 0; i < map->count; i++) {
    MapEntry *e = &map->entries[i];

    _debug_print_indent(fieldIndent);
    printf("%s: ", e->key);

    switch (e->type) {
      case ZEN_INT:
        printf("%d", *(int *)e->value);
        break;

      case ZEN_BOOL:
        printf("%s", *(bool *)e->value ? "true" : "false");
        break;

      case ZEN_DOUBLE:
        printf("%g", *(double *)e->value);
        break;

      case ZEN_STRING:
        printf("\"%s\"", (char *)e->value);
        break;

      case ZEN_LONG:
  printf("%ld", *(long *)e->value);
  break;

case ZEN_BYTE:
  printf("%u", (unsigned int)*(unsigned char *)e->value);
  break;

      case ZEN_LIST:
        _debug_pretty_list_impl((ZenList *)e->value, e->depth,
                                 e->deepestType);
        break;

      case ZEN_MAP:
        _debug_pretty_map((ZenMap *)e->value, fieldIndent);
        break;

      default:
        printf("<unknown>");
    }

    if (i != map->count - 1) printf(",");

    printf("\n");
  }

  _debug_print_indent(indent);
  printf("}\n");
}

typedef struct {
    char *buf;
    size_t len;
    size_t cap;
} JsonBuf;

// implemented in the list runtime file
void jbuf_append(JsonBuf *jb, const char *s);
void jbuf_append_char(JsonBuf *jb, char c);
void jbuf_append_json_string(JsonBuf *jb, const char *s);
void jbuf_init(JsonBuf *jb);
void _zen_list_append_json(JsonBuf *jb, ZenList *list, int depth, int deepestType);

static void _zen_map_value_to_json(JsonBuf *jb, int type, void *value, int depth, int deepestType) {
    char numBuf[64];

    if (!value) {
        jbuf_append(jb, "null");
        return;
    }

    switch (type) {
        case ZEN_INT:
            snprintf(numBuf, sizeof(numBuf), "%d", *(int *)value);
            jbuf_append(jb, numBuf);
            break;
        case ZEN_LONG:
            snprintf(numBuf, sizeof(numBuf), "%ld", *(long *)value);
            jbuf_append(jb, numBuf);
            break;
        case ZEN_BYTE:
            snprintf(numBuf, sizeof(numBuf), "%u", (unsigned int)*(unsigned char *)value);
            jbuf_append(jb, numBuf);
            break;
        case ZEN_BOOL:
            jbuf_append(jb, *(bool *)value ? "true" : "false");
            break;
        case ZEN_DOUBLE:
            snprintf(numBuf, sizeof(numBuf), "%g", *(double *)value);
            jbuf_append(jb, numBuf);
            break;
        case ZEN_STRING:
            jbuf_append_json_string(jb, (char *)value);
            break;
        case ZEN_MAP: {
            ZenMap *child = (ZenMap *)value;
            _zen_map_check_alive(child);
            jbuf_append_char(jb, '{');
            for (int i = 0; i < child->count; i++) {
                MapEntry *e = &child->entries[i];
                jbuf_append_json_string(jb, e->key);
                jbuf_append_char(jb, ':');
                _zen_map_value_to_json(jb, e->type, e->value, e->depth, e->deepestType);
                if (i != child->count - 1) jbuf_append_char(jb, ',');
            }
            jbuf_append_char(jb, '}');
            break;
        }
        case ZEN_LIST:
            _zen_list_append_json(jb, (ZenList *)value, depth, deepestType);
            break;
        default:
            jbuf_append(jb, "null");
    }
}

char *zen_map_json(ZenMap *map) {
    _zen_map_check_alive(map);

    JsonBuf jb;
    jbuf_init(&jb);

    jbuf_append_char(&jb, '{');
    for (int i = 0; i < map->count; i++) {
        MapEntry *e = &map->entries[i];
        jbuf_append_json_string(&jb, e->key);
        jbuf_append_char(&jb, ':');
        _zen_map_value_to_json(&jb, e->type, e->value, e->depth, e->deepestType);
        if (i != map->count - 1) jbuf_append_char(&jb, ',');
    }
    jbuf_append_char(&jb, '}');

    return jb.buf;
}
