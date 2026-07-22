#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <stdbool.h>
#include <time.h>
#include <unistd.h>
#include <netdb.h>
#include <pwd.h>
#include <sys/utsname.h>
#include <sys/sysinfo.h>
#include <regex.h>
#include <termios.h>
#include <fcntl.h>

// expirimental
#include <pthread.h>

#define ZEN_MAX_THREADS 1024

static void zen_error(const char *type, const char *msg) {
    fprintf(stderr, "\033[1;31m[Zen  %s]\n  └── %s\033[0m\n", type, msg);
    exit(1);
}

typedef void (*ZenThreadFn)(void);

typedef struct {
    ZenThreadFn fn;
} ZenThreadData;

static pthread_t zen_threads[ZEN_MAX_THREADS];
static int zen_thread_count = 0;

static void *_zen_thread_runner(void *arg) {
    ZenThreadData *data = (ZenThreadData *)arg;

    data->fn();

    free(data);
    return NULL;
}

void _zen_thread(ZenThreadFn fn) {
    if (zen_thread_count >= ZEN_MAX_THREADS) {
        zen_error(
            "ThreadError",
            "Maximum thread limit exceeded"
        );
    }

    ZenThreadData *data = malloc(sizeof(ZenThreadData));

    if (!data) {
        zen_error(
            "MemoryError",
            "Failed to allocate thread context"
        );
    }

    data->fn = fn;

    int result = pthread_create(
        &zen_threads[zen_thread_count],
        NULL,
        _zen_thread_runner,
        data
    );

    if (result != 0) {
        free(data);

        zen_error(
            "ThreadError",
            "Failed to create thread"
        );
    }

    zen_thread_count++;
}

void _threads_waitAll() {
    for (int i = 0; i < zen_thread_count; i++) {
        int result = pthread_join(
            zen_threads[i],
            NULL
        );

        if (result != 0) {
            zen_error(
                "ThreadError",
                "Failed to join thread"
            );
        }
    }

    zen_thread_count = 0;
}

// clipboard API (not fully support)

#ifdef __APPLE__
#define COPY_CMD  "pbcopy"
#define PASTE_CMD "pbpaste"
#else
static const char *copy_cmd(void) {
    if (getenv("WAYLAND_DISPLAY")) return "wl-copy 2>/dev/null";
    return "xclip -selection clipboard 2>/dev/null";
}

static const char *paste_cmd(void) {
    if (getenv("WAYLAND_DISPLAY")) return "wl-paste -n 2>/dev/null";
    return "xclip -selection clipboard -o 2>/dev/null";
}
#endif

char *_sys_clipboard_get(void) {
#ifdef __APPLE__
    FILE *fp = popen(PASTE_CMD, "r");
#else
    FILE *fp = popen(paste_cmd(), "r");
#endif
    if (!fp) zen_error("ClipboardError", "Failed to read from clipboard");

    size_t cap = 256, len = 0;
    char *buf = malloc(cap);
    if (!buf) zen_error("MemoryError", "Failed to allocate memory for clipboard buffer");

    int ch;
    while ((ch = fgetc(fp)) != EOF) {
        if (len + 1 >= cap) {
            cap *= 2;
            char *tmp = realloc(buf, cap);
            if (!tmp) zen_error("MemoryError", "Failed to allocate memory for clipboard buffer");
            buf = tmp;
        }
        buf[len++] = (char)ch;
    }
    buf[len] = '\0';

    pclose(fp);
    return buf;
}

void _sys_clipboard_set(const char *text) {
    if (!text) zen_error("ClipboardError", "Cannot set clipboard to null text");

#ifdef __APPLE__
    FILE *fp = popen(COPY_CMD, "w");
#else
    FILE *fp = popen(copy_cmd(), "w");
#endif
    if (!fp) zen_error("ClipboardError", "Failed to write to clipboard");

    fputs(text, fp);
    pclose(fp);
}

void _sys_clipboard_clear(void) {
    _sys_clipboard_set("");
}

int _sys_clipboard_hasText(void) {
    char *text = _sys_clipboard_get();
    int has = text[0] != '\0';
    free(text);
    return has;
}

// ----

void _time_sleep(int ms) {
    usleep(ms * 1000);
}

int _zen_regex_match(const char* str, const char* pattern) {
  regex_t re;
  int ret = regcomp(&re, pattern, REG_EXTENDED);
  if (ret != 0) return -1;

  ret = regexec(&re, str, 0, NULL, 0);
  regfree(&re);

  return (ret == 0) ? 1 : 0;
}

