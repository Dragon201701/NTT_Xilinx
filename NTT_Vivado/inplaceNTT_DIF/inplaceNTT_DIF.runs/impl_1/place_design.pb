
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
00:00:00.0332default:default2
2601.9842default:default2
0.0002default:defaultZ17-268h px? 
Z
EPhase 1.1 Placer Initialization Netlist Sorting | Checksum: 4b17e19c
*commonh px? 
?

%s
*constraints2s
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.066 . Memory (MB): peak = 2601.984 ; gain = 0.0002default:defaulth px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0392default:default2
2601.9842default:default2
0.0002default:defaultZ17-268h px? 
?

Phase %s%s
101*constraints2
1.2 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px? 
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
h
SPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: 116e30504
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:02:12 ; elapsed = 00:01:37 . Memory (MB): peak = 4396.305 ; gain = 1794.3202default:defaulth px? 
}

Phase %s%s
101*constraints2
1.3 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101h px? 
P
;Phase 1.3 Build Placer Netlist Model | Checksum: 163a77a8c
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:04:36 ; elapsed = 00:03:13 . Memory (MB): peak = 4755.309 ; gain = 2153.3242default:defaulth px? 
z

Phase %s%s
101*constraints2
1.4 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101h px? 
M
8Phase 1.4 Constrain Clocks/Macros | Checksum: 163a77a8c
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:04:36 ; elapsed = 00:03:13 . Memory (MB): peak = 4755.309 ; gain = 2153.3242default:defaulth px? 
I
4Phase 1 Placer Initialization | Checksum: 163a77a8c
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:04:37 ; elapsed = 00:03:14 . Memory (MB): peak = 4755.309 ; gain = 2153.3242default:defaulth px? 
q

Phase %s%s
101*constraints2
2 2default:default2$
Global Placement2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
2.1 2default:default2!
Floorplanning2default:defaultZ18-101h px? 
C
.Phase 2.1 Floorplanning | Checksum: 27c3d348c
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:07:12 ; elapsed = 00:05:11 . Memory (MB): peak = 4763.664 ; gain = 2161.6802default:defaulth px? 
x

Phase %s%s
101*constraints2
2.2 2default:default2)
Global Placement Core2default:defaultZ18-101h px? 
?

Phase %s%s
101*constraints2
2.2.1 2default:default20
Physical Synthesis In Placer2default:defaultZ18-101h px? 
K
)No high fanout nets found in the design.
65*physynthZ32-65h px? 
?
$Optimized %s %s. Created %s new %s.
216*physynth2
02default:default2
net2default:default2
02default:default2
instance2default:defaultZ32-232h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
j
FNo candidate cells for DSP register optimization found in the design.
274*physynthZ32-456h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
22default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
h
DNo candidate cells for SRL register optimization found in the design349*physynthZ32-677h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
i
ENo candidate cells for BRAM register optimization found in the design297*physynthZ32-526h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
R
.No candidate nets found for HD net replication521*physynthZ32-949h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0362default:default2
5721.5942default:default2
0.0002default:defaultZ17-268h px? 
B
-
Summary of Physical Synthesis Optimizations
*commonh px? 
B
-============================================
*commonh px? 


*commonh px? 


*commonh px? 
?
?----------------------------------------------------------------------------------------------------------------------------------------
*commonh px? 
?
?|  Optimization                  |  Added Cells  |  Removed Cells  |  Optimized Cells/Nets  |  Dont Touch  |  Iterations  |  Elapsed   |
----------------------------------------------------------------------------------------------------------------------------------------
*commonh px? 
?
?|  Very High Fanout              |            0  |              0  |                     0  |           0  |           1  |  00:00:01  |
|  DSP Register                  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Shift Register                |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  BRAM Register                 |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  HD Interface Net Replication  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Total                         |            0  |              0  |                     0  |           0  |           5  |  00:00:01  |
----------------------------------------------------------------------------------------------------------------------------------------
*commonh px? 


*commonh px? 


*commonh px? 
T
?Phase 2.2.1 Physical Synthesis In Placer | Checksum: 1f9db81e6
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:13:43 ; elapsed = 00:09:44 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
K
6Phase 2.2 Global Placement Core | Checksum: 11037eae3
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:14:11 ; elapsed = 00:10:05 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
D
/Phase 2 Global Placement | Checksum: 11037eae3
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:14:11 ; elapsed = 00:10:05 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
q

