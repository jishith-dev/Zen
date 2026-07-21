#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <time.h>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <windows.h>
#include <psapi.h>
#include <tlhelp32.h>
#include <direct.h>
#include <conio.h>
#pragma comment(lib, "ws2_32.lib")
#pragma comment(lib, "psapi.lib")

#define ZEN_MAX_THREADS 1024

static void zen_error(const char *type, const char *msg) {
    fprintf(stderr, "\033[1;31m[Zen  %s]\n  └── %s\033[0m\n", type, msg);
    exit(1);
}

__attribute__((constructor))
static void _zen_win_init(void) {
    HANDLE h = GetStdHandle(STD_OUTPUT_HANDLE);
    DWORD mode = 0;
    if (GetConsoleMode(h, &mode)) {
        SetConsoleMode(h, mode | ENABLE_VIRTUAL_TERMINAL_PROCESSING);
    }
}

typedef void (*ZenThreadFn)(void);

typedef struct {
    ZenThreadFn fn;
} ZenThreadData;

static HANDLE zen_threads[ZEN_MAX_THREADS];
static int zen_thread_count = 0;

static DWORD WINAPI _zen_thread_runner(LPVOID arg) {
    ZenThreadData *data = (ZenThreadData *)arg;

    data->fn();

    free(data);
    return 0;
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

    HANDLE h = CreateThread(NULL, 0, _zen_thread_runner, data, 0, NULL);

    if (!h) {
        free(data);

        zen_error(
            "ThreadError",
            "Failed to create thread"
        );
    }

    zen_threads[zen_thread_count++] = h;
}

void _threads_waitAll() {
    for (int i = 0; i < zen_thread_count; i++) {
        WaitForSingleObject(zen_threads[i], INFINITE);
        CloseHandle(zen_threads[i]);
    }

    zen_thread_count = 0;
}

char *_sys_clipboard_get(void) {
    if (!OpenClipboard(NULL)) zen_error("ClipboardError", "Failed to read from clipboard");

    HANDLE h = GetClipboardData(CF_TEXT);

    if (!h) {
        CloseClipboard();
        char *out = malloc(1);
        if (!out) zen_error("MemoryError", "Failed to allocate memory for clipboard buffer");
        out[0] = '\0';
        return out;
    }

    char *data = (char *)GlobalLock(h);
    size_t len = data ? strlen(data) : 0;

    char *out = malloc(len + 1);
    if (!out) {
        GlobalUnlock(h);
        CloseClipboard();
        zen_error("MemoryError", "Failed to allocate memory for clipboard buffer");
    }

    if (data) memcpy(out, data, len);
    out[len] = '\0';

    GlobalUnlock(h);
    CloseClipboard();

    return out;
}

void _sys_clipboard_set(const char *text) {
    if (!text) zen_error("ClipboardError", "Cannot set clipboard to null text");

    if (!OpenClipboard(NULL)) zen_error("ClipboardError", "Failed to write to clipboard");

    EmptyClipboard();

    size_t len = strlen(text) + 1;
    HGLOBAL hMem = GlobalAlloc(GMEM_MOVEABLE, len);

    if (!hMem) {
        CloseClipboard();
        zen_error("MemoryError", "Failed to allocate clipboard memory");
    }

    memcpy(GlobalLock(hMem), text, len);
    GlobalUnlock(hMem);

    SetClipboardData(CF_TEXT, hMem);
    CloseClipboard();
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
    Sleep((DWORD)ms);
}

static int _zen_matchstar(int c, const char *re, const char *text);

static int _zen_matchhere(const char *re, const char *text) {
    if (re[0] == '\0') return 1;
    if (re[1] == '*') return _zen_matchstar(re[0], re + 2, text);
    if (re[0] == '$' && re[1] == '\0') return *text == '\0';
    if (*text != '\0' && (re[0] == '.' || re[0] == *text)) return _zen_matchhere(re + 1, text + 1);
    return 0;
}

static int _zen_matchstar(int c, const char *re, const char *text) {
    do {
        if (_zen_matchhere(re, text)) return 1;
    } while (*text != '\0' && (*text++ == c || c == '.'));
    return 0;
}

int _zen_regex_match(const char* str, const char* pattern) {
    if (pattern[0] == '^') return _zen_matchhere(pattern + 1, str);

    const char *text = str;

    do {
        if (_zen_matchhere(pattern, text)) return 1;
    } while (*text++ != '\0');

    return 0;
}

double _sys_performance() {

    static LARGE_INTEGER freq;
    static int initialized = 0;

    if (!initialized) {
        QueryPerformanceFrequency(&freq);
        initialized = 1;
    }

    LARGE_INTEGER counter;
    QueryPerformanceCounter(&counter);

    return (double)counter.QuadPart * 1000.0 / (double)freq.QuadPart;
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
    fprintf(stderr, "\033[1;31m");

    fprintf(stderr, "[Zen  PanicError]\n  └── %s\n", msg);

    fprintf(stderr, "\033[0m");

    exit(1);
}

void _sys_color(const char *color) {

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
    return (int)GetTickCount64();
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

    SYSTEM_POWER_STATUS s;

    if (!GetSystemPowerStatus(&s)) {
        return "unknown#0";
    }

    const char *state =
        s.ACLineStatus == 1 ? "charging" : "discharging";

    sprintf(
        result,
        "%s#%d",
        state,
        s.BatteryLifePercent
    );

    return result;
}

