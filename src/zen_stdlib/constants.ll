; ModuleID = 'constants.ll'
source_filename = "constants.ll"

@PI = local_unnamed_addr constant double 0x400921FB54442D18
@TAU = local_unnamed_addr constant double 0x401921FB54442D18
@E = local_unnamed_addr constant double 0x4005BF0A8B145769
@PHI = local_unnamed_addr constant double 0x3FF9E3779B97F4A8
@SQRT2 = local_unnamed_addr constant double 0x3FF6A09E667F3BCD
@SQRT1_2 = local_unnamed_addr constant double 0x3FE6A09E667F3BCD
@SQRT3 = local_unnamed_addr constant double 0x3FFBB67AE8584CAA

@LN2 = local_unnamed_addr constant double 0x3FE62E42FEFA39EF
@LN10 = local_unnamed_addr constant double 0x40026BB1BBB55516
@LOG2E = local_unnamed_addr constant double 0x3FF71547652B82FE
@LOG10E = local_unnamed_addr constant double 0x3FDBCB7B1526E50E

@BYTE_MAX = local_unnamed_addr constant i8 127
@BYTE_MIN = local_unnamed_addr constant i8 -128

@I32_MAX = local_unnamed_addr constant i32 2147483647
@I32_MIN = local_unnamed_addr constant i32 -2147483648

@I64_MAX = local_unnamed_addr constant i64 9223372036854775807
@I64_MIN = local_unnamed_addr constant i64 -9223372036854775808

@F64_MAX = local_unnamed_addr constant double 0x7FEFFFFFFFFFFFFF
@F64_MIN = local_unnamed_addr constant double 0xFFEFFFFFFFFFFFFF
@F64_EPS = local_unnamed_addr constant double 0x3CB0000000000000

@INF = local_unnamed_addr constant double 0x7FF0000000000000
@NEG_INF = local_unnamed_addr constant double 0xFFF0000000000000
@NAN = local_unnamed_addr constant double 0x7FF8000000000000

@SEED = global i64 123456789