
O
Command: %s
53*	vivadotcl2

opt_design2default:defaultZ4-113h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
	xc7vx690t2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
	xc7vx690t2default:defaultZ17-349h px? 
?
?The version limit for your license is '%s' and has expired for new software. A version limit expiration means that, although you may be able to continue to use the current version of tools or IP with this license, you will not be eligible for any updates or new releases.
719*common2
2021.082default:defaultZ17-1540h px? 
n
,Running DRC as a precondition to command %s
22*	vivadotcl2

opt_design2default:defaultZ4-22h px? 
R

Starting %s Task
103*constraints2
DRC2default:defaultZ18-103h px? 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px? 
U
DRC finished with %s
272*project2
0 Errors2default:defaultZ1-461h px? 
d
BPlease refer to the DRC report (report_drc) for more information.
274*projectZ1-462h px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:02 ; elapsed = 00:00:03 . Memory (MB): peak = 2164.926 ; gain = 109.660 ; free physical = 135537 ; free virtual = 5059352default:defaulth px? 
g

Starting %s Task
103*constraints2,
Cache Timing Information2default:defaultZ18-103h px? 
?
?%s: no pin(s)/port(s)/net(s) specified as objects, only virtual clock '%s' will be created. If you don't want this, please specify pin(s)/ports(s)/net(s) as objects to the command.
483*constraints2 
create_clock2default:default2"
virtual_io_clk2default:default2?
v/home/ls5382/project/forPython/pythonSelfUseCtype/ntt_flat/Catapult_1/ntt_flat.v11/vivado_concat_v/concat_rtl.v.xv.sdc2default:default2
72default:default8@Z18-483h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
P
;Ending Cache Timing Information Task | Checksum: 167386609
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:16 ; elapsed = 00:00:16 . Memory (MB): peak = 2776.512 ; gain = 611.586 ; free physical = 135271 ; free virtual = 5056692default:defaulth px? 
a

Starting %s Task
103*constraints2&
Logic Optimization2default:defaultZ18-103h px? 
i

Phase %s%s
101*constraints2
1 2default:default2
Retarget2default:defaultZ18-101h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px? 
K
Retargeted %s cell(s).
49*opt2
02default:defaultZ31-49h px? 
;
&Phase 1 Retarget | Checksum: b7c0d91d
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00.44 ; elapsed = 00:00:00.29 . Memory (MB): peak = 2890.480 ; gain = 0.004 ; free physical = 135153 ; free virtual = 5055512default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2
Retarget2default:default2
02default:default2
72default:defaultZ31-389h px? 
u