double _sys_performance() {

#ifdef _WIN32
    static LARGE_INTEGER freq;
    static int initialized = 0;

    if (!initialized) {
        QueryPerformanceFrequency(&freq);
        initialized = 1;
    }

    LARGE_INTEGER counter;
    QueryPerformanceCounter(&counter);

    return (double)counter.QuadPart * 1000.0 / (double)freq.QuadPart;

#else
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);

    return (double)ts.tv_sec * 1000.0 +
           (double)ts.tv_nsec / 1e6;
#endif

}

char* _sys_input(const char* prompt) {

    char buf[1024];

    if (prompt != NULL) {
        printf("%s", prompt);
        fflush(stdout);
    }

    if (!fgets(buf, sizeof(buf), stdin)) {
        buf[0] = '\0';
    }

    // remove newline
    size_t len = strlen(buf);
    if (len > 0 && buf[len - 1] == '\n') {
        buf[len - 1] = '\0';
    }

    // allocate fresh memory per call
    char* out = (char*)malloc(len + 1);
    
    if (!out) {
    fprintf(stderr, "\033[1;31m[Zen  MemoryError]\n  └── Failed to allocate memory for input buffer\033[0m\n");
    exit(1);
}

    strcpy(out, buf);

    return out;
}

void _sys_panic(const char* msg) {
    // ANSI red color
    fprintf(stderr, "\033[1;31m");

    fprintf(stderr, "[Zen  PanicError]\n  └── %s\n", msg);

    // reset color
    fprintf(stderr, "\033[0m");

    exit(1);
}

void _sys_color(const char *color) {

    // NORMAL COLORS
    if (strcmp(color, "black") == 0)
        printf("\033[30m");

    else if (strcmp(color, "red") == 0)
        printf("\033[31m");

    else if (strcmp(color, "green") == 0)
        printf("\033[32m");

    else if (strcmp(color, "yellow") == 0)
        printf("\033[33m");

    else if (strcmp(color, "blue") == 0)
        printf("\033[34m");

    else if (strcmp(color, "magenta") == 0)
        printf("\033[35m");

    else if (strcmp(color, "cyan") == 0)
        printf("\033[36m");

    else if (strcmp(color, "white") == 0)
        printf("\033[37m");

    else if (strcmp(color, "brightBlack") == 0)
        printf("\033[90m");

    else if (strcmp(color, "brightRed") == 0)
        printf("\033[91m");

    else if (strcmp(color, "brightGreen") == 0)
        printf("\033[92m");

    else if (strcmp(color, "brightYellow") == 0)
        printf("\033[93m");

    else if (strcmp(color, "brightBlue") == 0)
        printf("\033[94m");

    else if (strcmp(color, "brightMagenta") == 0)
        printf("\033[95m");

    else if (strcmp(color, "brightCyan") == 0)
        printf("\033[96m");

    else if (strcmp(color, "brightWhite") == 0)
        printf("\033[97m");

    else if (strcmp(color, "bold") == 0)
        printf("\033[1m");

    else if (strcmp(color, "underline") == 0)
        printf("\033[4m");

    else if (strcmp(color, "reverse") == 0)
        printf("\033[7m");

    // RESET
    else if (strcmp(color, "reset") == 0)
        printf("\033[0m");

    fflush(stdout);
}

const char* _time_time() {
    static char buffer[32];

    time_t now = time(NULL);
    struct tm *t = localtime(&now);

    snprintf(
        buffer,
        sizeof(buffer),
        "%02d:%02d:%02d",
        t->tm_hour,
        t->tm_min,
        t->tm_sec
    );

    return buffer;
}

int _time_millis() {

    struct timespec ts;

    clock_gettime(CLOCK_REALTIME, &ts);

    return ((long long)ts.tv_sec * 1000LL)
           + (ts.tv_nsec / 1000000LL);
}

int _time_date() {
    time_t now = time(NULL);
    return localtime(&now)->tm_mday;
}

int _time_month() {
    time_t now = time(NULL);
    return localtime(&now)->tm_mon + 1;
}

int _time_day() {
    time_t now = time(NULL);
    return localtime(&now)->tm_wday;
}

int _time_year() {
    time_t now = time(NULL);
    return localtime(&now)->tm_year + 1900;
}

