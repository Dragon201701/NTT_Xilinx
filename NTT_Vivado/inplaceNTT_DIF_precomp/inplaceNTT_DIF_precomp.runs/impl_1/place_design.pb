
Q
Command: %s
53*	vivadotcl2 
place_design2default:defaultZ4-113h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xcvu13p2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xcvu13p2default:defaultZ17-349h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px? 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px? 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
place_design2default:defaultZ4-22h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px? 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px? 
U

Starting %s Task
103*constraints2
Placer2default:defaultZ18-103h px? 
}
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
22default:defaultZ30-611h px? 
v

Phase %s%s
101*constraints2
1 2default:default2)
Placer Initialization2default:defaultZ18-101h px? 
?

Phase %s%s
101*constraints2
1.1 2default:default29
%Placer Initialization Netlist Sorting2default:defaultZ18-101h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0392default:default2
2587.2732default:default2
0.0002default:defaultZ17-268h px? 
Z
EPhase 1.1 Placer Initialization Netlist Sorting | Checksum: 5b73cd2e
*commonh px? 
?

%s
*constraints2s
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.077 . Memory (MB): peak = 2587.273 ; gain = 0.0002default:defaulth px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0472default:default2
2587.2732default:default2
0.0002default:defaultZ17-268h px? 
?

Phase %s%s
101*constraints2
1.2 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px? 
?
?IO Placement failed due to overutilization. This design contains %s I/O ports
 while the target %s, contains only %s available user I/O. The target device has %s usable I/O pins of which %s are already occupied by user-locked I/Os.
 To rectify this issue:
 1. Ensure you are targeting the correct device and package.  Select a larger device or different package if necessary.
 2. Check the top-level ports of the design to ensure the correct number of ports are specified.
 3. Consider design changes to reduce the number of I/Os necessary.
415*place2
17962default:default26
" device: xcvu13p package: fhga21042default:default2
10942default:default2
10942default:default2
02default:defaultZ30-415h px? 
?
?%s: no pin(s)/port(s)/net(s) specified as objects, only virtual clock '%s' will be created. If you don't want this, please specify pin(s)/ports(s)/net(s) as objects to the command.
483*constraints2 
create_clock2default:default2"
virtual_io_clk2default:default2?
?D:/NTT_Xilinx/NTT_Vivado/inplaceNTT_DIF_precomp/inplaceNTT_DIF_precomp.srcs/constrs_1/imports/vivado_concat_v/concat_rtl.v.xv.sdc2default:default2
72default:default8@Z18-483h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
?
Instance %s (%s) is not placed
68*place2(
clk_IBUF_BUFG_inst2default:default2
BUFGCE2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place21
clk_IBUF_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2.
clk_IBUF_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2:
$p_rsc_dat_IBUF[0]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place27
!p_rsc_dat_IBUF[0]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[10]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[10]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[11]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[11]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[12]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[12]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[13]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[13]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[14]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[14]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[15]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[15]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[16]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[16]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[17]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[17]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[18]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[18]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[19]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[19]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2:
$p_rsc_dat_IBUF[1]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place27
!p_rsc_dat_IBUF[1]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[20]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[20]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[21]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[21]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[22]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[22]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[23]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[23]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[24]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[24]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[25]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[25]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[26]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[26]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[27]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[27]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[28]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[28]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[29]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[29]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2:
$p_rsc_dat_IBUF[2]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place27
!p_rsc_dat_IBUF[2]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[30]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[30]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[31]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[31]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[32]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[32]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[33]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[33]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[34]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[34]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[35]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[35]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[36]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[36]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[37]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[37]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[38]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[38]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[39]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[39]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2:
$p_rsc_dat_IBUF[3]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place27
!p_rsc_dat_IBUF[3]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[40]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[40]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[41]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[41]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[42]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[42]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[43]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[43]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[44]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[44]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[45]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[45]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[46]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[46]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[47]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[47]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[48]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[48]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[49]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[49]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2:
$p_rsc_dat_IBUF[4]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place27
!p_rsc_dat_IBUF[4]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[50]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[50]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[51]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[51]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[52]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place28
"p_rsc_dat_IBUF[52]_inst/INBUF_INST2default:default2
INBUF2default:default8Z30-68h px? 
?
Instance %s (%s) is not placed
68*place2;
%p_rsc_dat_IBUF[53]_inst/IBUFCTRL_INST2default:default2
IBUFCTRL2default:default8Z30-68h px? 
?
?Message '%s' appears more than %s times and has been disabled. User can change this message limit to see more message instances.
14*common2
Place 30-682default:default2
1002default:defaultZ17-14h px? 
g
RPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: 8dce8419
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:03:02 ; elapsed = 00:03:00 . Memory (MB): peak = 4247.973 ; gain = 1660.6992default:defaulth px? 
H
3Phase 1 Placer Initialization | Checksum: 8dce8419
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:03:02 ; elapsed = 00:03:00 . Memory (MB): peak = 4247.973 ; gain = 1660.6992default:defaulth px? 
?
?Placer failed with error: '%s'
Please review all ERROR and WARNING messages during placement to understand the cause for failure.
1*	placeflow2*
IO Clock Placer failed2default:defaultZ30-99h px? 
=
(Ending Placer Task | Checksum: 8dce8419
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:03:02 ; elapsed = 00:03:00 . Memory (MB): peak = 4247.973 ; gain = 1660.6992default:defaulth px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
462default:default2
02default:default2
02default:default2
1032default:defaultZ4-41h px? 
N

%s failed
30*	vivadotcl2 
place_design2default:defaultZ4-43h px? 
m
Command failed: %s
69*common28
$Placer could not place all instances2default:defaultZ17-69h px? 
?
Exiting %s at %s...
206*common2
Vivado2default:default2,
Thu Aug 12 10:39:46 20212default:defaultZ17-206h px? 


End Record