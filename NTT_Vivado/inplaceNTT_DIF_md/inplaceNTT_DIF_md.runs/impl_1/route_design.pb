
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
-Phase 1 Build RT Design | Checksum: 86297052
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:04:04 ; elapsed = 00:02:50 . Memory (MB): peak = 5199.715 ; gain = 705.5162default:defaulth px? 
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
-Phase 2.1 Create Timer | Checksum: 1541e19cb
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:04:04 ; elapsed = 00:02:50 . Memory (MB): peak = 5199.715 ; gain = 705.5162default:defaulth px? 
{

Phase %s%s
101*constraints2
2.2 2default:default2,
Fix Topology Constraints2default:defaultZ18-101h px? 
N
9Phase 2.2 Fix Topology Constraints | Checksum: 1541e19cb
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:04:04 ; elapsed = 00:02:50 . Memory (MB): peak = 5199.715 ; gain = 705.5162default:defaulth px? 
t

Phase %s%s
101*constraints2
2.3 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px? 
G
2Phase 2.3 Pre Route Cleanup | Checksum: 1541e19cb
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:04:04 ; elapsed = 00:02:50 . Memory (MB): peak = 5199.715 ; gain = 705.5162default:defaulth px? 
{

Phase %s%s
101*constraints2
2.4 2default:default2,
Global Clock Net Routing2default:defaultZ18-101h px? 
M
8Phase 2.4 Global Clock Net Routing | Checksum: bec25427
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:04:12 ; elapsed = 00:02:58 . Memory (MB): peak = 5687.969 ; gain = 1193.7702default:defaulth px? 
p

Phase %s%s
101*constraints2
2.5 2default:default2!
Update Timing2default:defaultZ18-101h px? 
C
.Phase 2.5 Update Timing | Checksum: 1bb9bf39a
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:04:24 ; elapsed = 00:03:05 . Memory (MB): peak = 5687.969 ; gain = 1193.7702default:defaulth px? 
?
Intermediate Timing Summary %s164*route2L
8| WNS=-4.271 | TNS=-237.610| WHS=-0.914 | THS=-347.096|
2default:defaultZ35-416h px? 
I
4Phase 2 Router Initialization | Checksum: 1af493c8b
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:04:24 ; elapsed = 00:03:06 . Memory (MB): peak = 5687.969 ; gain = 1193.7702default:defaulth px? 
p

Phase %s%s
101*constraints2
3 2default:default2#
Initial Routing2default:defaultZ18-101h px? 
C
.Phase 3 Initial Routing | Checksum: 222b0e733
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:04:45 ; elapsed = 00:03:20 . Memory (MB): peak = 5709.949 ; gain = 1215.7502default:defaulth px? 
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
Intermediate Timing Summary %s164*route2K
7| WNS=-4.754 | TNS=-293.138| WHS=-0.130 | THS=-0.594 |
2default:defaultZ35-416h px? 
H
3Phase 4.1 Global Iteration 0 | Checksum: 1b1cf572c
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:04:51 ; elapsed = 00:03:25 . Memory (MB): peak = 5709.949 ; gain = 1215.7502default:defaulth px? 
u

Phase %s%s
101*constraints2
4.2 2default:default2&
Global Iteration 12default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2K
7| WNS=-4.296 | TNS=-287.647| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
H
3Phase 4.2 Global Iteration 1 | Checksum: 10c1b82f8
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:04:56 ; elapsed = 00:03:30 . Memory (MB): peak = 5709.949 ; gain = 1215.7502default:defaulth px? 
u

Phase %s%s
101*constraints2
4.3 2default:default2&
Global Iteration 22default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2K
7| WNS=-4.397 | TNS=-278.937| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
H
3Phase 4.3 Global Iteration 2 | Checksum: 16c1a2755
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:04:57 ; elapsed = 00:03:31 . Memory (MB): peak = 5709.949 ; gain = 1215.7502default:defaulth px? 
F
1Phase 4 Rip-up And Reroute | Checksum: 16c1a2755
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:04:57 ; elapsed = 00:03:31 . Memory (MB): peak = 5709.949 ; gain = 1215.7502default:defaulth px? 
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
0Phase 5.1.1 Update Timing | Checksum: 24c598f06
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:04:58 ; elapsed = 00:03:31 . Memory (MB): peak = 5709.949 ; gain = 1215.7502default:defaulth px? 
?
Intermediate Timing Summary %s164*route2K
7| WNS=-4.295 | TNS=-287.568| WHS=0.011  | THS=0.000  |
2default:defaultZ35-416h px? 
C
.Phase 5.1 Delay CleanUp | Checksum: 23bf28db1
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:05:13 ; elapsed = 00:03:40 . Memory (MB): peak = 5709.949 ; gain = 1215.7502default:defaulth px? 
z

Phase %s%s
101*constraints2
5.2 2default:default2+
Clock Skew Optimization2default:defaultZ18-101h px? 
M
8Phase 5.2 Clock Skew Optimization | Checksum: 23bf28db1
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:05:13 ; elapsed = 00:03:40 . Memory (MB): peak = 5709.949 ; gain = 1215.7502default:defaulth px? 
O
:Phase 5 Delay and Skew Optimization | Checksum: 23bf28db1
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:05:13 ; elapsed = 00:03:40 . Memory (MB): peak = 5709.949 ; gain = 1215.7502default:defaulth px? 
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
0Phase 6.1.1 Update Timing | Checksum: 1f5ed49a3
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:05:13 ; elapsed = 00:03:40 . Memory (MB): peak = 5709.949 ; gain = 1215.7502default:defaulth px? 
?
Intermediate Timing Summary %s164*route2K
7| WNS=-4.424 | TNS=-253.867| WHS=0.011  | THS=0.000  |
2default:defaultZ35-416h px? 
C
.Phase 6.1 Hold Fix Iter | Checksum: 1f5ed49a3
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:05:13 ; elapsed = 00:03:40 . Memory (MB): peak = 5709.949 ; gain = 1215.7502default:defaulth px? 
A
,Phase 6 Post Hold Fix | Checksum: 1f5ed49a3
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:05:13 ; elapsed = 00:03:40 . Memory (MB): peak = 5709.949 ; gain = 1215.7502default:defaulth px? 
o

Phase %s%s
101*constraints2
7 2default:default2"
Route finalize2default:defaultZ18-101h px? 
B
-Phase 7 Route finalize | Checksum: 2289385e8
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:05:16 ; elapsed = 00:03:42 . Memory (MB): peak = 5709.949 ; gain = 1215.7502default:defaulth px? 
v

Phase %s%s
101*constraints2
8 2default:default2)
Verifying routed nets2default:defaultZ18-101h px? 
I
4Phase 8 Verifying routed nets | Checksum: 2289385e8
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:05:16 ; elapsed = 00:03:42 . Memory (MB): peak = 5709.949 ; gain = 1215.7502default:defaulth px? 
r

Phase %s%s
101*constraints2
9 2default:default2%
Depositing Routes2default:defaultZ18-101h px? 
E
0Phase 9 Depositing Routes | Checksum: 2289385e8
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:05:17 ; elapsed = 00:03:42 . Memory (MB): peak = 5709.949 ; gain = 1215.7502default:defaulth px? 
t

Phase %s%s
101*constraints2
10 2default:default2&
Post Router Timing2default:defaultZ18-101h px? 
?
Estimated Timing Summary %s
57*route2K
7| WNS=-4.424 | TNS=-253.867| WHS=0.011  | THS=0.000  |
2default:defaultZ35-57h px? 
B
!Router estimated timing not met.
128*routeZ35-328h px? 
G
2Phase 10 Post Router Timing | Checksum: 2289385e8
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:05:17 ; elapsed = 00:03:42 . Memory (MB): peak = 5709.949 ; gain = 1215.7502default:defaulth px? 
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
 2default:default2
-4.4242default:default2
-253.3022default:default2
0.0122default:default2
0.0002default:defaultZ32-668h px? 
X
CPhase 11.1 Physical Synthesis Initialization | Checksum: 2289385e8
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:05:58 ; elapsed = 00:04:19 . Memory (MB): peak = 6810.691 ; gain = 2316.4922default:defaulth px? 
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
 2default:default2
-4.4242default:default2
-253.3022default:default2
0.0122default:default2
0.0002default:defaultZ32-668h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-4.2802default:default2
clk2default:default2?
@inPlaceNTT_DIF_precomp_core_inst/nl_twiddle_rsci_radr_d_pff/P[5]@inPlaceNTT_DIF_precomp_core_inst/nl_twiddle_rsci_radr_d_pff/P[5]2default:default8Z32-952h px? 
?
AImproved path group WNS = %s. Path group: %s. Processed net: %s.
524*physynth2
-4.2592default:default2
clk2default:default2?
@inPlaceNTT_DIF_precomp_core_inst/nl_twiddle_rsci_radr_d_pff/P[1]@inPlaceNTT_DIF_precomp_core_inst/nl_twiddle_rsci_radr_d_pff/P[1]2default:default8Z32-952h px? 
?
CPath group WNS did not improve. Path group: %s. Processed net: %s.
525*physynth2
clk2default:default2?
@inPlaceNTT_DIF_precomp_core_inst/nl_twiddle_rsci_radr_d_pff/P[1]@inPlaceNTT_DIF_precomp_core_inst/nl_twiddle_rsci_radr_d_pff/P[1]2default:default8Z32-953h px? 
?
CPath group WNS did not improve. Path group: %s. Processed net: %s.
525*physynth2
clk2default:default2?
8inPlaceNTT_DIF_precomp_core_inst/STAGE_LOOP_i_3_0_sva[3]8inPlaceNTT_DIF_precomp_core_inst/STAGE_LOOP_i_3_0_sva[3]2default:default8Z32-953h px? 
?
:%s %s Timing Summary | WNS=%s | TNS=%s | WHS=%s | THS=%s |342*physynth2
Current2default:default2
 2default:default2
-4.2592default:default2
-253.0072default:default2
0.0122default:default2
0.0002default:defaultZ32-668h px? 
Q
<Phase 11.2 Critical Path Optimization | Checksum: 1a505dcaa
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:06:02 ; elapsed = 00:04:23 . Memory (MB): peak = 6888.273 ; gain = 2394.0742default:defaulth px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
6888.2732default:default2
0.0002default:defaultZ17-268h px? 
?
OPost Physical Optimization Timing Summary | WNS=%s | TNS=%s | WHS=%s | THS=%s |343*physynth2
-4.2592default:default2
-253.0072default:default2
0.0122default:default2
0.0002default:defaultZ32-669h px? 
Q
<Phase 11 Physical Synthesis in Router | Checksum: 1a505dcaa
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:06:03 ; elapsed = 00:04:25 . Memory (MB): peak = 6888.273 ; gain = 2394.0742default:defaulth px? 
@
Router Completed Successfully
2*	routeflowZ35-16h px? 
?

%s
*constraints2r
^Time (s): cpu = 00:06:03 ; elapsed = 00:04:25 . Memory (MB): peak = 6888.273 ; gain = 2394.0742default:defaulth px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
912default:default2
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
00:06:072default:default2
00:04:272default:default2
6888.2732default:default2
2394.0742default:defaultZ17-268h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0012default:default2
6888.2732default:default2
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
00:00:012default:default2 
00:00:00.2302default:default2
6888.2732default:default2
0.0002default:defaultZ17-268h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2~
jD:/NTT_Xilinx/NTT_Vivado/inplaceNTT_DIF_md/inplaceNTT_DIF_md.runs/impl_1/inPlaceNTT_DIF_precomp_routed.dcp2default:defaultZ17-1381h px? 
?
%s4*runtcl2?
?Executing : report_drc -file inPlaceNTT_DIF_precomp_drc_routed.rpt -pb inPlaceNTT_DIF_precomp_drc_routed.pb -rpx inPlaceNTT_DIF_precomp_drc_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
?report_drc -file inPlaceNTT_DIF_precomp_drc_routed.rpt -pb inPlaceNTT_DIF_precomp_drc_routed.pb -rpx inPlaceNTT_DIF_precomp_drc_routed.rpx2default:defaultZ4-113h px? 
>
IP Catalog is up to date.1232*coregenZ19-1839h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
?
#The results of DRC are in file %s.
168*coretcl2?
nD:/NTT_Xilinx/NTT_Vivado/inplaceNTT_DIF_md/inplaceNTT_DIF_md.runs/impl_1/inPlaceNTT_DIF_precomp_drc_routed.rptnD:/NTT_Xilinx/NTT_Vivado/inplaceNTT_DIF_md/inplaceNTT_DIF_md.runs/impl_1/inPlaceNTT_DIF_precomp_drc_routed.rpt2default:default8Z2-168h px? 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px? 
?
%s4*runtcl2?
?Executing : report_methodology -file inPlaceNTT_DIF_precomp_methodology_drc_routed.rpt -pb inPlaceNTT_DIF_precomp_methodology_drc_routed.pb -rpx inPlaceNTT_DIF_precomp_methodology_drc_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
?report_methodology -file inPlaceNTT_DIF_precomp_methodology_drc_routed.rpt -pb inPlaceNTT_DIF_precomp_methodology_drc_routed.pb -rpx inPlaceNTT_DIF_precomp_methodology_drc_routed.rpx2default:defaultZ4-113h px? 
?
?%s: no pin(s)/port(s)/net(s) specified as objects, only virtual clock '%s' will be created. If you don't want this, please specify pin(s)/ports(s)/net(s) as objects to the command.
483*constraints2 
create_clock2default:default2"
virtual_io_clk2default:default2?
wD:/NTT_Xilinx/NTT_Vivado/inplaceNTT_DIF_md/inplaceNTT_DIF_md.srcs/constrs_1/imports/vivado_concat_v/concat_rtl.v.xv.sdc2default:default2
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
450*coretcl2?
zD:/NTT_Xilinx/NTT_Vivado/inplaceNTT_DIF_md/inplaceNTT_DIF_md.runs/impl_1/inPlaceNTT_DIF_precomp_methodology_drc_routed.rptzD:/NTT_Xilinx/NTT_Vivado/inplaceNTT_DIF_md/inplaceNTT_DIF_md.runs/impl_1/inPlaceNTT_DIF_precomp_methodology_drc_routed.rpt2default:default8Z2-1520h px? 
d
%s completed successfully
29*	vivadotcl2&
report_methodology2default:defaultZ4-42h px? 
?
%s4*runtcl2?
?Executing : report_power -file inPlaceNTT_DIF_precomp_power_routed.rpt -pb inPlaceNTT_DIF_precomp_power_summary_routed.pb -rpx inPlaceNTT_DIF_precomp_power_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
?report_power -file inPlaceNTT_DIF_precomp_power_routed.rpt -pb inPlaceNTT_DIF_precomp_power_summary_routed.pb -rpx inPlaceNTT_DIF_precomp_power_routed.rpx2default:defaultZ4-113h px? 
?
?%s: no pin(s)/port(s)/net(s) specified as objects, only virtual clock '%s' will be created. If you don't want this, please specify pin(s)/ports(s)/net(s) as objects to the command.
483*constraints2 
create_clock2default:default2"
virtual_io_clk2default:default2?
wD:/NTT_Xilinx/NTT_Vivado/inplaceNTT_DIF_md/inplaceNTT_DIF_md.srcs/constrs_1/imports/vivado_concat_v/concat_rtl.v.xv.sdc2default:default2
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
1052default:default2
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
00:00:422default:default2
00:00:392default:default2
6888.2732default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
yExecuting : report_route_status -file inPlaceNTT_DIF_precomp_route_status.rpt -pb inPlaceNTT_DIF_precomp_route_status.pb
2default:defaulth px? 
?
%s4*runtcl2?
?Executing : report_timing_summary -max_paths 10 -file inPlaceNTT_DIF_precomp_timing_summary_routed.rpt -pb inPlaceNTT_DIF_precomp_timing_summary_routed.pb -rpx inPlaceNTT_DIF_precomp_timing_summary_routed.rpx -warn_on_violation 
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
%s4*runtcl2s
_Executing : report_incremental_reuse -file inPlaceNTT_DIF_precomp_incremental_reuse_routed.rpt
2default:defaulth px? 
g
BIncremental flow is disabled. No incremental reuse Info to report.423*	vivadotclZ4-1062h px? 
?
%s4*runtcl2s
_Executing : report_clock_utilization -file inPlaceNTT_DIF_precomp_clock_utilization_routed.rpt
2default:defaulth px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
report_clock_utilization: 2default:default2
00:00:162default:default2
00:00:162default:default2
6888.2732default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
?Executing : report_bus_skew -warn_on_violation -file inPlaceNTT_DIF_precomp_bus_skew_routed.rpt -pb inPlaceNTT_DIF_precomp_bus_skew_routed.pb -rpx inPlaceNTT_DIF_precomp_bus_skew_routed.rpx
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