const char* _os_battery() {

    static char result[64];

    FILE *f = fopen(
        "/sys/class/power_supply/BAT0/capacity",
        "r"
    );

    if (!f) {
        return "unknown#0";
    }

    int percent;
    fscanf(f, "%d", &percent);
    fclose(f);

    f = fopen(
        "/sys/class/power_supply/BAT0/status",
        "r"
    );

    char status[32] = "unknown";

    if (f) {
        fscanf(f, "%31s", status);
        fclose(f);
    }

    sprintf(
        result,
        "%s#%d",
        status,
        percent
    );

    return result;
}


bool _net_online() {

    struct addrinfo *res;

    if (getaddrinfo("google.com", "80", NULL, &res) != 0) {
        return false;
    }

    int sock = socket(
        res->ai_family,
        res->ai_socktype,
        res->ai_protocol
    );

    bool ok = connect(
        sock,
        res->ai_addr,
        res->ai_addrlen
    ) == 0;

    close(sock);

    freeaddrinfo(res);

    return ok;
}

int _os_cpuCount() {
    long n = sysconf(_SC_NPROCESSORS_ONLN);
    return (n > 0) ? (int)n : 1;
}


const char* _os_cpuArch() {
    static struct utsname u;
    if (uname(&u) == 0)
        return u.machine;
    return "unknown";
}


const char* _os_cpuModel() {
    static char model[128];
    FILE *f = fopen("/proc/cpuinfo", "r");
    if (!f) return "unknown";

    while (fgets(model, sizeof(model), f)) {
        if (strstr(model, "model name") || strstr(model, "Hardware")) {
            fclose(f);
            char *p = strchr(model, ':');
            return p ? p + 2 : model;
        }
    }

    fclose(f);
    return "unknown";

}


double _os_cpuSpeed() {
    FILE *f = fopen("/proc/cpuinfo", "r");
    if (!f) return -1;

    char line[128];
    double mhz = -1;

    while (fgets(line, sizeof(line), f)) {
        if (sscanf(line, "cpu MHz : %lf", &mhz) == 1) {
            fclose(f);
            return  mhz / 1000;
        }
    }

    fclose(f);

    // Android fallback 
    FILE *g = fopen("/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq", "r");
    if (g) {
        long khz = 0;
        if (fscanf(g, "%ld", &khz) == 1) {
            fclose(g);
            return khz / 1000.0;
        }
        fclose(g);
    }

    return -1;
}

long _os_totalMemory() {
#ifdef _WIN32
    MEMORYSTATUSEX status;
    status.dwLength = sizeof(status);
    if (GlobalMemoryStatusEx(&status))
        return (long)(status.ullTotalPhys);
    return -1;
#else
    FILE *f = fopen("/proc/meminfo", "r");
    if (!f) return -1;

    long mem = -1;
    if (fscanf(f, "MemTotal: %ld kB", &mem) != 1)
        mem = -1;

    fclose(f);
    return mem * 1024;
#endif
}

long _os_freeMemory() {
#ifdef _WIN32
    MEMORYSTATUSEX status;
    status.dwLength = sizeof(status);
    if (GlobalMemoryStatusEx(&status))
        return (long)(status.ullAvailPhys);
    return -1;
#else
    FILE *f = fopen("/proc/meminfo", "r");
    if (!f) return -1;

    char line[128];
    long mem = -1;

    while (fgets(line, sizeof(line), f)) {
        if (sscanf(line, "MemAvailable: %ld kB", &mem) == 1) {
            fclose(f);
            return mem * 1024;
        }
    }

    fclose(f);
    return -1;
#endif
}

long _os_usedMemory() {
    long t = _os_totalMemory();
    long f = _os_freeMemory();

    if (t == -1 || f == -1) return -1;
    return t - f;
}

long _os_processMemory() {
#ifdef _WIN32
    PROCESS_MEMORY_COUNTERS pmc;
    if (GetProcessMemoryInfo(GetCurrentProcess(), &pmc, sizeof(pmc)))
        return (long)(pmc.WorkingSetSize / 1024);
    return -1;
#else
    FILE *f = fopen("/proc/self/status", "r");
    if (!f) return -1;

    char line[128];
    long mem = -1;

    while (fgets(line, sizeof(line), f)) {
        if (sscanf(line, "VmRSS: %ld kB", &mem) == 1) {
            fclose(f);
            return mem * 1024;
        }
    }

    fclose(f);
    return -1;
#endif
}

const char* _os_osName() {
#ifdef _WIN32
    return "Windows";
#else
    static struct utsname u;
    if (uname(&u) == 0)
        return u.sysname;
    return "Linux";
#endif
}

