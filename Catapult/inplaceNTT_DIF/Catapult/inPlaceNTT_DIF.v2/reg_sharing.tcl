directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/STAGE_MAIN_LOOP:acc#1.psp.sva REGISTER_NAME STAGE_MAIN_LOOP:acc#1.psp.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/STAGE_MAIN_LOOP:i(3:0).sva REGISTER_NAME STAGE_MAIN_LOOP:acc#1.psp.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/COMP_LOOP:acc.cse.sva REGISTER_NAME COMP_LOOP:acc.cse.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/modExp_dev:exp#1.sva(8:0) REGISTER_NAME COMP_LOOP:acc.cse.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/exit:modExp_dev#1:while.sva REGISTER_NAME exit:modExp_dev#1:while.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/exit:modExp_dev:while.sva REGISTER_NAME exit:modExp_dev#1:while.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/exit:COMP_LOOP.sva REGISTER_NAME exit:modExp_dev#1:while.sva
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/modExp_dev#1:while:mul.mut REGISTER_NAME modExp_dev#1:while:mul.mut
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/modExp_dev:while:mul.mut REGISTER_NAME modExp_dev#1:while:mul.mut
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/modExp_dev#1:result.sva REGISTER_NAME modExp_dev#1:while:mul.mut
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/COMP_LOOP:mul.itm REGISTER_NAME COMP_LOOP:mul.itm
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/factor1.sva REGISTER_NAME COMP_LOOP:mul.itm
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/modExp_dev:exp.sva REGISTER_NAME COMP_LOOP:mul.itm
directive set /inPlaceNTT_DIF/inPlaceNTT_DIF:core/core/operator-<64,false>:acc.mut REGISTER_NAME COMP_LOOP:mul.itm
