/* Provide Declarations */
#include <stdarg.h>
#include <setjmp.h>
#include <limits.h>
#ifdef NEED_CBEAPINT
#include <autopilot_cbe.h>
#else
#define aesl_fopen fopen
#define aesl_freopen freopen
#define aesl_tmpfile tmpfile
#endif
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#ifdef __STRICT_ANSI__
#define inline __inline__
#define typeof __typeof__ 
#endif
#define __isoc99_fscanf fscanf
#define __isoc99_sscanf sscanf
#undef ferror
#undef feof
/* get a declaration for alloca */
#if defined(__CYGWIN__) || defined(__MINGW32__)
#define  alloca(x) __builtin_alloca((x))
#define _alloca(x) __builtin_alloca((x))
#elif defined(__APPLE__)
extern void *__builtin_alloca(unsigned long);
#define alloca(x) __builtin_alloca(x)
#define longjmp _longjmp
#define setjmp _setjmp
#elif defined(__sun__)
#if defined(__sparcv9)
extern void *__builtin_alloca(unsigned long);
#else
extern void *__builtin_alloca(unsigned int);
#endif
#define alloca(x) __builtin_alloca(x)
#elif defined(__FreeBSD__) || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) || defined(__arm__)
#define alloca(x) __builtin_alloca(x)
#elif defined(_MSC_VER)
#define inline _inline
#define alloca(x) _alloca(x)
#else
#include <alloca.h>
#endif

#ifndef __GNUC__  /* Can only support "linkonce" vars with GCC */
#define __attribute__(X)
#endif

#if defined(__GNUC__) && defined(__APPLE_CC__)
#define __EXTERNAL_WEAK__ __attribute__((weak_import))
#elif defined(__GNUC__)
#define __EXTERNAL_WEAK__ __attribute__((weak))
#else
#define __EXTERNAL_WEAK__
#endif

#if defined(__GNUC__) && (defined(__APPLE_CC__) || defined(__CYGWIN__) || defined(__MINGW32__))
#define __ATTRIBUTE_WEAK__
#elif defined(__GNUC__)
#define __ATTRIBUTE_WEAK__ __attribute__((weak))
#else
#define __ATTRIBUTE_WEAK__
#endif

#if defined(__GNUC__)
#define __HIDDEN__ __attribute__((visibility("hidden")))
#endif

#ifdef __GNUC__
#define LLVM_NAN(NanStr)   __builtin_nan(NanStr)   /* Double */
#define LLVM_NANF(NanStr)  __builtin_nanf(NanStr)  /* Float */
#define LLVM_NANS(NanStr)  __builtin_nans(NanStr)  /* Double */
#define LLVM_NANSF(NanStr) __builtin_nansf(NanStr) /* Float */
#define LLVM_INF           __builtin_inf()         /* Double */
#define LLVM_INFF          __builtin_inff()        /* Float */
#define LLVM_PREFETCH(addr,rw,locality) __builtin_prefetch(addr,rw,locality)
#define __ATTRIBUTE_CTOR__ __attribute__((constructor))
#define __ATTRIBUTE_DTOR__ __attribute__((destructor))
#define LLVM_ASM           __asm__
#else
#define LLVM_NAN(NanStr)   ((double)0.0)           /* Double */
#define LLVM_NANF(NanStr)  0.0F                    /* Float */
#define LLVM_NANS(NanStr)  ((double)0.0)           /* Double */
#define LLVM_NANSF(NanStr) 0.0F                    /* Float */
#define LLVM_INF           ((double)0.0)           /* Double */
#define LLVM_INFF          0.0F                    /* Float */
#define LLVM_PREFETCH(addr,rw,locality)            /* PREFETCH */
#define __ATTRIBUTE_CTOR__
#define __ATTRIBUTE_DTOR__
#define LLVM_ASM(X)
#endif

#if __GNUC__ < 4 /* Old GCC's, or compilers not GCC */ 
#define __builtin_stack_save() 0   /* not implemented */
#define __builtin_stack_restore(X) /* noop */
#endif

#if __GNUC__ && __LP64__ /* 128-bit integer types */
typedef int __attribute__((mode(TI))) llvmInt128;
typedef unsigned __attribute__((mode(TI))) llvmUInt128;
#endif

#define CODE_FOR_MAIN() /* Any target-specific code for main()*/

#ifndef __cplusplus
typedef unsigned char bool;
#endif