const char* _os_osVersion() {
#ifdef _WIN32
    return "Windows-version";
#else
    static struct utsname u;
    if (uname(&u) == 0)
        return u.release;
    return "unknown";
#endif
}


char* _os_hostname() {
    char tmp[256];

#ifdef _WIN32
    DWORD size = 256;
    if (!GetComputerNameA(tmp, &size))
        return strdup("unknown");
#else
    if (gethostname(tmp, sizeof(tmp)) != 0)
        return strdup("unknown");
#endif

    tmp[sizeof(tmp) - 1] = '\0';

    char *out = (char*)malloc(strlen(tmp) + 1);
    if (!out) return strdup("unknown");

    strcpy(out, tmp);
    return out;
}

const char* _os_username() {
#ifdef _WIN32
    static char name[128];
    DWORD size = sizeof(name);
    if (GetUserNameA(name, &size))
        return name;
    return "unknown";
#else
    const char *u = getenv("USER");
    if (u) return u;

    u = getenv("LOGNAME");
    if (u) return u;

    return "unknown";
#endif
}


double _os_uptime() {
#ifdef _WIN32
    return GetTickCount64() / 1000.0;
#else
    FILE *f = fopen("/proc/uptime", "r");
    if (f) {
        double t = -1;
        if (fscanf(f, "%lf", &t) == 1) {
            fclose(f);
            return t;
        }
        fclose(f);
    }

    // fallback 
    #ifdef __linux__
    struct sysinfo info;
    if (sysinfo(&info) == 0) {
        return (double)info.uptime;
    }
    #endif

    return -1;
#endif
}

int _fs_changeDir(const char *path) {
    return chdir(path);
}

char* _fs_cwd() {
    char *buf = malloc(1024);
    if (!buf) return NULL;

    char *r = _getcwd(buf, 1024);
    if (!r) {
        free(buf);
        return NULL;
    }
    return buf;
}

const char* _sys_getEnv(const char *key) {
    const char *val = getenv(key);
    return val ? val : "";
}

char* _fs_readFile(const char* path) {
    FILE* f = fopen(path, "rb");
    if (!f) {
        char* empty = (char*)malloc(1);
        empty[0] = '\0';
        return empty;
    }

    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    rewind(f);

    char* buffer = (char*)malloc(size + 1);
    if (!buffer) {
        fclose(f);
        char* empty = (char*)malloc(1);
        empty[0] = '\0';
        return empty;
    }

    fread(buffer, 1, size, f);
    buffer[size] = '\0';

    fclose(f);
    return buffer;
}

int _sys_exec(const char *cmd) {
    if (!cmd) return -1;
    return system(cmd);
}

int _fs_writeFile(const char* path, const char* content) {
    FILE* f = fopen(path, "wb");

    if (!f) {
        return 0;
    }

    size_t written = fwrite(content, 1, strlen(content), f);

    fclose(f);

    return written > 0 ? 0 : 1;
}

int _fs_appendFile(const char *path, const char *content) {
    FILE *f = fopen(path, "a");
    if (!f) return 1;

    fputs(content, f);
    fclose(f);

    return 0;
}


bool _fs_exists(const char *path) {
    #ifdef _WIN32
return GetFileAttributesA(path) != INVALID_FILE_ATTRIBUTES;
#else
return access(path, F_OK) == 0;
#endif
}

int _fs_deleteFile(const char *path) {
    return remove(path);
}

int _fs_renameFile(const char *oldname, const char *newname) {
    return rename(oldname, newname);
}

int _fs_makeDir(const char *path) {

#ifdef _WIN32
    return _mkdir(path);
#else
    return mkdir(path, 0755);
#endif

}

char* _int_to_string(int x) {
    char* res = (char*)malloc(20);
    
    int i = 0;
    int isNeg = 0;

    if (x == 0) {
        res[i++] = '0';
        res[i] = '\0';
        return res;
    }

    if (x < 0) {
        isNeg = 1;
        x = -x;
    }

    char temp[20];
    int t = 0;

    while (x > 0) {
        temp[t++] = (x % 10) + '0';
        x /= 10;
    }

    if (isNeg) {
        res[i++] = '-';
    }

    while (t > 0) {
        res[i++] = temp[--t];
    }

    res[i] = '\0';
    return res;
}


char* _double_to_string(double x) {
    char buffer[64];
    snprintf(buffer, sizeof(buffer), "%f", x);

    char* res = (char*)malloc(strlen(buffer) + 1);
    strcpy(res, buffer);

    return res;
}