Phase %s%s
101*constraints2
2 2default:default2(
Constant propagation2default:defaultZ18-101h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px? 
G
2Phase 2 Constant propagation | Checksum: c56548c7
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00.49 ; elapsed = 00:00:00.34 . Memory (MB): peak = 2890.480 ; gain = 0.004 ; free physical = 135153 ; free virtual = 5055512default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2(
Constant propagation2default:default2
02default:default2
02default:defaultZ31-389h px? 
f

Phase %s%s
101*constraints2
3 2default:default2
Sweep2default:defaultZ18-101h px? 
8
#Phase 3 Sweep | Checksum: 9af1ca4b
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00.68 ; elapsed = 00:00:00.53 . Memory (MB): peak = 2890.480 ; gain = 0.004 ; free physical = 135152 ; free virtual = 5055502default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2
Sweep2default:default2
182default:default2
02default:defaultZ31-389h px? 
r

Phase %s%s
101*constraints2
4 2default:default2%
BUFG optimization2default:defaultZ18-101h px? 
D
/Phase 4 BUFG optimization | Checksum: 9af1ca4b
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00.78 ; elapsed = 00:00:00.63 . Memory (MB): peak = 2890.480 ; gain = 0.004 ; free physical = 135154 ; free virtual = 5055512default:defaulth px? 
?
EPhase %s created %s cells of which %s are BUFGs and removed %s cells.395*opt2%
BUFG optimization2default:default2
02default:default2
02default:default2
02default:defaultZ31-662h px? 
|

Phase %s%s
101*constraints2
5 2default:default2/
Shift Register Optimization2default:defaultZ18-101h px? 
?
dSRL Remap converted %s SRLs to %s registers and converted %s registers of register chains to %s SRLs546*opt2
02default:default2
02default:default2
02default:default2
02default:defaultZ31-1064h px? 
N
9Phase 5 Shift Register Optimization | Checksum: 9af1ca4b
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00.83 ; elapsed = 00:00:00.68 . Memory (MB): peak = 2890.480 ; gain = 0.004 ; free physical = 135154 ; free virtual = 5055512default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2/
Shift Register Optimization2default:default2
02default:default2
02default:defaultZ31-389h px? 
x

Phase %s%s
101*constraints2
6 2default:default2+
Post Processing Netlist2default:defaultZ18-101h px? 
K
6Phase 6 Post Processing Netlist | Checksum: 1256a334d
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00.86 ; elapsed = 00:00:00.71 . Memory (MB): peak = 2890.480 ; gain = 0.004 ; free physical = 135154 ; free virtual = 5055512default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2+
Post Processing Netlist2default:default2
02default:default2
02default:defaultZ31-389h px? 
/
Opt_design Change Summary
*commonh px? 
/
=========================
*commonh px? 


*commonh px? 


*commonh px? 
?
z-------------------------------------------------------------------------------------------------------------------------
*commonh px? 
?
?|  Phase                        |  #Cells created  |  #Cells Removed  |  #Constrained objects preventing optimizations  |
-------------------------------------------------------------------------------------------------------------------------
*commonh px? 
?
?|  Retarget                     |               0  |               7  |                                              0  |
|  Constant propagation         |               0  |               0  |                                              0  |
|  Sweep                        |              18  |               0  |                                              0  |
|  BUFG optimization            |               0  |               0  |                                              0  |
|  Shift Register Optimization  |               0  |               0  |                                              0  |
|  Post Processing Netlist      |               0  |               0  |                                              0  |
-------------------------------------------------------------------------------------------------------------------------
*commonh px? 


*commonh px? 


*commonh px? 
a

Starting %s Task
103*constraints2&
Connectivity Check2default:defaultZ18-103h px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.01 . Memory (MB): peak = 2890.480 ; gain = 0.000 ; free physical = 135153 ; free virtual = 5055512default:defaulth px? 
J
5Ending Logic Optimization Task | Checksum: 190b08822
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00.99 ; elapsed = 00:00:00.82 . Memory (MB): peak = 2890.480 ; gain = 0.004 ; free physical = 135153 ; free virtual = 5055512default:defaulth px? 
a

Starting %s Task
103*constraints2&
Power Optimization2default:defaultZ18-103h px? 
s
7Will skip clock gating for clocks with period < %s ns.
114*pwropt2
2.002default:defaultZ34-132h px? 
J
5Ending Power Optimization Task | Checksum: 190b08822
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00.02 ; elapsed = 00:00:00.04 . Memory (MB): peak = 2890.480 ; gain = 0.000 ; free physical = 135152 ; free virtual = 5055502default:defaulth px? 
\

Starting %s Task
103*constraints2!
Final Cleanup2default:defaultZ18-103h px? 
E
0Ending Final Cleanup Task | Checksum: 190b08822
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00 ; elapsed = 00:00:00 . Memory (MB): peak = 2890.480 ; gain = 0.000 ; free physical = 135152 ; free virtual = 5055502default:defaulth px? 
b

Starting %s Task
103*constraints2'
Netlist Obfuscation2default:defaultZ18-103h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2890.4802default:default2
0.0002default:default2
1351522default:default2
5055502default:defaultZ17-722h px? 
K
6Ending Netlist Obfuscation Task | Checksum: 190b08822
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00 ; elapsed = 00:00:00 . Memory (MB): peak = 2890.480 ; gain = 0.000 ; free physical = 135152 ; free virtual = 5055502default:defaulth px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
272default:default2
02default:default2
02default:default2
02default:defaultZ4-41h px? 
\
%s completed successfully
29*	vivadotcl2

opt_design2default:defaultZ4-42h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2 
opt_design: 2default:default2
00:00:212default:default2
00:00:232default:default2
2890.4802default:default2
843.2152default:default2
1351522default:default2
5055502default:defaultZ17-722h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2890.4802default:default2
0.0002default:default2
1351522default:default2
5055502default:defaultZ17-722h px? 
H
&Writing timing data to binary archive.266*timingZ38-480h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2?
|/home/ls5382/project/forPython/pythonSelfUseCtype/ntt_flat/vivado/project_4096_2/project_4096_2.runs/impl_1/ntt_flat_opt.dcp2default:defaultZ17-1381h px? 
?
%s4*runtcl2~
jExecuting : report_drc -file ntt_flat_drc_opted.rpt -pb ntt_flat_drc_opted.pb -rpx ntt_flat_drc_opted.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2q
]report_drc -file ntt_flat_drc_opted.rpt -pb ntt_flat_drc_opted.pb -rpx ntt_flat_drc_opted.rpx2default:defaultZ4-113h px? 
>
Refreshing IP repositories
234*coregenZ19-234h px? 
G
"No user IP repositories specified
1154*coregenZ19-1704h px? 
?
"Loaded Vivado IP repository '%s'.
1332*coregen29
%/opt/Xilinx2019/Vivado/2019.1/data/ip2default:defaultZ19-2313h px? 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px? 
?
#The results of DRC are in file %s.
168*coretcl2?
?/home/ls5382/project/forPython/pythonSelfUseCtype/ntt_flat/vivado/project_4096_2/project_4096_2.runs/impl_1/ntt_flat_drc_opted.rpt?/home/ls5382/project/forPython/pythonSelfUseCtype/ntt_flat/vivado/project_4096_2/project_4096_2.runs/impl_1/ntt_flat_drc_opted.rpt2default:default8Z2-168h px? 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2 
report_drc: 2default:default2
00:00:072default:default2
00:00:062default:default2
3009.1092default:default2
86.6092default:default2
1351352default:default2
5055332default:defaultZ17-722h px? 


End Record