/* Support for floating point constants */
typedef unsigned long long ConstantDoubleTy;
typedef unsigned int        ConstantFloatTy;
typedef struct { unsigned long long f1; unsigned short f2; unsigned short pad[3]; } ConstantFP80Ty;
typedef struct { unsigned long long f1; unsigned long long f2; } ConstantFP128Ty;


/* Global Declarations */
/* Helper union for bitcasts */
typedef union {
  unsigned int Int32;
  unsigned long long Int64;
  float Float;
  double Double;
} llvmBitCastUnion;

/* Function Declarations */
double fmod(double, double);
float fmodf(float, float);
long double fmodl(long double, long double);
void gcd(signed short llvm_cbe_a, signed short llvm_cbe_b, signed short *llvm_cbe_pResult);


/* Function Bodies */
static inline int llvm_fcmp_ord(double X, double Y) { return X == X && Y == Y; }
static inline int llvm_fcmp_uno(double X, double Y) { return X != X || Y != Y; }
static inline int llvm_fcmp_ueq(double X, double Y) { return X == Y || llvm_fcmp_uno(X, Y); }
static inline int llvm_fcmp_une(double X, double Y) { return X != Y; }
static inline int llvm_fcmp_ult(double X, double Y) { return X <  Y || llvm_fcmp_uno(X, Y); }
static inline int llvm_fcmp_ugt(double X, double Y) { return X >  Y || llvm_fcmp_uno(X, Y); }
static inline int llvm_fcmp_ule(double X, double Y) { return X <= Y || llvm_fcmp_uno(X, Y); }
static inline int llvm_fcmp_uge(double X, double Y) { return X >= Y || llvm_fcmp_uno(X, Y); }
static inline int llvm_fcmp_oeq(double X, double Y) { return X == Y ; }
static inline int llvm_fcmp_one(double X, double Y) { return X != Y && llvm_fcmp_ord(X, Y); }
static inline int llvm_fcmp_olt(double X, double Y) { return X <  Y ; }
static inline int llvm_fcmp_ogt(double X, double Y) { return X >  Y ; }
static inline int llvm_fcmp_ole(double X, double Y) { return X <= Y ; }
static inline int llvm_fcmp_oge(double X, double Y) { return X >= Y ; }

