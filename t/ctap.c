#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <math.h>

#include "ctap.h"

/* global variable testnum? */
static int test = 0; /* the test number */
static int planned = 0;
static int intodo = 0;

void begin_todo(void) {
	intodo = 1;
}

void end_todo(void) {
	intodo = 0;
}

void plan(int tests) {
	test = 0;
	planned = tests;
	printf("1..%d\n", tests);
}

static void print_lazy_plan(void) {
	printf("1..%d\n", test);
	fflush(stdout);
}

void plan_lazy(void) {
	test = 0;
	planned = 0;
	atexit(print_lazy_plan);
}

void skip_all(const char *why, ...) {
	printf("1..0");
	if (why) {
		va_list args;
		printf(" # SKIP ");
		va_start(args, why);
		vfprintf(stdout, why, args);
		va_end(args);
	}
	printf("\n");
}

static void vfmtline(int pass, const char *directive, const char *fmt, va_list args) {
	printf("%sok %d", pass ? "" : "not ", ++test);
	if (fmt && !directive) {
		printf(" -");
	}
	if (directive) {
		printf(" # %s", directive);
	}
	if (fmt) {
		printf(" ");
		vfprintf(stdout, fmt, args);
	}
	printf("\n");
}

#if 0
static void fmtline(int pass, const char *info, const char *fmt, ...) {
	va_list args;

	va_start(args,fmt);
	vfmtline(pass, info, fmt, args);
	va_end(args);
}
#endif

void okv(int pass, const char *fmt, va_list args) {
	vfmtline(pass, intodo ? "TODO" : 0, fmt, args);
}

void ok(int pass, char *fmt, ...) {
	va_list args;

	va_start(args, fmt);
	okv(pass, fmt, args);
	va_end(args);
}

void ok_block(unsigned long count, int pass, const char *fmt, ...) {
	va_list args;
	va_list copy;

	if (count == 0) {
		return;
	}

	va_start(args, fmt);
	while (count--) {
		va_copy(copy, args);
		okv(pass, fmt, copy);
		va_end(copy);
	}
	va_end(args);
}

void skip(const char *why, ...) {
	va_list args;

	va_start(args, why);
	vfmtline(1, "SKIP", why, args);
	va_end(args);
}

void skip_block(unsigned long count, const char *why, ...) {
	va_list args;
	va_list copy;
	va_start(args, why);

	while (count--) {
		va_copy(copy, args);
		vfmtline(1, "SKIP", why, args);
		va_end(copy);
	}

	va_end(args);
}

void bail(const char *fmt, ...) {
	va_list args;
	printf("Bail out!");
	if (fmt) {
		va_start(args, fmt);
		vfprintf(stdout, fmt, args);
		va_end(args);
	}
	printf("\n");
	fflush(stdout);
	exit(1);
}

void sysbail(const char *fmt, ...) {
	va_list args;
	printf("Bail out!");
	if (fmt) {
		va_start(args, fmt);
		vfprintf(stdout, fmt, args);
		va_end(args);
	}
	printf(": %s\n", strerror(errno));
	fflush(stdout);
	exit(1);
}

void sysdiag(const char *fmt, ...) {
	va_list args;
	if (!fmt) { return; }
	printf("# ");
	va_start(args, fmt);
	vfprintf(stdout, fmt, args);
	va_end(args);
	printf(": %s\n", strerror(errno));
}

void diag(const char *fmt, ...) {
	va_list args;
	if (!fmt) { return; }
	printf("# ");
	va_start(args, fmt);
	vfprintf(stdout, fmt, args);
	va_end(args);
	printf("\n");
}

void is_hex(unsigned long wanted, unsigned long seen, const char *fmt, ...) {
	va_list args;
	if (fmt) {
		va_start(args, fmt);
		okv(wanted == seen, fmt, args);
		va_end(args);
	} else {
		ok(wanted == seen, NULL);
	}
	if (wanted != seen) {
		diag("wanted: %ld", wanted);
		diag("got   : %ld", seen);
	}
}


void is_int(long wanted, long seen, const char *fmt, ...) {
	va_list args;
	if (fmt) {
		va_start(args, fmt);
		okv(wanted == seen, fmt, args);
		va_end(args);
	} else {
		ok(wanted == seen, NULL);
	}
	if (wanted != seen) {
		diag("wanted: %ld", wanted);
		diag("got   : %ld", seen);
	}
}

void is_double(double wanted, double seen, double eps, const char *fmt, ...) {
	int pass;
	va_list args;

	pass = fabs(wanted - seen) <= eps;
	if (fmt) {
		va_start(args, fmt);
		okv(pass, fmt, args);
		va_end(args);
	} else {
		ok(wanted == seen, NULL);
	}
	if (!pass) {
		diag("wanted: %f", wanted);
		diag("got   : %f", seen);
	}
}

void is_string(const char *wanted, const char *seen, const char *fmt, ...) {
	int pass;
	va_list args;

	pass = !strcmp(wanted,seen);
	if (fmt) {
		va_start(args, fmt);
		okv(pass, fmt, args);
		va_end(args);
	} else {
		ok(wanted == seen, NULL);
	}
	if (!pass) {
		diag("wanted: %s", wanted);
		diag("got   : %s", seen);
	}
}
