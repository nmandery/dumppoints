#ifndef TAP_H_
#define TAP_H_ 1

#include <stdarg.h>

void begin_todo(void);
void end_todo(void);
void plan(int tests);
void plan_lazy(void);
void skip_all(const char *why, ...);
void okv(int pass, const char *fmt, va_list args);
void ok(int pass, char *fmt, ...);
void ok_block(unsigned long count, int pass, const char *fmt, ...);
void skip(const char *why, ...);
void skip_block(unsigned long count, const char *why, ...);
void bail(const char *fmt, ...);
void sysbail(const char *fmt, ...);
void sysdiag(const char *fmt, ...);
void diag(const char *fmt, ...);
void is_hex(unsigned long wanted, unsigned long seen, const char *fmt, ...);
void is_int(long wanted, long seen, const char *fmt, ...);
void is_double(double wanted, double seen, double eps, const char *fmt, ...);
void is_string(const char *wanted, const char *seen, const char *fmt, ...);

#endif
