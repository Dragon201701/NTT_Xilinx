
# Loop constraints
directive set /inPlaceNTT_DIT/core/core:rlp CSTEPS_FROM {{. == 0}}
directive set /inPlaceNTT_DIT/core/core:rlp/main CSTEPS_FROM {{. == 2} {.. == 0}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP CSTEPS_FROM {{. == 7} {.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while CSTEPS_FROM {{. == 25} {.. == 6}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP CSTEPS_FROM {{. == 2} {.. == 6}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP CSTEPS_FROM {{. == 81} {.. == 0}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:modExp#1:while CSTEPS_FROM {{. == 25} {.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:modExp#1:while CSTEPS_FROM {{. == 25} {.. == 42}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP CSTEPS_FROM {{. == 81} {.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:modExp#1:while CSTEPS_FROM {{. == 25} {.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:modExp#1:while CSTEPS_FROM {{. == 25} {.. == 42}}

# IO operation constraints
directive set /inPlaceNTT_DIT/core/core:rlp/main/p:io_read(p:rsc.@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/r:io_read(r:rsc.@) CSTEPS_FROM {{.. == 1}}

# Sync operation constraints

# Real operation constraints
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/STAGE_LOOP:lshift CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/operator-<64,false>:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/operator_<66,true>:div CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/operator><64,false>:acc#1 CSTEPS_FROM {{.. == 6}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/modExp:while:if:mul CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/modulo:result:rem CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/modulo:qelse:acc CSTEPS_FROM {{.. == 13}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/modExp:while:modExp:while:mux1h CSTEPS_FROM {{.. == 13}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/modExp:while:mul CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/modulo#1:result:rem CSTEPS_FROM {{.. == 13}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/modulo#1:qelse:acc CSTEPS_FROM {{.. == 25}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/modulo#1:mux CSTEPS_FROM {{.. == 25}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/operator><64,false>:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(0).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(1).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:mux#29 CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:operator><64,false>#1:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:modExp#1:while/VEC_LOOP-1:COMP_LOOP-1:modExp#1:while:if:mul CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:modExp#1:while/VEC_LOOP-1:COMP_LOOP-1:modulo#2:result:rem CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:modExp#1:while/VEC_LOOP-1:COMP_LOOP-1:modulo#2:qelse:acc CSTEPS_FROM {{.. == 13}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:modExp#1:while/VEC_LOOP-1:COMP_LOOP-1:modExp#1:while:mul CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:modExp#1:while/VEC_LOOP-1:COMP_LOOP-1:modulo#3:result:rem CSTEPS_FROM {{.. == 13}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:modExp#1:while/VEC_LOOP-1:COMP_LOOP-1:modulo#3:qelse:acc CSTEPS_FROM {{.. == 25}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:modExp#1:while/modulo#3:mux CSTEPS_FROM {{.. == 25}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:modExp#1:while/modExp#1:while:modExp#1:while:mux1h CSTEPS_FROM {{.. == 13}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:modExp#1:while/VEC_LOOP-1:COMP_LOOP-1:operator><64,false>#1:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:acc CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:acc#10 CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(0).@)#1 CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(1).@)#1 CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:mux#1 CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:mul CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:modulo#4:result:rem CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:modulo#4:qelse:acc CSTEPS_FROM {{.. == 16}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/modulo#4:mux CSTEPS_FROM {{.. == 16}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:acc#5 CSTEPS_FROM {{.. == 16}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:modulo#5:result:rem CSTEPS_FROM {{.. == 16}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:modulo#5:qelse:acc CSTEPS_FROM {{.. == 28}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/modulo#5:mux CSTEPS_FROM {{.. == 28}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(0).@) CSTEPS_FROM {{.. == 28}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(1).@) CSTEPS_FROM {{.. == 28}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:acc#8 CSTEPS_FROM {{.. == 16}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:modulo#6:result:rem CSTEPS_FROM {{.. == 28}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:modulo#6:qelse:acc CSTEPS_FROM {{.. == 40}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/modulo#6:mux CSTEPS_FROM {{.. == 40}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(0).@)#1 CSTEPS_FROM {{.. == 40}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(1).@)#1 CSTEPS_FROM {{.. == 40}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:acc CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(0).@)#2 CSTEPS_FROM {{.. == 41}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(1).@)#2 CSTEPS_FROM {{.. == 41}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:mux#2 CSTEPS_FROM {{.. == 42}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:modExp#1:while/VEC_LOOP-1:COMP_LOOP-2:modExp#1:while:if:mul CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:modExp#1:while/VEC_LOOP-1:COMP_LOOP-2:modulo#2:result:rem CSTEPS_FROM {{.. == 13}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:modExp#1:while/VEC_LOOP-1:COMP_LOOP-2:modulo#2:qelse:acc CSTEPS_FROM {{.. == 25}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:modExp#1:while/modExp#1:while:modExp#1:while:mux1h#1 CSTEPS_FROM {{.. == 25}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:modExp#1:while/VEC_LOOP-1:COMP_LOOP-2:modExp#1:while:mul CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:modExp#1:while/VEC_LOOP-1:COMP_LOOP-2:modulo#3:result:rem CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:modExp#1:while/VEC_LOOP-1:COMP_LOOP-2:modulo#3:qelse:acc CSTEPS_FROM {{.. == 13}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:modExp#1:while/VEC_LOOP-1:COMP_LOOP-2:operator><64,false>#1:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:modExp#1:while/modulo#3:mux#1 CSTEPS_FROM {{.. == 13}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:acc#11 CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:acc#10 CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(0).@)#3 CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(1).@)#3 CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:mux#3 CSTEPS_FROM {{.. == 44}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:mul CSTEPS_FROM {{.. == 44}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:modulo#4:result:rem CSTEPS_FROM {{.. == 44}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:modulo#4:qelse:acc CSTEPS_FROM {{.. == 56}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/modulo#4:mux#1 CSTEPS_FROM {{.. == 56}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:acc#5 CSTEPS_FROM {{.. == 56}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:modulo#5:result:rem CSTEPS_FROM {{.. == 56}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:modulo#5:qelse:acc CSTEPS_FROM {{.. == 68}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/modulo#5:mux#1 CSTEPS_FROM {{.. == 68}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(0).@)#2 CSTEPS_FROM {{.. == 68}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(1).@)#2 CSTEPS_FROM {{.. == 68}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:acc#8 CSTEPS_FROM {{.. == 56}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:modulo#6:result:rem CSTEPS_FROM {{.. == 68}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-2:modulo#6:qelse:acc CSTEPS_FROM {{.. == 80}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/modulo#6:mux#1 CSTEPS_FROM {{.. == 80}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(0).@)#3 CSTEPS_FROM {{.. == 80}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(1).@)#3 CSTEPS_FROM {{.. == 80}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP:slc(COMP_LOOP-2:COMP_LOOP:acc CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:COMP_LOOP/VEC_LOOP-1:COMP_LOOP-1:acc CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-1:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(0).@)#4 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(1).@)#4 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:mux#30 CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:operator><64,false>#1:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:modExp#1:while/VEC_LOOP-2:COMP_LOOP-1:modExp#1:while:if:mul CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:modExp#1:while/VEC_LOOP-2:COMP_LOOP-1:modulo#2:result:rem CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:modExp#1:while/VEC_LOOP-2:COMP_LOOP-1:modulo#2:qelse:acc CSTEPS_FROM {{.. == 13}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:modExp#1:while/VEC_LOOP-2:COMP_LOOP-1:modExp#1:while:mul CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:modExp#1:while/VEC_LOOP-2:COMP_LOOP-1:modulo#3:result:rem CSTEPS_FROM {{.. == 13}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:modExp#1:while/VEC_LOOP-2:COMP_LOOP-1:modulo#3:qelse:acc CSTEPS_FROM {{.. == 25}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:modExp#1:while/modulo#3:mux#2 CSTEPS_FROM {{.. == 25}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:modExp#1:while/modExp#1:while:modExp#1:while:mux1h#2 CSTEPS_FROM {{.. == 13}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:modExp#1:while/VEC_LOOP-2:COMP_LOOP-1:operator><64,false>#1:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:acc#12 CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:acc#10 CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(0).@)#5 CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(1).@)#5 CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:mux#31 CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:mul CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:modulo#4:result:rem CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:modulo#4:qelse:acc CSTEPS_FROM {{.. == 16}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/modulo#4:mux#2 CSTEPS_FROM {{.. == 16}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:acc#5 CSTEPS_FROM {{.. == 16}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:modulo#5:result:rem CSTEPS_FROM {{.. == 16}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:modulo#5:qelse:acc CSTEPS_FROM {{.. == 28}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/modulo#5:mux#2 CSTEPS_FROM {{.. == 28}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(0).@)#4 CSTEPS_FROM {{.. == 28}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(1).@)#4 CSTEPS_FROM {{.. == 28}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:acc#8 CSTEPS_FROM {{.. == 16}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:modulo#6:result:rem CSTEPS_FROM {{.. == 28}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:modulo#6:qelse:acc CSTEPS_FROM {{.. == 40}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/modulo#6:mux#2 CSTEPS_FROM {{.. == 40}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(0).@)#5 CSTEPS_FROM {{.. == 40}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(1).@)#5 CSTEPS_FROM {{.. == 40}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:acc CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(0).@)#6 CSTEPS_FROM {{.. == 41}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(1).@)#6 CSTEPS_FROM {{.. == 41}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:mux#32 CSTEPS_FROM {{.. == 42}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:modExp#1:while/VEC_LOOP-2:COMP_LOOP-2:modExp#1:while:if:mul CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:modExp#1:while/VEC_LOOP-2:COMP_LOOP-2:modulo#2:result:rem CSTEPS_FROM {{.. == 13}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:modExp#1:while/VEC_LOOP-2:COMP_LOOP-2:modulo#2:qelse:acc CSTEPS_FROM {{.. == 25}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:modExp#1:while/modExp#1:while:modExp#1:while:mux1h#3 CSTEPS_FROM {{.. == 25}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:modExp#1:while/VEC_LOOP-2:COMP_LOOP-2:modExp#1:while:mul CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:modExp#1:while/VEC_LOOP-2:COMP_LOOP-2:modulo#3:result:rem CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:modExp#1:while/VEC_LOOP-2:COMP_LOOP-2:modulo#3:qelse:acc CSTEPS_FROM {{.. == 13}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:modExp#1:while/VEC_LOOP-2:COMP_LOOP-2:operator><64,false>#1:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:modExp#1:while/modulo#3:mux#3 CSTEPS_FROM {{.. == 13}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:acc#13 CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:acc#10 CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(0).@)#7 CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(1).@)#7 CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:mux#33 CSTEPS_FROM {{.. == 44}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:mul CSTEPS_FROM {{.. == 44}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:modulo#4:result:rem CSTEPS_FROM {{.. == 44}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:modulo#4:qelse:acc CSTEPS_FROM {{.. == 56}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/modulo#4:mux#3 CSTEPS_FROM {{.. == 56}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:acc#5 CSTEPS_FROM {{.. == 56}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:modulo#5:result:rem CSTEPS_FROM {{.. == 56}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:modulo#5:qelse:acc CSTEPS_FROM {{.. == 68}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/modulo#5:mux#3 CSTEPS_FROM {{.. == 68}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(0).@)#6 CSTEPS_FROM {{.. == 68}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(1).@)#6 CSTEPS_FROM {{.. == 68}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:acc#8 CSTEPS_FROM {{.. == 56}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:modulo#6:result:rem CSTEPS_FROM {{.. == 68}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-2:modulo#6:qelse:acc CSTEPS_FROM {{.. == 80}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/modulo#6:mux#3 CSTEPS_FROM {{.. == 80}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(0).@)#7 CSTEPS_FROM {{.. == 80}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(1).@)#7 CSTEPS_FROM {{.. == 80}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP:slc(COMP_LOOP-2:COMP_LOOP:acc CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:COMP_LOOP/VEC_LOOP-2:COMP_LOOP-1:acc CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP-2:acc#1 CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/STAGE_LOOP:acc#1 CSTEPS_FROM {{.. == 7}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/STAGE_LOOP:acc CSTEPS_FROM {{.. == 7}}

# Probe constraints
