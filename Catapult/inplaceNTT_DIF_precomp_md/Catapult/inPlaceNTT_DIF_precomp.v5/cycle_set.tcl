
# Loop constraints
directive set /inPlaceNTT_DIF_precomp/core/core:rlp CSTEPS_FROM {{. == 0}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main CSTEPS_FROM {{. == 3} {.. == 0}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP CSTEPS_FROM {{. == 2} {.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP CSTEPS_FROM {{. == 5} {.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP CSTEPS_FROM {{. == 12} {.. == 4}}

# IO operation constraints
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/p:io_read(p:rsc.@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/r:io_read(r:rsc.@) CSTEPS_FROM {{.. == 1}}

# Sync operation constraints
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/io_read(run) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/if:io_write(complete) CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/io_read(run) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/STAGE_LOOP:lshift CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:lshift CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:mul CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:read_mem(twiddle:rsc(0)(0).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_help:read_mem(twiddle_h:rsc(0)(0).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:read_mem(twiddle:rsc(0)(1).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_help:read_mem(twiddle_h:rsc(0)(1).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:read_mem(twiddle:rsc(0)(2).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_help:read_mem(twiddle_h:rsc(0)(2).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:read_mem(twiddle:rsc(0)(3).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_help:read_mem(twiddle_h:rsc(0)(3).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:read_mem(twiddle:rsc(0)(4).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_help:read_mem(twiddle_h:rsc(0)(4).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:read_mem(twiddle:rsc(0)(5).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_help:read_mem(twiddle_h:rsc(0)(5).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:read_mem(twiddle:rsc(0)(6).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_help:read_mem(twiddle_h:rsc(0)(6).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:read_mem(twiddle:rsc(0)(7).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_help:read_mem(twiddle_h:rsc(0)(7).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:read_mem(twiddle:rsc(1)(0).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_help:read_mem(twiddle_h:rsc(1)(0).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:read_mem(twiddle:rsc(1)(1).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_help:read_mem(twiddle_h:rsc(1)(1).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:read_mem(twiddle:rsc(1)(2).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_help:read_mem(twiddle_h:rsc(1)(2).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:read_mem(twiddle:rsc(1)(3).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_help:read_mem(twiddle_h:rsc(1)(3).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:read_mem(twiddle:rsc(1)(4).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_help:read_mem(twiddle_h:rsc(1)(4).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:read_mem(twiddle:rsc(1)(5).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_help:read_mem(twiddle_h:rsc(1)(5).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:read_mem(twiddle:rsc(1)(6).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_help:read_mem(twiddle_h:rsc(1)(6).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:read_mem(twiddle:rsc(1)(7).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_help:read_mem(twiddle_h:rsc(1)(7).@) CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:mux1h CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:twiddle_f:mux1h#1 CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(0)(0).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(0)(1).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(0)(2).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(0)(3).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(0)(4).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(0)(5).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(0)(6).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(0)(7).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(1)(0).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(1)(1).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(1)(2).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(1)(3).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(1)(4).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(1)(5).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(1)(6).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(1)(7).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:mux1h CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:acc#10 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(0)(0).@)#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(0)(1).@)#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(0)(2).@)#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(0)(3).@)#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(0)(4).@)#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(0)(5).@)#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(0)(6).@)#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(0)(7).@)#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(1)(0).@)#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(1)(1).@)#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(1)(2).@)#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(1)(3).@)#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(1)(4).@)#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(1)(5).@)#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(1)(6).@)#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:read_mem(vec:rsc(1)(7).@)#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:mux1h#1 CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:acc#5 CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/modulo_add() CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(0)(0).@) CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(0)(1).@) CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(0)(2).@) CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(0)(3).@) CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(0)(4).@) CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(0)(5).@) CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(0)(6).@) CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(0)(7).@) CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(1)(0).@) CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(1)(1).@) CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(1)(2).@) CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(1)(3).@) CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(1)(4).@) CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(1)(5).@) CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(1)(6).@) CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(1)(7).@) CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:acc#8 CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/modulo_sub() CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/mult() CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(0)(0).@)#1 CSTEPS_FROM {{.. == 11}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(0)(1).@)#1 CSTEPS_FROM {{.. == 11}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(0)(2).@)#1 CSTEPS_FROM {{.. == 11}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(0)(3).@)#1 CSTEPS_FROM {{.. == 11}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(0)(4).@)#1 CSTEPS_FROM {{.. == 11}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(0)(5).@)#1 CSTEPS_FROM {{.. == 11}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(0)(6).@)#1 CSTEPS_FROM {{.. == 11}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(0)(7).@)#1 CSTEPS_FROM {{.. == 11}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(1)(0).@)#1 CSTEPS_FROM {{.. == 11}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(1)(1).@)#1 CSTEPS_FROM {{.. == 11}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(1)(2).@)#1 CSTEPS_FROM {{.. == 11}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(1)(3).@)#1 CSTEPS_FROM {{.. == 11}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(1)(4).@)#1 CSTEPS_FROM {{.. == 11}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(1)(5).@)#1 CSTEPS_FROM {{.. == 11}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(1)(6).@)#1 CSTEPS_FROM {{.. == 11}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:write_mem(vec:rsc(1)(7).@)#1 CSTEPS_FROM {{.. == 11}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/VEC_LOOP/VEC_LOOP:acc#9 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:acc#1 CSTEPS_FROM {{.. == 5}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/COMP_LOOP/COMP_LOOP:acc CSTEPS_FROM {{.. == 5}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/STAGE_LOOP:acc#1 CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/STAGE_LOOP/STAGE_LOOP:acc CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIF_precomp/core/core:rlp/main/if:io_write(complete) CSTEPS_FROM {{.. == 1}}

# Probe constraints
