directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/STAGE_MAIN_LOOP:acc#1.psp.sva REGISTER_NAME STAGE_MAIN_LOOP:acc#1.psp.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/STAGE_MAIN_LOOP:i(3:0).sva REGISTER_NAME STAGE_MAIN_LOOP:acc#1.psp.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/COMP_LOOP:acc.psp.sva REGISTER_NAME COMP_LOOP:acc.psp.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/modExp_dev:exp#1.sva(8:1) REGISTER_NAME COMP_LOOP:acc.psp.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/modExp_dev:exp#2.sva(8:1) REGISTER_NAME COMP_LOOP:acc.psp.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/tmp#1.lpi#4.dfm REGISTER_NAME tmp#1.lpi#4.dfm
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/tmp#3.lpi#4.dfm REGISTER_NAME tmp#1.lpi#4.dfm
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/exit:COMP_LOOP-1:modExp_dev#1:while.sva REGISTER_NAME exit:COMP_LOOP-1:modExp_dev#1:while.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/exit:COMP_LOOP-2:modExp_dev#1:while.sva REGISTER_NAME exit:COMP_LOOP-1:modExp_dev#1:while.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/exit:modExp_dev:while.sva REGISTER_NAME exit:COMP_LOOP-1:modExp_dev#1:while.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/COMP_LOOP-2:operator<<64,false>:slc(operator<<64,false>:acc)(63).itm REGISTER_NAME exit:COMP_LOOP-1:modExp_dev#1:while.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/exit:COMP_LOOP.sva REGISTER_NAME exit:COMP_LOOP-1:modExp_dev#1:while.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/COMP_LOOP-1:modExp_dev#1:while:mul.mut REGISTER_NAME COMP_LOOP-1:modExp_dev#1:while:mul.mut
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/COMP_LOOP-2:modExp_dev#1:while:mul.mut REGISTER_NAME COMP_LOOP-1:modExp_dev#1:while:mul.mut
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/modExp_dev:while:mul.mut REGISTER_NAME COMP_LOOP-1:modExp_dev#1:while:mul.mut
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/COMP_LOOP-1:mul.itm REGISTER_NAME COMP_LOOP-1:modExp_dev#1:while:mul.mut
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/COMP_LOOP-2:mul.itm REGISTER_NAME COMP_LOOP-1:modExp_dev#1:while:mul.mut
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/modExp_dev#1:result#1.sva REGISTER_NAME COMP_LOOP-1:modExp_dev#1:while:mul.mut
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/modExp_dev#1:result.sva REGISTER_NAME COMP_LOOP-1:modExp_dev#1:while:mul.mut
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/operator-<64,false>:acc.mut REGISTER_NAME COMP_LOOP-1:modExp_dev#1:while:mul.mut
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/tmp#2.lpi#4.dfm REGISTER_NAME tmp#2.lpi#4.dfm
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/tmp.lpi#4.dfm REGISTER_NAME tmp#2.lpi#4.dfm
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/modExp_dev:exp.sva REGISTER_NAME tmp#2.lpi#4.dfm
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/modExp_dev:exp#1.sva(63:9) REGISTER_NAME modExp_dev:exp#1.sva(63:9)
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/modExp_dev:exp#2.sva(63:9) REGISTER_NAME modExp_dev:exp#1.sva(63:9)
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/modExp_dev:exp#1.sva(0) REGISTER_NAME modExp_dev:exp#1.sva(0)
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/modExp_dev:exp#2.sva(0) REGISTER_NAME modExp_dev:exp#1.sva(0)
