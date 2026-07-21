#ifdef _WIN32
#define strdup _strdup
#endif
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

ZenList *_zen_list_new(size_t element_size) {

  ZenList *list = (ZenList *)malloc(sizeof(ZenList));

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

  char *base = (char *)list->data;

  memmove(base + (index * list->element_size),
          base + ((index + 1) * list->element_size),
          (list->size - index - 1) * list->element_size);

  list->size--;
}

void _zen_list_free(ZenList *list) {

  if (!list)
    return;

  if (list->depth > 1 && list->data) {

    for (int i = 0; i < list->size; i++) {
      ZenList *child = ((ZenList **)list->data)[i];

      if (child)
        _zen_list_free(child);
    }
  }

  free(list->data);
  free(list);
}

void _zen_list_clear(ZenList *list) {

  if (!list)
    return;

  if (list->depth > 1 && list->data) {

    for (int i = 0; i < list->size; i++) {
      ZenList *child = ((ZenList **)list->data)[i];

      if (child)
        _zen_list_free(child);
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

    char *arg = argv[i];

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

enum { ZEN_INT = 1, ZEN_BOOL, ZEN_DOUBLE, ZEN_STRING, ZEN_LIST };

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