void gcd(signed short llvm_cbe_a, signed short llvm_cbe_b, signed short *llvm_cbe_pResult) {
  static  unsigned long long aesl_llvm_cbe_1_count = 0;
  static  unsigned long long aesl_llvm_cbe_2_count = 0;
  static  unsigned long long aesl_llvm_cbe_3_count = 0;
  static  unsigned long long aesl_llvm_cbe_4_count = 0;
  static  unsigned long long aesl_llvm_cbe_5_count = 0;
  static  unsigned long long aesl_llvm_cbe_6_count = 0;
  static  unsigned long long aesl_llvm_cbe_7_count = 0;
  static  unsigned long long aesl_llvm_cbe_8_count = 0;
  static  unsigned long long aesl_llvm_cbe_9_count = 0;
  static  unsigned long long aesl_llvm_cbe_10_count = 0;
  static  unsigned long long aesl_llvm_cbe_11_count = 0;
  static  unsigned long long aesl_llvm_cbe_12_count = 0;
  static  unsigned long long aesl_llvm_cbe_13_count = 0;
  static  unsigned long long aesl_llvm_cbe_14_count = 0;
  static  unsigned long long aesl_llvm_cbe_15_count = 0;
  static  unsigned long long aesl_llvm_cbe_16_count = 0;
  static  unsigned long long aesl_llvm_cbe_17_count = 0;
  static  unsigned long long aesl_llvm_cbe_18_count = 0;
  unsigned short llvm_cbe_tmp__1;
  unsigned short llvm_cbe_tmp__1__PHI_TEMPORARY;
  static  unsigned long long aesl_llvm_cbe_19_count = 0;
  unsigned short llvm_cbe_tmp__2;
  unsigned short llvm_cbe_tmp__2__PHI_TEMPORARY;
  static  unsigned long long aesl_llvm_cbe_20_count = 0;
  static  unsigned long long aesl_llvm_cbe_21_count = 0;
  unsigned short llvm_cbe_tmp__3;
  static  unsigned long long aesl_llvm_cbe_22_count = 0;
  static  unsigned long long aesl_llvm_cbe_23_count = 0;
  static  unsigned long long aesl_llvm_cbe_24_count = 0;
  static  unsigned long long aesl_llvm_cbe_25_count = 0;
  static  unsigned long long aesl_llvm_cbe_26_count = 0;
  static  unsigned long long aesl_llvm_cbe_27_count = 0;
  unsigned short llvm_cbe_tmp__4;
  static  unsigned long long aesl_llvm_cbe_28_count = 0;
  static  unsigned long long aesl_llvm_cbe_29_count = 0;
  static  unsigned long long aesl_llvm_cbe_30_count = 0;
  static  unsigned long long aesl_llvm_cbe_31_count = 0;
  static  unsigned long long aesl_llvm_cbe_32_count = 0;
  static  unsigned long long aesl_llvm_cbe_33_count = 0;
  static  unsigned long long aesl_llvm_cbe_34_count = 0;
  static  unsigned long long aesl_llvm_cbe__2e_be_count = 0;
  unsigned short llvm_cbe__2e_be;
  static  unsigned long long aesl_llvm_cbe_35_count = 0;
  static  unsigned long long aesl_llvm_cbe__2e_be1_count = 0;
  unsigned short llvm_cbe__2e_be1;
  static  unsigned long long aesl_llvm_cbe_36_count = 0;
  static  unsigned long long aesl_llvm_cbe_37_count = 0;
  static  unsigned long long aesl_llvm_cbe_38_count = 0;
  static  unsigned long long aesl_llvm_cbe__2e_lcssa_count = 0;
  unsigned short llvm_cbe__2e_lcssa;
  unsigned short llvm_cbe__2e_lcssa__PHI_TEMPORARY;
  static  unsigned long long aesl_llvm_cbe_39_count = 0;
  static  unsigned long long aesl_llvm_cbe_40_count = 0;
  static  unsigned long long aesl_llvm_cbe_41_count = 0;
  static  unsigned long long aesl_llvm_cbe_42_count = 0;

const char* AESL_DEBUG_TRACE = getenv("DEBUG_TRACE");
if (AESL_DEBUG_TRACE)
printf("\n\{ BEGIN @gcd\n");
  if (((llvm_cbe_a&65535U) == (llvm_cbe_b&65535U))) {
    llvm_cbe__2e_lcssa__PHI_TEMPORARY = (unsigned short )llvm_cbe_a;   /* for PHI node */
    goto llvm_cbe__2e__crit_edge;
  } else {
    llvm_cbe_tmp__1__PHI_TEMPORARY = (unsigned short )llvm_cbe_a;   /* for PHI node */
    llvm_cbe_tmp__2__PHI_TEMPORARY = (unsigned short )llvm_cbe_b;   /* for PHI node */
    goto llvm_cbe__2e_lr_2e_ph;
  }

  do {     /* Syntactic loop '.lr.ph' to make GCC happy */
llvm_cbe__2e_lr_2e_ph:
if (AESL_DEBUG_TRACE)
printf("\n  %%2 = phi i16 [ %%.be1, %%.lr.ph ], [ %%a, %%0  for 0x%I64xth hint within @gcd  --> \n", ++aesl_llvm_cbe_18_count);
  llvm_cbe_tmp__1 = (unsigned short )llvm_cbe_tmp__1__PHI_TEMPORARY;
if (AESL_DEBUG_TRACE) {
printf("\n = 0x%X",llvm_cbe_tmp__1);
printf("\n.be1 = 0x%X",llvm_cbe__2e_be1);
printf("\na = 0x%X",llvm_cbe_a);
}
if (AESL_DEBUG_TRACE)
printf("\n  %%3 = phi i16 [ %%.be, %%.lr.ph ], [ %%b, %%0  for 0x%I64xth hint within @gcd  --> \n", ++aesl_llvm_cbe_19_count);
  llvm_cbe_tmp__2 = (unsigned short )llvm_cbe_tmp__2__PHI_TEMPORARY;
if (AESL_DEBUG_TRACE) {
printf("\n = 0x%X",llvm_cbe_tmp__2);
printf("\n.be = 0x%X",llvm_cbe__2e_be);
printf("\nb = 0x%X",llvm_cbe_b);
}
if (AESL_DEBUG_TRACE)
printf("\n  %%5 = sub i16 %%3, %%2, !dbg !3 for 0x%I64xth hint within @gcd  --> \n", ++aesl_llvm_cbe_21_count);
  llvm_cbe_tmp__3 = (unsigned short )((unsigned short )(((unsigned short )(llvm_cbe_tmp__2&65535ull)) - ((unsigned short )(llvm_cbe_tmp__1&65535ull))));
if (AESL_DEBUG_TRACE)
printf("\n = 0x%X\n", ((unsigned short )(llvm_cbe_tmp__3&65535ull)));
if (AESL_DEBUG_TRACE)
printf("\n  %%6 = sub i16 %%2, %%3, !dbg !3 for 0x%I64xth hint within @gcd  --> \n", ++aesl_llvm_cbe_27_count);
  llvm_cbe_tmp__4 = (unsigned short )((unsigned short )(((unsigned short )(llvm_cbe_tmp__1&65535ull)) - ((unsigned short )(llvm_cbe_tmp__2&65535ull))));
if (AESL_DEBUG_TRACE)
printf("\n = 0x%X\n", ((unsigned short )(llvm_cbe_tmp__4&65535ull)));
if (AESL_DEBUG_TRACE)
printf("\n  %%.be = select i1 %%4, i16 %%3, i16 %%5, !dbg !3 for 0x%I64xth hint within @gcd  --> \n", ++aesl_llvm_cbe__2e_be_count);
  llvm_cbe__2e_be = (unsigned short )(((((signed short )llvm_cbe_tmp__1) > ((signed short )llvm_cbe_tmp__2))) ? ((unsigned short )llvm_cbe_tmp__2) : ((unsigned short )llvm_cbe_tmp__3));
if (AESL_DEBUG_TRACE)
printf("\n.be = 0x%X\n", llvm_cbe__2e_be);
if (AESL_DEBUG_TRACE)
printf("\n  %%.be1 = select i1 %%4, i16 %%6, i16 %%2, !dbg !3 for 0x%I64xth hint within @gcd  --> \n", ++aesl_llvm_cbe__2e_be1_count);
  llvm_cbe__2e_be1 = (unsigned short )(((((signed short )llvm_cbe_tmp__1) > ((signed short )llvm_cbe_tmp__2))) ? ((unsigned short )llvm_cbe_tmp__4) : ((unsigned short )llvm_cbe_tmp__1));
if (AESL_DEBUG_TRACE)
printf("\n.be1 = 0x%X\n", llvm_cbe__2e_be1);
  if (((llvm_cbe__2e_be1&65535U) == (llvm_cbe__2e_be&65535U))) {
    llvm_cbe__2e_lcssa__PHI_TEMPORARY = (unsigned short )llvm_cbe__2e_be;   /* for PHI node */
    goto llvm_cbe__2e__crit_edge;
  } else {
    llvm_cbe_tmp__1__PHI_TEMPORARY = (unsigned short )llvm_cbe__2e_be1;   /* for PHI node */
    llvm_cbe_tmp__2__PHI_TEMPORARY = (unsigned short )llvm_cbe__2e_be;   /* for PHI node */
    goto llvm_cbe__2e_lr_2e_ph;
  }

  } while (1); /* end of syntactic loop '.lr.ph' */
llvm_cbe__2e__crit_edge:
if (AESL_DEBUG_TRACE)
printf("\n  %%.lcssa = phi i16 [ %%a, %%0 ], [ %%.be, %%.lr.ph  for 0x%I64xth hint within @gcd  --> \n", ++aesl_llvm_cbe__2e_lcssa_count);
  llvm_cbe__2e_lcssa = (unsigned short )llvm_cbe__2e_lcssa__PHI_TEMPORARY;
if (AESL_DEBUG_TRACE) {
printf("\n.lcssa = 0x%X",llvm_cbe__2e_lcssa);
printf("\na = 0x%X",llvm_cbe_a);
printf("\n.be = 0x%X",llvm_cbe__2e_be);
}
if (AESL_DEBUG_TRACE)
printf("\n  store i16 %%.lcssa, i16* %%pResult, align 2, !dbg !4 for 0x%I64xth hint within @gcd  --> \n", ++aesl_llvm_cbe_41_count);
  *llvm_cbe_pResult = llvm_cbe__2e_lcssa;
if (AESL_DEBUG_TRACE)
printf("\n.lcssa = 0x%X\n", llvm_cbe__2e_lcssa);
  if (AESL_DEBUG_TRACE)
      printf("\nEND @gcd}\n");
  return;
}