Phase %s%s
101*constraints2
3 2default:default2$
Detail Placement2default:defaultZ18-101h px? 
}

Phase %s%s
101*constraints2
3.1 2default:default2.
Commit Multi Column Macros2default:defaultZ18-101h px? 
P
;Phase 3.1 Commit Multi Column Macros | Checksum: 121cde87c
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:14:30 ; elapsed = 00:10:18 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 


Phase %s%s
101*constraints2
3.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101h px? 
R
=Phase 3.2 Commit Most Macros & LUTRAMs | Checksum: 1ca7b4b4f
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:16:41 ; elapsed = 00:12:11 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
y

Phase %s%s
101*constraints2
3.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101h px? 
L
7Phase 3.3 Area Swap Optimization | Checksum: 19b26196e
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:16:47 ; elapsed = 00:12:15 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
s

Phase %s%s
101*constraints2
3.4 2default:default2$
IO Cut Optimizer2default:defaultZ18-101h px? 
F
1Phase 3.4 IO Cut Optimizer | Checksum: 219212fe1
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:16:55 ; elapsed = 00:12:22 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
t

Phase %s%s
101*constraints2
3.5 2default:default2%
Fast Optimization2default:defaultZ18-101h px? 
G
2Phase 3.5 Fast Optimization | Checksum: 20a639b0a
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:18:26 ; elapsed = 00:13:29 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
y

Phase %s%s
101*constraints2
3.6 2default:default2*
Small Shape Clustering2default:defaultZ18-101h px? 
L
7Phase 3.6 Small Shape Clustering | Checksum: 17fb30dfa
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:18:42 ; elapsed = 00:13:42 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 


Phase %s%s
101*constraints2
3.7 2default:default20
Flow Legalize Slice Clusters2default:defaultZ18-101h px? 
R
=Phase 3.7 Flow Legalize Slice Clusters | Checksum: 184dcc21a
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:18:46 ; elapsed = 00:13:45 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
r

Phase %s%s
101*constraints2
3.8 2default:default2#
Slice Area Swap2default:defaultZ18-101h px? 
E
0Phase 3.8 Slice Area Swap | Checksum: 1ed9cd4c4
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:19:10 ; elapsed = 00:14:13 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
x

Phase %s%s
101*constraints2
3.9 2default:default2)
Commit Slice Clusters2default:defaultZ18-101h px? 
K
6Phase 3.9 Commit Slice Clusters | Checksum: 20cde0558
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:19:38 ; elapsed = 00:14:29 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
v

Phase %s%s
101*constraints2
3.10 2default:default2&
Re-assign LUT pins2default:defaultZ18-101h px? 
I
4Phase 3.10 Re-assign LUT pins | Checksum: 1bc881b39
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:20:10 ; elapsed = 00:15:09 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
?

Phase %s%s
101*constraints2
3.11 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px? 
U
@Phase 3.11 Pipeline Register Optimization | Checksum: 1f0739d33
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:20:12 ; elapsed = 00:15:11 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
u

Phase %s%s
101*constraints2
3.12 2default:default2%
Fast Optimization2default:defaultZ18-101h px? 
H
3Phase 3.12 Fast Optimization | Checksum: 23936a684
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:22:12 ; elapsed = 00:16:36 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
D
/Phase 3 Detail Placement | Checksum: 23936a684
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:22:13 ; elapsed = 00:16:37 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
?

