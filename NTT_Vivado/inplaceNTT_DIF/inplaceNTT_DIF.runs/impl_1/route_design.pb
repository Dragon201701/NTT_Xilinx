
Q
Command: %s
53*	vivadotcl2 
route_design2default:defaultZ4-113h px? 
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
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
route_design2default:defaultZ4-22h px? 
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
V

Starting %s Task
103*constraints2
Routing2default:defaultZ18-103h px? 
}
BMultithreading enabled for route_design using a maximum of %s CPUs17*	routeflow2
22default:defaultZ35-254h px? 
p

Phase %s%s
101*constraints2
1 2default:default2#
Build RT Design2default:defaultZ18-101h px? 
B
-Phase 1 Build RT Design | Checksum: f3585dba
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:06:10 ; elapsed = 00:03:53 . Memory (MB): peak = 6079.090 ; gain = 357.4962default:defaulth px? 
v

Phase %s%s
101*constraints2
2 2default:default2)
Router Initialization2default:defaultZ18-101h px? 
o

Phase %s%s
101*constraints2
2.1 2default:default2 
Create Timer2default:defaultZ18-101h px? 
B
-Phase 2.1 Create Timer | Checksum: 17287a39f
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:06:13 ; elapsed = 00:03:56 . Memory (MB): peak = 6079.090 ; gain = 357.4962default:defaulth px? 
{

Phase %s%s
101*constraints2
2.2 2default:default2,
Fix Topology Constraints2default:defaultZ18-101h px? 
N
9Phase 2.2 Fix Topology Constraints | Checksum: 17287a39f
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:06:14 ; elapsed = 00:03:56 . Memory (MB): peak = 6079.090 ; gain = 357.4962default:defaulth px? 
t

Phase %s%s
101*constraints2
2.3 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px? 
G
2Phase 2.3 Pre Route Cleanup | Checksum: 17287a39f
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:06:14 ; elapsed = 00:03:57 . Memory (MB): peak = 6079.090 ; gain = 357.4962default:defaulth px? 
{

Phase %s%s
101*constraints2
2.4 2default:default2,
Global Clock Net Routing2default:defaultZ18-101h px? 
N
9Phase 2.4 Global Clock Net Routing | Checksum: 17c70863c
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:06:31 ; elapsed = 00:04:14 . Memory (MB): peak = 6544.375 ; gain = 822.7812default:defaulth px? 
p

Phase %s%s
101*constraints2
2.5 2default:default2!
Update Timing2default:defaultZ18-101h px? 
C
.Phase 2.5 Update Timing | Checksum: 24d9d2bdc
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:08:56 ; elapsed = 00:05:37 . Memory (MB): peak = 6544.375 ; gain = 822.7812default:defaulth px? 
?
Intermediate Timing Summary %s164*route2N
:| WNS=-56.986| TNS=-28328.480| WHS=-0.786 | THS=-132.958|
2default:defaultZ35-416h px? 
I
4Phase 2 Router Initialization | Checksum: 258e209f3
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:10:04 ; elapsed = 00:06:19 . Memory (MB): peak = 6544.375 ; gain = 822.7812default:defaulth px? 
p

Phase %s%s
101*constraints2
3 2default:default2#
Initial Routing2default:defaultZ18-101h px? 
C
.Phase 3 Initial Routing | Checksum: 1669cc3ca
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:13:27 ; elapsed = 00:08:17 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
=
Initial Estimated Congestion179*routeZ35-449h px? 
?
?Estimated Global/Short routing congestion is level %s (%sx%s). Congestion levels of 5 and greater can reduce routability and impact timing closure.178*route2
62default:default2
642default:default2
642default:defaultZ35-448h px? 
s

Phase %s%s
101*constraints2
4 2default:default2&
Rip-up And Reroute2default:defaultZ18-101h px? 
u

Phase %s%s
101*constraints2
4.1 2default:default2&
Global Iteration 02default:defaultZ18-101h px? 
?
?CLB routing congestion detected. Several CLBs have high routing utilization, which can impact timing closure. Top ten most congested CLBs are: %s180*route20
CLEM_X68Y316 CLEL_R_X68Y316 2default:defaultZ35-443h px? 
?
Intermediate Timing Summary %s164*route2M
9| WNS=-80.308| TNS=-40696.426| WHS=-0.059 | THS=-0.444 |
2default:defaultZ35-416h px? 
H
3Phase 4.1 Global Iteration 0 | Checksum: 16b27b58e
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:34:01 ; elapsed = 00:21:34 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
u

Phase %s%s
101*constraints2
4.2 2default:default2&
Global Iteration 12default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2M
9| WNS=-79.539| TNS=-40401.086| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
H
3Phase 4.2 Global Iteration 1 | Checksum: 16e27d6ad
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:36:13 ; elapsed = 00:23:35 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
u

Phase %s%s
101*constraints2
4.3 2default:default2&
Global Iteration 22default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2M
9| WNS=-77.559| TNS=-39671.004| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
H
3Phase 4.3 Global Iteration 2 | Checksum: 17a35d00c
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:39:36 ; elapsed = 00:26:40 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
u

Phase %s%s
101*constraints2
4.4 2default:default2&
Global Iteration 32default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2M
9| WNS=-76.553| TNS=-39279.438| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
H
3Phase 4.4 Global Iteration 3 | Checksum: 21360c98e
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:42:03 ; elapsed = 00:28:56 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
u

Phase %s%s
101*constraints2
4.5 2default:default2&
Global Iteration 42default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2M
9| WNS=-75.996| TNS=-39064.141| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
H
3Phase 4.5 Global Iteration 4 | Checksum: 19adcdca4
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:44:27 ; elapsed = 00:31:16 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
F
1Phase 4 Rip-up And Reroute | Checksum: 19adcdca4
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:44:27 ; elapsed = 00:31:17 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
|

Phase %s%s
101*constraints2
5 2default:default2/
Delay and Skew Optimization2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
5.1 2default:default2!
Delay CleanUp2default:defaultZ18-101h px? 
r

Phase %s%s
101*constraints2
5.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
E
0Phase 5.1.1 Update Timing | Checksum: 21c520107
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:45:16 ; elapsed = 00:31:47 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
?
Intermediate Timing Summary %s164*route2M
9| WNS=-75.996| TNS=-39064.141| WHS=0.010  | THS=0.000  |
2default:defaultZ35-416h px? 
C
.Phase 5.1 Delay CleanUp | Checksum: 1a54e5feb
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:45:21 ; elapsed = 00:31:51 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
z

Phase %s%s
101*constraints2
5.2 2default:default2+
Clock Skew Optimization2default:defaultZ18-101h px? 
M
8Phase 5.2 Clock Skew Optimization | Checksum: 1a54e5feb
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:45:21 ; elapsed = 00:31:51 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
O
:Phase 5 Delay and Skew Optimization | Checksum: 1a54e5feb
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:45:22 ; elapsed = 00:31:52 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
n

Phase %s%s
101*constraints2
6 2default:default2!
Post Hold Fix2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
6.1 2default:default2!
Hold Fix Iter2default:defaultZ18-101h px? 
r

Phase %s%s
101*constraints2
6.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
E
0Phase 6.1.1 Update Timing | Checksum: 20a7d4489
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:45:55 ; elapsed = 00:32:12 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
?
Intermediate Timing Summary %s164*route2M
9| WNS=-75.959| TNS=-39058.184| WHS=0.010  | THS=0.000  |
2default:defaultZ35-416h px? 
C
.Phase 6.1 Hold Fix Iter | Checksum: 1b3788520
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:45:55 ; elapsed = 00:32:12 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
A
,Phase 6 Post Hold Fix | Checksum: 1b3788520
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:45:56 ; elapsed = 00:32:13 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
o

Phase %s%s
101*constraints2
7 2default:default2"
Route finalize2default:defaultZ18-101h px? 
B
-Phase 7 Route finalize | Checksum: 161809494
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:46:01 ; elapsed = 00:32:16 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
v

Phase %s%s
101*constraints2
8 2default:default2)
Verifying routed nets2default:defaultZ18-101h px? 
I
4Phase 8 Verifying routed nets | Checksum: 161809494
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:46:01 ; elapsed = 00:32:16 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
r

Phase %s%s
101*constraints2
9 2default:default2%
Depositing Routes2default:defaultZ18-101h px? 
E
0Phase 9 Depositing Routes | Checksum: 161809494
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:46:25 ; elapsed = 00:32:47 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
t

Phase %s%s
101*constraints2
10 2default:default2&
Post Router Timing2default:defaultZ18-101h px? 
?
Estimated Timing Summary %s
57*route2M
9| WNS=-75.959| TNS=-39058.184| WHS=0.010  | THS=0.000  |
2default:defaultZ35-57h px? 
B
!Router estimated timing not met.
128*routeZ35-328h px? 
G
2Phase 10 Post Router Timing | Checksum: 161809494
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:46:26 ; elapsed = 00:32:48 . Memory (MB): peak = 6688.844 ; gain = 967.2502default:defaulth px? 
~

Phase %s%s
101*constraints2
11 2default:default20
Physical Synthesis in Router2default:defaultZ18-101h px? 
?

Phase %s%s
101*constraints2
11.1 2default:default25
!Physical Synthesis Initialization2default:defaultZ18-101h px? 
?
:%s %s Timing Summary | WNS=%s | TNS=%s | WHS=%s | THS=%s |342*physynth2
Current2default:default2
 2default:default2
-75.7142default:default2

-38910.7592default:default2
0.0112default:default2
0.0002default:defaultZ32-668h px? 
X
CPhase 11.1 Physical Synthesis Initialization | Checksum: 161809494
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:48:55 ; elapsed = 00:34:26 . Memory (MB): peak = 7993.629 ; gain = 2272.0352default:defaulth px? 
?
?WARNING: Physical Optimization has determined that the magnitude of the negative slack is too large and it is highly unlikely that slack will be improved. Post-Route Physical Optimization is most effective when WNS is above -0.5ns400*physynthZ32-745h px? 
~

Phase %s%s
101*constraints2
11.2 2default:default2.
Critical Path Optimization2default:defaultZ18-101h px? 
?
:%s %s Timing Summary | WNS=%s | TNS=%s | WHS=%s | THS=%s |342*physynth2
Current2default:default2
 2default:default2
-75.7142default:default2

-38910.7592default:default2
0.0112default:default2
0.0002default:defaultZ32-668h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6732default:default2
clk2default:default2?
minPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[49]_lopt_replica_1minPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[49]_lopt_replica_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6622default:default2
clk2default:default2?
minPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[49]_lopt_replica_1minPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[49]_lopt_replica_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6622default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[39]_lopt_replica_3_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[39]_lopt_replica_3_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6562default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[43]_lopt_replica_4_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[43]_lopt_replica_4_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6352default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[39]_lopt_replica_2_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[39]_lopt_replica_2_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6322default:default2
clk2default:default2?
minPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[58]_lopt_replica_1minPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[58]_lopt_replica_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6292default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[59]_lopt_replica_3_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[59]_lopt_replica_3_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6282default:default2
clk2default:default2?
minPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[49]_lopt_replica_1minPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[49]_lopt_replica_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6242default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[34]_lopt_replica_3_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[34]_lopt_replica_3_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6232default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[39]_lopt_replica_3_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[39]_lopt_replica_3_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6192default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[21]_lopt_replica_4_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[21]_lopt_replica_4_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6182default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[33]_lopt_replica_2_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[33]_lopt_replica_2_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6172default:default2
clk2default:default2?
minPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[34]_lopt_replica_1minPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[34]_lopt_replica_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6142default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[56]_lopt_replica_3_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[56]_lopt_replica_3_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6092default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[25]_lopt_replica_3_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[25]_lopt_replica_3_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6082default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[30]_lopt_replica_4_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[30]_lopt_replica_4_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6052default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[39]_lopt_replica_2_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[39]_lopt_replica_2_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6032default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[22]_lopt_replica_3_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[22]_lopt_replica_3_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6012default:default2
clk2default:default2?
minPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[52]_lopt_replica_1minPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[52]_lopt_replica_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.6002default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[41]_lopt_replica_4_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[41]_lopt_replica_4_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.5962default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[56]_lopt_replica_4_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[56]_lopt_replica_4_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.5932default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[51]_lopt_replica_4_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[51]_lopt_replica_4_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.5792default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[62]_lopt_replica_2_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[62]_lopt_replica_2_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.5722default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[34]_lopt_replica_4_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[34]_lopt_replica_4_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.5692default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[25]_lopt_replica_3_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[25]_lopt_replica_3_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.5662default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[39]_lopt_replica_3_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[39]_lopt_replica_3_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.5642default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[61]_lopt_replica_2_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[61]_lopt_replica_2_12default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.5622default:default2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[22]_lopt_replica_3_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[22]_lopt_replica_3_12default:default8Z32-952h px? 
?
CPath group WNS did not improve. Path group: %s. Processed net: %s.
525*physynth2
clk2default:default2?
oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[56]_lopt_replica_3_1oinPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/return_rsci_d_reg[56]_lopt_replica_3_12default:default8Z32-953h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-75.5542default:default2
clk2default:default2?
_inPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/rem_13_cmp_6_a_63_0[8]_inPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/rem_13_cmp_6_a_63_0[8]2default:default8Z32-952h px? 
?
CPath group WNS did not improve. Path group: %s. Processed net: %s.
525*physynth2
clk2default:default2?
_inPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/rem_13_cmp_6_a_63_0[8]_inPlaceNTT_DIF_core_inst/COMP_LOOP_1_modulo_dev_cmp/modulo_dev_core_inst/rem_13_cmp_6_a_63_0[8]2default:default8Z32-953h px? 
?
:%s %s Timing Summary | WNS=%s | TNS=%s | WHS=%s | THS=%s |342*physynth2
Current2default:default2
 2default:default2
-75.5542default:default2

-38882.7502default:default2
0.0112default:default2
0.0002default:defaultZ32-668h px? 
Q
<Phase 11.2 Critical Path Optimization | Checksum: 102d4d045
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:53:03 ; elapsed = 00:36:54 . Memory (MB): peak = 8110.230 ; gain = 2388.6372default:defaulth px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0412default:default2
8110.2302default:default2
0.0002default:defaultZ17-268h px? 
?
OPost Physical Optimization Timing Summary | WNS=%s | TNS=%s | WHS=%s | THS=%s |343*physynth2
-75.5542default:default2

-38882.7502default:default2
0.0112default:default2
0.0002default:defaultZ32-669h px? 
Q
<Phase 11 Physical Synthesis in Router | Checksum: 102d4d045
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:53:08 ; elapsed = 00:36:58 . Memory (MB): peak = 8110.230 ; gain = 2388.6372default:defaulth px? 
@
Router Completed Successfully
2*	routeflowZ35-16h px? 
?

%s
*constraints2r
^Time (s): cpu = 00:53:08 ; elapsed = 00:36:58 . Memory (MB): peak = 8110.230 ; gain = 2388.6372default:defaulth px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1202default:default2
22default:default2
02default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
route_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
route_design: 2default:default2
00:53:272default:default2
00:37:092default:default2
8110.2302default:default2
2388.6372default:defaultZ17-268h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0372default:default2
8110.2302default:default2
0.0002default:defaultZ17-268h px? 
H
&Writing timing data to binary archive.266*timingZ38-480h px? 
D
Writing placer database...
1603*designutilsZ20-1893h px? 
=
Writing XDEF routing.
211*designutilsZ20-211h px? 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px? 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:352default:default2
00:00:162default:default2
8110.2302default:default2
0.0002default:defaultZ17-268h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2p
\D:/NTT_Xilinx/NTT_Vivado/inplaceNTT_DIF/inplaceNTT_DIF.runs/impl_1/inPlaceNTT_DIF_routed.dcp2default:defaultZ17-1381h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2&
write_checkpoint: 2default:default2
00:00:442default:default2
00:00:262default:default2
8110.2302default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
Executing : report_drc -file inPlaceNTT_DIF_drc_routed.rpt -pb inPlaceNTT_DIF_drc_routed.pb -rpx inPlaceNTT_DIF_drc_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
rreport_drc -file inPlaceNTT_DIF_drc_routed.rpt -pb inPlaceNTT_DIF_drc_routed.pb -rpx inPlaceNTT_DIF_drc_routed.rpx2default:defaultZ4-113h px? 
>
IP Catalog is up to date.1232*coregenZ19-1839h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
?
#The results of DRC are in file %s.
168*coretcl2?
`D:/NTT_Xilinx/NTT_Vivado/inplaceNTT_DIF/inplaceNTT_DIF.runs/impl_1/inPlaceNTT_DIF_drc_routed.rpt`D:/NTT_Xilinx/NTT_Vivado/inplaceNTT_DIF/inplaceNTT_DIF.runs/impl_1/inPlaceNTT_DIF_drc_routed.rpt2default:default8Z2-168h px? 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
report_drc: 2default:default2
00:00:462default:default2
00:00:302default:default2
8110.2302default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
?Executing : report_methodology -file inPlaceNTT_DIF_methodology_drc_routed.rpt -pb inPlaceNTT_DIF_methodology_drc_routed.pb -rpx inPlaceNTT_DIF_methodology_drc_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
?report_methodology -file inPlaceNTT_DIF_methodology_drc_routed.rpt -pb inPlaceNTT_DIF_methodology_drc_routed.pb -rpx inPlaceNTT_DIF_methodology_drc_routed.rpx2default:defaultZ4-113h px? 
?
?%s: no pin(s)/port(s)/net(s) specified as objects, only virtual clock '%s' will be created. If you don't want this, please specify pin(s)/ports(s)/net(s) as objects to the command.
483*constraints2 
create_clock2default:default2"
virtual_io_clk2default:default2?
qD:/NTT_Xilinx/NTT_Vivado/inplaceNTT_DIF/inplaceNTT_DIF.srcs/constrs_1/imports/vivado_concat_v/concat_rtl.v.xv.sdc2default:default2
72default:default8@Z18-483h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
Y
$Running Methodology with %s threads
74*drc2
22default:defaultZ23-133h px? 
?
2The results of Report Methodology are in file %s.
450*coretcl2?
lD:/NTT_Xilinx/NTT_Vivado/inplaceNTT_DIF/inplaceNTT_DIF.runs/impl_1/inPlaceNTT_DIF_methodology_drc_routed.rptlD:/NTT_Xilinx/NTT_Vivado/inplaceNTT_DIF/inplaceNTT_DIF.runs/impl_1/inPlaceNTT_DIF_methodology_drc_routed.rpt2default:default8Z2-1520h px? 
d
%s completed successfully
29*	vivadotcl2&
report_methodology2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2(
report_methodology: 2default:default2
00:02:032default:default2
00:01:422default:default2
8110.2302default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
?Executing : report_power -file inPlaceNTT_DIF_power_routed.rpt -pb inPlaceNTT_DIF_power_summary_routed.pb -rpx inPlaceNTT_DIF_power_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
?report_power -file inPlaceNTT_DIF_power_routed.rpt -pb inPlaceNTT_DIF_power_summary_routed.pb -rpx inPlaceNTT_DIF_power_routed.rpx2default:defaultZ4-113h px? 
?
?%s: no pin(s)/port(s)/net(s) specified as objects, only virtual clock '%s' will be created. If you don't want this, please specify pin(s)/ports(s)/net(s) as objects to the command.
483*constraints2 
create_clock2default:default2"
virtual_io_clk2default:default2?
qD:/NTT_Xilinx/NTT_Vivado/inplaceNTT_DIF/inplaceNTT_DIF.srcs/constrs_1/imports/vivado_concat_v/concat_rtl.v.xv.sdc2default:default2
72default:default8@Z18-483h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px? 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1342default:default2
22default:default2
02default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
report_power2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
report_power: 2default:default2
00:02:132default:default2
00:01:302default:default2
8110.2302default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2}
iExecuting : report_route_status -file inPlaceNTT_DIF_route_status.rpt -pb inPlaceNTT_DIF_route_status.pb
2default:defaulth px? 
?
%s4*runtcl2?
?Executing : report_timing_summary -max_paths 10 -file inPlaceNTT_DIF_timing_summary_routed.rpt -pb inPlaceNTT_DIF_timing_summary_routed.pb -rpx inPlaceNTT_DIF_timing_summary_routed.rpx -warn_on_violation 
2default:defaulth px? 
?
UpdateTimingParams:%s.
91*timing2O
; Speed grade: -3, Temperature grade: E, Delay Type: min_max2default:defaultZ38-91h px? 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px? 
?
rThe design failed to meet the timing requirements. Please see the %s report for details on the timing violations.
188*timing2"
timing summary2default:defaultZ38-282h px? 
?
%s4*runtcl2k
WExecuting : report_incremental_reuse -file inPlaceNTT_DIF_incremental_reuse_routed.rpt
2default:defaulth px? 
g
BIncremental flow is disabled. No incremental reuse Info to report.423*	vivadotclZ4-1062h px? 
?
%s4*runtcl2k
WExecuting : report_clock_utilization -file inPlaceNTT_DIF_clock_utilization_routed.rpt
2default:defaulth px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
report_clock_utilization: 2default:default2
00:00:202default:default2
00:00:212default:default2
8110.2302default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
?Executing : report_bus_skew -warn_on_violation -file inPlaceNTT_DIF_bus_skew_routed.rpt -pb inPlaceNTT_DIF_bus_skew_routed.pb -rpx inPlaceNTT_DIF_bus_skew_routed.rpx
2default:defaulth px? 
?
UpdateTimingParams:%s.
91*timing2O
; Speed grade: -3, Temperature grade: E, Delay Type: min_max2default:defaultZ38-91h px? 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px? 


End Record