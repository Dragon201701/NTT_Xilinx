
# Loop constraints
directive set /inPlaceNTT_DIT/core/core:rlp CSTEPS_FROM {{. == 0}}
directive set /inPlaceNTT_DIT/core/core:rlp/main CSTEPS_FROM {{. == 2} {.. == 0}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP CSTEPS_FROM {{. == 10} {.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while CSTEPS_FROM {{. == 39} {.. == 9}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP CSTEPS_FROM {{. == 1} {.. == 9}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP CSTEPS_FROM {{. == 249} {.. == 0}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:modExp#1:while CSTEPS_FROM {{. == 39} {.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:modExp#1:while CSTEPS_FROM {{. == 39} {.. == 64}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:modExp#1:while CSTEPS_FROM {{. == 39} {.. == 126}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:modExp#1:while CSTEPS_FROM {{. == 39} {.. == 188}}

# IO operation constraints
directive set /inPlaceNTT_DIT/core/core:rlp/main/p:io_read(p:rsc.@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/r:io_read(r:rsc.@) CSTEPS_FROM {{.. == 1}}

# Sync operation constraints

# Real operation constraints
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/STAGE_LOOP:lshift CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/operator-<64,false>:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/operator_<66,true>:div CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/operator><64,false>:acc#1 CSTEPS_FROM {{.. == 9}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/modExp:while:if:mul CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/modulo:result:rem CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/modulo:qelse:acc CSTEPS_FROM {{.. == 20}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/modExp:while:modExp:while:mux1h CSTEPS_FROM {{.. == 20}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/modExp:while:mul CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/modulo#1:result:rem CSTEPS_FROM {{.. == 20}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/modulo#1:qelse:acc CSTEPS_FROM {{.. == 39}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/modulo#1:mux CSTEPS_FROM {{.. == 39}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/modExp:while/operator><64,false>:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(0).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(1).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(2).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(3).@) CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:mux1h#83 CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/operator><64,false>#1:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:modExp#1:while/COMP_LOOP-1:modExp#1:while:if:mul CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:modExp#1:while/COMP_LOOP-1:modulo#2:result:rem CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:modExp#1:while/COMP_LOOP-1:modulo#2:qelse:acc CSTEPS_FROM {{.. == 20}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:modExp#1:while/COMP_LOOP-1:modExp#1:while:mul CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:modExp#1:while/COMP_LOOP-1:modulo#3:result:rem CSTEPS_FROM {{.. == 20}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:modExp#1:while/COMP_LOOP-1:modulo#3:qelse:acc CSTEPS_FROM {{.. == 39}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:modExp#1:while/modulo#3:mux CSTEPS_FROM {{.. == 39}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:modExp#1:while/modExp#1:while:modExp#1:while:mux1h CSTEPS_FROM {{.. == 20}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:modExp#1:while/COMP_LOOP-1:operator><64,false>#1:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:acc#30 CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:acc#10 CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(0).@)#1 CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(1).@)#1 CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(2).@)#1 CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(3).@)#1 CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:mux1h#1 CSTEPS_FROM {{.. == 4}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:mul CSTEPS_FROM {{.. == 5}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:modulo#4:result:rem CSTEPS_FROM {{.. == 5}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:modulo#4:qelse:acc CSTEPS_FROM {{.. == 24}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/modulo#4:mux CSTEPS_FROM {{.. == 24}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:acc#5 CSTEPS_FROM {{.. == 24}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:modulo#5:result:rem CSTEPS_FROM {{.. == 24}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:modulo#5:qelse:acc CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/modulo#5:mux CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(0).@) CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(1).@) CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(2).@) CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(3).@) CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:acc#8 CSTEPS_FROM {{.. == 24}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:modulo#6:result:rem CSTEPS_FROM {{.. == 43}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:modulo#6:qelse:acc CSTEPS_FROM {{.. == 62}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/modulo#6:mux CSTEPS_FROM {{.. == 62}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(0).@)#1 CSTEPS_FROM {{.. == 62}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(1).@)#1 CSTEPS_FROM {{.. == 62}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(2).@)#1 CSTEPS_FROM {{.. == 62}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(3).@)#1 CSTEPS_FROM {{.. == 62}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:acc CSTEPS_FROM {{.. == 3}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(0).@)#2 CSTEPS_FROM {{.. == 63}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(1).@)#2 CSTEPS_FROM {{.. == 63}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(2).@)#2 CSTEPS_FROM {{.. == 63}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(3).@)#2 CSTEPS_FROM {{.. == 63}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:mux1h#2 CSTEPS_FROM {{.. == 64}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:modExp#1:while/COMP_LOOP-2:modExp#1:while:if:mul CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:modExp#1:while/COMP_LOOP-2:modulo#2:result:rem CSTEPS_FROM {{.. == 20}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:modExp#1:while/COMP_LOOP-2:modulo#2:qelse:acc CSTEPS_FROM {{.. == 39}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:modExp#1:while/modExp#1:while:modExp#1:while:mux1h#1 CSTEPS_FROM {{.. == 39}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:modExp#1:while/COMP_LOOP-2:modExp#1:while:mul CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:modExp#1:while/COMP_LOOP-2:modulo#3:result:rem CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:modExp#1:while/COMP_LOOP-2:modulo#3:qelse:acc CSTEPS_FROM {{.. == 20}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:modExp#1:while/COMP_LOOP-2:operator><64,false>#1:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:modExp#1:while/modulo#3:mux#1 CSTEPS_FROM {{.. == 20}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:acc#31 CSTEPS_FROM {{.. == 65}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:acc#10 CSTEPS_FROM {{.. == 65}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(0).@)#3 CSTEPS_FROM {{.. == 65}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(1).@)#3 CSTEPS_FROM {{.. == 65}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(2).@)#3 CSTEPS_FROM {{.. == 65}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(3).@)#3 CSTEPS_FROM {{.. == 65}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:mux1h#3 CSTEPS_FROM {{.. == 66}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:mul CSTEPS_FROM {{.. == 67}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:modulo#4:result:rem CSTEPS_FROM {{.. == 67}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:modulo#4:qelse:acc CSTEPS_FROM {{.. == 86}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/modulo#4:mux#1 CSTEPS_FROM {{.. == 86}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:acc#5 CSTEPS_FROM {{.. == 86}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:modulo#5:result:rem CSTEPS_FROM {{.. == 86}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:modulo#5:qelse:acc CSTEPS_FROM {{.. == 105}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/modulo#5:mux#1 CSTEPS_FROM {{.. == 105}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(0).@)#2 CSTEPS_FROM {{.. == 105}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(1).@)#2 CSTEPS_FROM {{.. == 105}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(2).@)#2 CSTEPS_FROM {{.. == 105}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(3).@)#2 CSTEPS_FROM {{.. == 105}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:acc#8 CSTEPS_FROM {{.. == 86}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:modulo#6:result:rem CSTEPS_FROM {{.. == 105}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-2:modulo#6:qelse:acc CSTEPS_FROM {{.. == 124}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/modulo#6:mux#1 CSTEPS_FROM {{.. == 124}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(0).@)#3 CSTEPS_FROM {{.. == 124}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(1).@)#3 CSTEPS_FROM {{.. == 124}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(2).@)#3 CSTEPS_FROM {{.. == 124}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(3).@)#3 CSTEPS_FROM {{.. == 124}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:acc CSTEPS_FROM {{.. == 65}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:acc#11 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(0).@)#4 CSTEPS_FROM {{.. == 125}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(1).@)#4 CSTEPS_FROM {{.. == 125}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(2).@)#4 CSTEPS_FROM {{.. == 125}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(3).@)#4 CSTEPS_FROM {{.. == 125}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:mux1h#4 CSTEPS_FROM {{.. == 126}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:modExp#1:while/COMP_LOOP-3:modExp#1:while:if:mul CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:modExp#1:while/COMP_LOOP-3:modulo#2:result:rem CSTEPS_FROM {{.. == 20}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:modExp#1:while/COMP_LOOP-3:modulo#2:qelse:acc CSTEPS_FROM {{.. == 39}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:modExp#1:while/modExp#1:while:modExp#1:while:mux1h#2 CSTEPS_FROM {{.. == 39}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:modExp#1:while/COMP_LOOP-3:modExp#1:while:mul CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:modExp#1:while/COMP_LOOP-3:modulo#3:result:rem CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:modExp#1:while/COMP_LOOP-3:modulo#3:qelse:acc CSTEPS_FROM {{.. == 20}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:modExp#1:while/COMP_LOOP-3:operator><64,false>#1:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:modExp#1:while/modulo#3:mux#2 CSTEPS_FROM {{.. == 20}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:acc#32 CSTEPS_FROM {{.. == 127}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:acc#10 CSTEPS_FROM {{.. == 127}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(0).@)#5 CSTEPS_FROM {{.. == 127}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(1).@)#5 CSTEPS_FROM {{.. == 127}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(2).@)#5 CSTEPS_FROM {{.. == 127}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(3).@)#5 CSTEPS_FROM {{.. == 127}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:mux1h#5 CSTEPS_FROM {{.. == 128}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:mul CSTEPS_FROM {{.. == 129}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:modulo#4:result:rem CSTEPS_FROM {{.. == 129}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:modulo#4:qelse:acc CSTEPS_FROM {{.. == 148}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/modulo#4:mux#2 CSTEPS_FROM {{.. == 148}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:acc#5 CSTEPS_FROM {{.. == 148}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:modulo#5:result:rem CSTEPS_FROM {{.. == 148}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:modulo#5:qelse:acc CSTEPS_FROM {{.. == 167}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/modulo#5:mux#2 CSTEPS_FROM {{.. == 167}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(0).@)#4 CSTEPS_FROM {{.. == 167}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(1).@)#4 CSTEPS_FROM {{.. == 167}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(2).@)#4 CSTEPS_FROM {{.. == 167}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(3).@)#4 CSTEPS_FROM {{.. == 167}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:acc#8 CSTEPS_FROM {{.. == 148}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:modulo#6:result:rem CSTEPS_FROM {{.. == 167}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-3:modulo#6:qelse:acc CSTEPS_FROM {{.. == 186}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/modulo#6:mux#2 CSTEPS_FROM {{.. == 186}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(0).@)#5 CSTEPS_FROM {{.. == 186}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(1).@)#5 CSTEPS_FROM {{.. == 186}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(2).@)#5 CSTEPS_FROM {{.. == 186}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(3).@)#5 CSTEPS_FROM {{.. == 186}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:acc#12 CSTEPS_FROM {{.. == 127}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(0).@)#6 CSTEPS_FROM {{.. == 187}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(1).@)#6 CSTEPS_FROM {{.. == 187}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(2).@)#6 CSTEPS_FROM {{.. == 187}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(3).@)#6 CSTEPS_FROM {{.. == 187}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:mux1h#6 CSTEPS_FROM {{.. == 188}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:modExp#1:while/COMP_LOOP-4:modExp#1:while:if:mul CSTEPS_FROM {{.. == 2}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:modExp#1:while/COMP_LOOP-4:modulo#2:result:rem CSTEPS_FROM {{.. == 20}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:modExp#1:while/COMP_LOOP-4:modulo#2:qelse:acc CSTEPS_FROM {{.. == 39}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:modExp#1:while/modExp#1:while:modExp#1:while:mux1h#3 CSTEPS_FROM {{.. == 39}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:modExp#1:while/COMP_LOOP-4:modExp#1:while:mul CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:modExp#1:while/COMP_LOOP-4:modulo#3:result:rem CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:modExp#1:while/COMP_LOOP-4:modulo#3:qelse:acc CSTEPS_FROM {{.. == 20}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:modExp#1:while/COMP_LOOP-4:operator><64,false>#1:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:modExp#1:while/modulo#3:mux#3 CSTEPS_FROM {{.. == 20}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:acc#33 CSTEPS_FROM {{.. == 189}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:acc#10 CSTEPS_FROM {{.. == 189}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(0).@)#7 CSTEPS_FROM {{.. == 189}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(1).@)#7 CSTEPS_FROM {{.. == 189}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(2).@)#7 CSTEPS_FROM {{.. == 189}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:read_mem(vec:rsc(0)(3).@)#7 CSTEPS_FROM {{.. == 189}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:mux1h#7 CSTEPS_FROM {{.. == 190}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:mul CSTEPS_FROM {{.. == 191}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:modulo#4:result:rem CSTEPS_FROM {{.. == 191}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:modulo#4:qelse:acc CSTEPS_FROM {{.. == 210}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/modulo#4:mux#3 CSTEPS_FROM {{.. == 210}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:acc#5 CSTEPS_FROM {{.. == 210}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:modulo#5:result:rem CSTEPS_FROM {{.. == 210}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:modulo#5:qelse:acc CSTEPS_FROM {{.. == 229}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/modulo#5:mux#3 CSTEPS_FROM {{.. == 229}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(0).@)#6 CSTEPS_FROM {{.. == 229}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(1).@)#6 CSTEPS_FROM {{.. == 229}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(2).@)#6 CSTEPS_FROM {{.. == 229}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(3).@)#6 CSTEPS_FROM {{.. == 229}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:acc#8 CSTEPS_FROM {{.. == 210}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:modulo#6:result:rem CSTEPS_FROM {{.. == 229}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-4:modulo#6:qelse:acc CSTEPS_FROM {{.. == 248}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/modulo#6:mux#3 CSTEPS_FROM {{.. == 248}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(0).@)#7 CSTEPS_FROM {{.. == 248}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(1).@)#7 CSTEPS_FROM {{.. == 248}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(2).@)#7 CSTEPS_FROM {{.. == 248}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:write_mem(vec:rsc(0)(3).@)#7 CSTEPS_FROM {{.. == 248}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP:acc#13 CSTEPS_FROM {{.. == 189}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/COMP_LOOP/COMP_LOOP-1:acc CSTEPS_FROM {{.. == 189}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP:acc#1 CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/VEC_LOOP/VEC_LOOP:acc CSTEPS_FROM {{.. == 1}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/STAGE_LOOP:acc#1 CSTEPS_FROM {{.. == 10}}
directive set /inPlaceNTT_DIT/core/core:rlp/main/STAGE_LOOP/STAGE_LOOP:acc CSTEPS_FROM {{.. == 10}}

# Probe constraints