Phase %s%s
101*constraints2
4 2default:default2<
(Post Placement Optimization and Clean-Up2default:defaultZ18-101h px? 
{

Phase %s%s
101*constraints2
4.1 2default:default2,
Post Commit Optimization2default:defaultZ18-101h px? 
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
?

Phase %s%s
101*constraints2
4.1.1 2default:default2/
Post Placement Optimization2default:defaultZ18-101h px? 
V
APost Placement Optimization Initialization | Checksum: 227029e0d
*commonh px? 
u

Phase %s%s
101*constraints2
4.1.1.1 2default:default2"
BUFG Insertion2default:defaultZ18-101h px? 
?
?BUFG insertion identified %s candidate nets. Inserted BUFG: %s, Replicated BUFG Driver: %s, Skipped due to Placement/Routing Conflicts: %s, Skipped due to Timing Degradation: %s, Skipped due to Illegal Netlist: %s.43*	placeflow2
02default:default2
02default:default2
02default:default2
02default:default2
02default:default2
02default:defaultZ46-56h px? 
H
3Phase 4.1.1.1 BUFG Insertion | Checksum: 227029e0d
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:25:05 ; elapsed = 00:18:38 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
w

Phase %s%s
101*constraints2
4.1.1.2 2default:default2$
BUFG Replication2default:defaultZ18-101h px? 
J
5Phase 4.1.1.2 BUFG Replication | Checksum: 227029e0d
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:25:06 ; elapsed = 00:18:39 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
?
hPost Placement Timing Summary WNS=%s. For the most accurate timing information please run report_timing.610*place2
-65.0332default:defaultZ30-746h px? 
r

Phase %s%s
101*constraints2
4.1.1.3 2default:default2
Replication2default:defaultZ18-101h px? 
?
kPost Replication Timing Summary WNS=%s. For the most accurate timing information please run report_timing.
24*	placeflow2
-65.0332default:defaultZ46-19h px? 
E
0Phase 4.1.1.3 Replication | Checksum: 1c404c799
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:27:17 ; elapsed = 00:20:44 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
S
>Phase 4.1.1 Post Placement Optimization | Checksum: 1c404c799
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:27:18 ; elapsed = 00:20:45 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
N
9Phase 4.1 Post Commit Optimization | Checksum: 1c404c799
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:27:19 ; elapsed = 00:20:46 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
y

Phase %s%s
101*constraints2
4.2 2default:default2*
Post Placement Cleanup2default:defaultZ18-101h px? 
L
7Phase 4.2 Post Placement Cleanup | Checksum: 1c404c799
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:27:22 ; elapsed = 00:20:48 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0422default:default2
5721.5942default:default2
0.0002default:defaultZ17-268h px? 
s

Phase %s%s
101*constraints2
4.3 2default:default2$
Placer Reporting2default:defaultZ18-101h px? 
F
1Phase 4.3 Placer Reporting | Checksum: 27331e429
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:28:12 ; elapsed = 00:21:39 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
z

Phase %s%s
101*constraints2
4.4 2default:default2+
Final Placement Cleanup2default:defaultZ18-101h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0422default:default2
5721.5942default:default2
0.0002default:defaultZ17-268h px? 
M
8Phase 4.4 Final Placement Cleanup | Checksum: 1b69f4613
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:28:13 ; elapsed = 00:21:40 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
\
GPhase 4 Post Placement Optimization and Clean-Up | Checksum: 1b69f4613
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:28:14 ; elapsed = 00:21:41 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
>
)Ending Placer Task | Checksum: 1af8c440a
*commonh px? 
?

%s
*constraints2r
^Time (s): cpu = 00:28:14 ; elapsed = 00:21:41 . Memory (MB): peak = 5721.594 ; gain = 3119.6092default:defaulth px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
612default:default2
02default:default2
02default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
place_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
place_design: 2default:default2
00:28:232default:default2
00:21:472default:default2
5721.5942default:default2
3119.6092default:defaultZ17-268h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0562default:default2
5721.5942default:default2
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
00:00:302default:default2
00:00:122default:default2
5721.5942default:default2
0.0002default:defaultZ17-268h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2p
\D:/NTT_Xilinx/NTT_Vivado/inplaceNTT_DIF/inplaceNTT_DIF.runs/impl_1/inPlaceNTT_DIF_placed.dcp2default:defaultZ17-1381h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2&
write_checkpoint: 2default:default2
00:00:432default:default2
00:00:252default:default2
5721.5942default:default2
0.0002default:defaultZ17-268h px? 
i
%s4*runtcl2M
9Executing : report_io -file inPlaceNTT_DIF_io_placed.rpt
2default:defaulth px? 
?
kreport_io: Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.869 . Memory (MB): peak = 5721.594 ; gain = 0.000
*commonh px? 
?
%s4*runtcl2?
tExecuting : report_utilization -file inPlaceNTT_DIF_utilization_placed.rpt -pb inPlaceNTT_DIF_utilization_placed.pb
2default:defaulth px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2(
report_utilization: 2default:default2
00:00:402default:default2
00:00:412default:default2
5721.5942default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2j
VExecuting : report_control_sets -verbose -file inPlaceNTT_DIF_control_sets_placed.rpt
2default:defaulth px? 
?
qreport_control_sets: Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 5721.594 ; gain = 0.000
*commonh px? 


End Record