bool _net_online() {

    WSADATA wsa;
    WSAStartup(MAKEWORD(2, 2), &wsa);

    struct addrinfo *res;

    if (getaddrinfo("google.com", "80", NULL, &res) != 0) {
        WSACleanup();
        return false;
    }

    SOCKET sock = socket(
        res->ai_family,
        res->ai_socktype,
        res->ai_protocol
    );

    bool ok = connect(
        sock,
        res->ai_addr,
        (int)res->ai_addrlen
    ) == 0;

    closesocket(sock);
    WSACleanup();

    freeaddrinfo(res);

    return ok;
}

int _os_cpuCount() {
    SYSTEM_INFO si;
    GetSystemInfo(&si);
    return (int)si.dwNumberOfProcessors;
}

const char* _os_cpuArch() {
    return "x86/amd64-windows";
}

const char* _os_cpuModel() {
    return "windows-cpu";
}

double _os_cpuSpeed() {
    return -1;
}

long _os_totalMemory() {
    MEMORYSTATUSEX status;
    status.dwLength = sizeof(status);
    if (GlobalMemoryStatusEx(&status))
        return (long)(status.ullTotalPhys);
    return -1;
}

long _os_freeMemory() {
    MEMORYSTATUSEX status;
    status.dwLength = sizeof(status);
    if (GlobalMemoryStatusEx(&status))
        return (long)(status.ullAvailPhys);
    return -1;
}

long _os_usedMemory() {
    long t = _os_totalMemory();
    long f = _os_freeMemory();

    if (t == -1 || f == -1) return -1;
    return t - f;
}

long _os_processMemory() {
    PROCESS_MEMORY_COUNTERS pmc;
    if (GetProcessMemoryInfo(GetCurrentProcess(), &pmc, sizeof(pmc)))
        return (long)(pmc.WorkingSetSize / 1024);
    return -1;
}

const char* _os_osName() {
    return "Windows";
}

const char* _os_osVersion() {
    return "Windows-version";
}

char* _os_hostname() {
    char tmp[256];
    DWORD size = sizeof(tmp);

    if (!GetComputerNameA(tmp, &size))
        return strdup("unknown");

    tmp[sizeof(tmp) - 1] = '\0';

    char *out = (char*)malloc(strlen(tmp) + 1);
    if (!out) return strdup("unknown");

    strcpy(out, tmp);
    return out;
}

const char* _os_username() {
    static char name[128];
    DWORD size = sizeof(name);
    if (GetUserNameA(name, &size))
        return name;
    return "unknown";
}

double _os_uptime() {
    return GetTickCount64() / 1000.0;
}

int _fs_changeDir(const char *path) {
    return _chdir(path);
}

char* _fs_cwd() {
    char *buf = malloc(1024);
    if (!buf) return NULL;

    return _getcwd(buf, 1024);
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
    return GetFileAttributesA(path) != INVALID_FILE_ATTRIBUTES;
}

int _fs_deleteFile(const char *path) {
    return remove(path);
}

int _fs_renameFile(const char *oldname, const char *newname) {
    return rename(oldname, newname);
}

int _fs_makeDir(const char *path) {
    return _mkdir(path);
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

static const char* _zen_last_slash(const char* path) {
    const char* fwd = strrchr(path, '/');
    const char* bwd = strrchr(path, '\\');

    if (fwd && bwd) return fwd > bwd ? fwd : bwd;
    return fwd ? fwd : bwd;
}

char* _path_basename(const char* path) {

    const char* slash = _zen_last_slash(path);

    if (!slash) {
        return strdup(path);
    }

    return strdup(slash + 1);
}

char* _path_dirname(const char* path) {

    const char* slash = _zen_last_slash(path);

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
        a[lenA - 1] != '/' &&
        a[lenA - 1] != '\\';

    char* out =
        malloc(
            lenA +
            lenB +
            needSlash +
            1
        );

    strcpy(out, a);

    if (needSlash) {
        strcat(out, "\\");
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
    return (int)GetCurrentProcessId();
}

int _os_parentPid(void) {
    DWORD pid = GetCurrentProcessId();
    DWORD ppid = (DWORD)-1;

    HANDLE snap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    if (snap == INVALID_HANDLE_VALUE) return -1;

    PROCESSENTRY32 pe;
    pe.dwSize = sizeof(PROCESSENTRY32);

    if (Process32First(snap, &pe)) {
        do {
            if (pe.th32ProcessID == pid) {
                ppid = pe.th32ParentProcessID;
                break;
            }
        } while (Process32Next(snap, &pe));
    }

    CloseHandle(snap);
    return (int)ppid;
}

char* _os_platform(void) {
    return strdup("windows");
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
    SetEnvironmentVariableA(name, value);
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
    FILE* pipe = _popen(cmd, "r");
    if (!pipe) {
        return strdup("");
    }

    size_t capacity = 256;
    size_t length = 0;
    char* result = (char*)malloc(capacity);
    if (!result) {
        _pclose(pipe);
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
                _pclose(pipe);
                return strdup("");
            }
            result = newResult;
        }

        memcpy(result + length, chunk, chunkLen);
        length += chunkLen;
        result[length] = '\0';
    }

    _pclose(pipe);

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
    const char *home = getenv("USERPROFILE");
    char *out;

    if (!home) {
        const char *drive = getenv("HOMEDRIVE");
        const char *path = getenv("HOMEPATH");

        if (drive && path) {
            out = malloc(strlen(drive) + strlen(path) + 1);
            strcpy(out, drive);
            strcat(out, path);
            return out;
        }

        home = "";
    }

    out = malloc(strlen(home) + 1);
    strcpy(out, home);
    return out;
}

char* _sys_key() {
    static char key[2] = "";

    if (!_kbhit()) {
        key[0] = '\0';
        return key;
    }

    int ch = _getch();

    if (ch == '\r' || ch == '\n') {
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