char* _bool_to_string(bool x) {
    const char* str = x ? "true" : "false";

    char* res = (char*)malloc(strlen(str) + 1);
    strcpy(res, str);

    return res;
}


int _string_to_int(char* str) {
    if (str == NULL) return 0;

    int result = 0;
    int i = 0;
    int sign = 1;

    if (str[0] == '-') {
        sign = -1;
        i++;
    }

    while (str[i] != '\0') {
        if (str[i] < '0' || str[i] > '9') {
            break; 
        }

        result = result * 10 + (str[i] - '0');
        i++;
    }

    return result * sign;
}

int _string_to_int_ascii(char *str) {
    int result = 0;

    while (*str) {
        result += (int)(*str);
        str++;
    }

    return result;
}

char* _int_to_string_ascii(int value) {
    char *out = (char*)malloc(2);

    out[0] = (char)value;
    out[1] = '\0';

    return out;
}


double _string_to_double(char* str) {
    if (str == NULL) return 0.0;
    return atof(str);
}


bool _string_to_bool(char* str) {
    return (str != NULL && strlen(str) > 0);
}


void _free_string(char* str) {
    if (str != NULL) {
        free(str);
    }
}

char* _str_concat(const char* a, const char* b) {
    if (!a) a = "";
    if (!b) b = "";

    size_t len_a = strlen(a);
    size_t len_b = strlen(b);

    char* res = (char*)malloc(len_a + len_b + 1);
    if (!res) return NULL;

    memcpy(res, a, len_a);
    memcpy(res + len_a, b, len_b);
    res[len_a + len_b] = '\0';

    return res;
}

char* _zen_char_to_string(char c) {
    char* s = (char*)malloc(2);
    s[0] = c;
    s[1] = '\0';
    return s;
}

char* _path_basename(const char* path) {

    const char* slash = strrchr(path, '/');

    if (!slash) {
        return strdup(path);
    }

    return strdup(slash + 1);
}


char* _path_dirname(const char* path) {

    const char* slash = strrchr(path, '/');

    if (!slash) {
        return strdup(".");
    }

    size_t len = slash - path;

    char* out = malloc(len + 1);

    strncpy(out, path, len);
    out[len] = '\0';

    return out;
}


char* _path_extname(const char* path) {

    const char* dot = strrchr(path, '.');

    if (!dot) {
        return strdup("");
    }

    return strdup(dot);
}


char* _path_join(
    const char* a,
    const char* b
) {

    size_t lenA = strlen(a);
    size_t lenB = strlen(b);

    int needSlash =
        lenA > 0 &&
        a[lenA - 1] != '/';

    char* out =
        malloc(
            lenA +
            lenB +
            needSlash +
            1
        );

    strcpy(out, a);

    if (needSlash) {
        strcat(out, "/");
    }

    strcat(out, b);

    return out;
}


char* _path_normalize(const char* path) {

    return strdup(path);
}

void _os_exit(int code) {
    exit(code);
}

int _os_pid(void) {
    return (int)getpid();
}

int _os_parentPid(void) {
    return (int)getppid();
}

char* _os_platform(void) {
#if defined(__ANDROID__)
    return strdup("android");
#elif defined(__linux__)
    return strdup("linux");
#elif defined(__APPLE__)
    return strdup("darwin");
#elif defined(_WIN32)
    return strdup("windows");
#else
    return strdup("unknown");
#endif
}

bool _os_isWindows(void) {
    char* p = _os_platform();
    bool result = (strcmp(p, "windows") == 0);
    free(p);
    return result;
}

bool _os_isLinux(void) {
    char* p = _os_platform();
    bool result = (strcmp(p, "linux") == 0);
    free(p);
    return result;
}

bool _os_isMac(void) {
    char* p = _os_platform();
    bool result = (strcmp(p, "darwin") == 0);
    free(p);
    return result;
}

bool _os_isAndroid(void) {
    char* p = _os_platform();
    bool result = (strcmp(p, "android") == 0);
    free(p);
    return result;
}

void _sys_setEnv(char* name, char* value) {
    setenv(name, value, 1); // 1 = overwrite if already set
}

bool _sys_hasEnv(char* name) {
    return getenv(name) != NULL;
}

