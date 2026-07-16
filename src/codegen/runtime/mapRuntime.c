

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INITIAL_CAPACITY 8

#define INT2PTR(x) ((void *)(long)(x))
#define PTR2INT(x) ((int)(long)(x))

typedef struct {

  char *key;
  void *value;
  int type;

  // Only used when type == ZEN_LIST
  int depth;
  int deepestType;
} MapEntry;

typedef struct {

  MapEntry *entries;

  int count;
  int capacity;

} ZenMap;

ZenMap *_zen_map_new() {

  ZenMap *map = malloc(sizeof(ZenMap));

  map->count = 0;
  map->capacity = INITIAL_CAPACITY;

  map->entries = calloc(map->capacity, sizeof(MapEntry));

  return map;
}

void _zen_map_resize(ZenMap *map) {

  map->capacity *= 2;

  map->entries = realloc(map->entries, sizeof(MapEntry) * map->capacity);

  if (!map->entries) {
    fprintf(stderr, "\033[1;31m[Zen  MemoryError]\n  └── Failed to allocate "
                    "memory for Map — realloc failed\033[0m\n");
    exit(1);
  }
}

void _zen_map_set(ZenMap *map, char *key, void *value, int type, int depth,
                  int deepestType) {
  for (int i = 0; i < map->count; i++) {

    if (strcmp(map->entries[i].key, key) == 0) {

      map->entries[i].value = value;
      map->entries[i].type = type;
      map->entries[i].depth = depth;
      map->entries[i].deepestType = deepestType;

      return;
    }
  }

  if (map->count >= map->capacity) {
    _zen_map_resize(map);
  }

  map->entries[map->count].key = strdup(key);
  map->entries[map->count].value = value;
  map->entries[map->count].type = type;
  map->entries[map->count].depth = depth;
  map->entries[map->count].deepestType = deepestType;

  map->count++;
}

void *_zen_map_get(ZenMap *map, char *key) {

  for (int i = 0; i < map->count; i++) {

    if (strcmp(map->entries[i].key, key) == 0) {

      return map->entries[i].value;
    }
  }

  fprintf(stderr,
          "\033[1;31m[Zen  ReferenceError]\n  └── Key '%s' is not defined in "
          "Map\033[0m\n",
          key);
  exit(1);
}

bool _zen_map_has(ZenMap *map, char *key) {
  for (int i = 0; i < map->count; i++) {
    if (strcmp(map->entries[i].key, key) == 0) {
      return true;
    }
  }
  return false;
}

void _zen_map_remove(ZenMap *map, char *key) {

  for (int i = 0; i < map->count; i++) {

    if (strcmp(map->entries[i].key, key) == 0) {

      free(map->entries[i].key);

      // shift left
      for (int j = i; j < map->count - 1; j++) {

        map->entries[j] = map->entries[j + 1];
      }

      map->count--;

      return;
    }
  }
}

void _zen_map_free(ZenMap *map) {

  for (int i = 0; i < map->count; i++) {

    free(map->entries[i].key);
  }

  free(map->entries);

  free(map);
}

// pretty print

typedef struct ZenList ZenList;

void _debug_pretty_list_impl(ZenList *list, int depth, int deepestType);

enum { ZEN_INT = 1, ZEN_BOOL, ZEN_DOUBLE, ZEN_STRING, ZEN_LIST, ZEN_MAP };

void _debug_print_indent(int n); // extern, defined in list.c

void _debug_pretty_map(ZenMap* map, int indent) {
    printf("{\n");

    int fieldIndent = indent + 2;

    for (int i = 0; i < map->count; i++) {
        MapEntry* e = &map->entries[i];

        _debug_print_indent(fieldIndent);
        printf("%s: ", e->key);

        switch (e->type) {
            case ZEN_INT:
                printf("%d", *(int*)e->value);
                break;

            case ZEN_BOOL:
                printf("%s", *(bool*)e->value ? "true" : "false");
                break;

            case ZEN_DOUBLE:
                printf("%g", *(double*)e->value);
                break;

            case ZEN_STRING:
                printf("\"%s\"", (char*)e->value);
                break;

            case ZEN_LIST:
                _debug_pretty_list_impl(
                    (ZenList*)e->value,
                    e->depth,
                    e->deepestType
                );
                break;

            case ZEN_MAP:
                _debug_pretty_map((ZenMap*)e->value, fieldIndent);
                break;

            default:
                printf("<unknown>");
        }

        if (i != map->count - 1)
            printf(",");

        printf("\n");
    }

    _debug_print_indent(indent);
    printf("}\n");
}