char* _sys_readLine(void) {
    size_t bufsize = 256;
    char* buffer = (char*)malloc(bufsize);
    if (!buffer) {
        return strdup("");
    }

    if (fgets(buffer, (int)bufsize, stdin) == NULL) {
        free(buffer);
        return strdup("");
    }

    // strip trailing newline, if present
    size_t len = strlen(buffer);
    if (len > 0 && buffer[len - 1] == '\n') {
        buffer[len - 1] = '\0';
        len--;
    }
    if (len > 0 && buffer[len - 1] == '\r') {
        buffer[len - 1] = '\0';
    }

    return buffer;
}

char* _sys_execOutput(char* cmd) {
    FILE* pipe = popen(cmd, "r");
    if (!pipe) {
        return strdup("");
    }

    size_t capacity = 256;
    size_t length = 0;
    char* result = (char*)malloc(capacity);
    if (!result) {
        pclose(pipe);
        return strdup("");
    }
    result[0] = '\0';

    char chunk[256];
    while (fgets(chunk, sizeof(chunk), pipe) != NULL) {
        size_t chunkLen = strlen(chunk);

        while (length + chunkLen + 1 > capacity) {
            capacity *= 2;
            char* newResult = (char*)realloc(result, capacity);
            if (!newResult) {
                free(result);
                pclose(pipe);
                return strdup("");
            }
            result = newResult;
        }

        memcpy(result + length, chunk, chunkLen);
        length += chunkLen;
        result[length] = '\0';
    }

    pclose(pipe);

    if (length > 0 && result[length - 1] == '\n') {
        result[length - 1] = '\0';
    }

    return result;
}

int _time_now(void) {
    return (int)time(NULL);
}

char* _time_format(int t) {
    time_t timestamp = (time_t)t;

    struct tm *tm_info = localtime(&timestamp);

    if (!tm_info) {
        return NULL;
    }

    char *buffer = malloc(32);

    if (!buffer) {
        return NULL;
    }

    strftime(
        buffer,
        32,
        "%Y-%m-%d %H:%M:%S",
        tm_info
    );

    return buffer;
}

char* _os_homeDir() {
    const char *home = getenv("HOME");
    if (!home) {
        struct passwd *pw = getpwuid(getuid());
        home = (pw && pw->pw_dir) ? pw->pw_dir : "";
    }

    char *out = malloc(strlen(home) + 1);
    strcpy(out, home);
    return out;
}

char* _sys_key() {
    static char key[2] = "";

    struct termios oldt, newt;

    tcgetattr(STDIN_FILENO, &oldt);
    newt = oldt;

    newt.c_lflag &= ~(ICANON | ECHO);

    tcsetattr(STDIN_FILENO, TCSANOW, &newt);

    int oldf = fcntl(STDIN_FILENO, F_GETFL, 0);
    fcntl(STDIN_FILENO, F_SETFL, oldf | O_NONBLOCK);

    int ch = getchar();

    tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
    fcntl(STDIN_FILENO, F_SETFL, oldf);

    if (ch == EOF) {
        key[0] = '\0';
        return key;
    }

    if (ch == '\n' || ch == '\r') {
        return "enter";
    }

    key[0] = (char)ch;
    key[1] = '\0';
    return key;
}

// Ptr 

void _zen_ptr_storeInt(void *p, int value) {
    *(int *)p = value;
}

int _zen_ptr_loadInt(void *p) {
    return *(int *)p;
}

void _zen_ptr_storeDouble(void *p, double value) {
    *(double *)p = value;
}

double _zen_ptr_loadDouble(void *p) {
    return *(double *)p;
}

void _zen_ptr_storeBool(void *p, bool value) {
    *(bool *)p = value;
}

bool _zen_ptr_loadBool(void *p) {
    return *(bool *)p;
}

void _zen_ptr_storeString(void *p, char *value) {
    *(char **)p = value;
}

char *_zen_ptr_loadString(void *p) {
    return *(char **)p;
}

void _zen_ptr_storePtr(void *p, void *value) {
    *(void **)p = value;
}

void *_zen_ptr_loadPtr(void *p) {
    return *(void **)p;
}

bool _zen_ptr_isNull(void *p) {
    return p == NULL;
}

void *_zen_ptr_offset(void *p, int bytes) {
    return (void *)((char *)p + bytes);
}

void _zen_ptr_copyFrom(void *dst, void *src, int bytes) {
    memcpy(dst, src, (size_t)bytes);
}

void _zen_ptr_copyTo(void *src, void *dst, int bytes) {
    memcpy(dst, src, (size_t)bytes);
}

void _zen_ptr_fill(void *p, int value, int bytes) {
    memset(p, value, (size_t)bytes);
}

void _zen_ptr_free(void *p) {
    free(p);
}