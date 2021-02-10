#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Wed Feb 10 18:19:03 2021                
#                                                     
#######################################################

#@(#)CDS: Innovus v17.11-s080_1 (64bit) 08/04/2017 11:13 (Linux 2.6.18-194.el5)
#@(#)CDS: NanoRoute 17.11-s080_1 NR170721-2155/17_11-UB (database version 2.30, 390.7.1) {superthreading v1.44}
#@(#)CDS: AAE 17.11-s034 (64bit) 08/04/2017 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 17.11-s053_1 () Aug  1 2017 23:31:41 ( )
#@(#)CDS: SYNTECH 17.11-s012_1 () Jul 21 2017 02:29:12 ( )
#@(#)CDS: CPE v17.11-s095
#@(#)CDS: IQRC/TQRC 16.1.1-s215 (64bit) Thu Jul  6 20:18:10 PDT 2017 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getDrawView
loadWorkspace -name Physical
win
set init_design_netlisttype verilog
set init_design_settop 1
set init_top_cell risc_v_lite
set init_verilog ../netlist/risc_v_lite.v
set init_lef_file /software/dk/nangate45/lef/NangateOpenCellLibrary.lef
set init_gnd_net VSS
set init_pwr_net VDD
set init_mmmc_file mmm_design.tcl
init_design
getIoFlowFlag
setIoFlowFlag 0
floorPlan -coreMarginsBy die -site FreePDK45_38x28_10R_NP_162NW_34O -r 1.0 0.6 5 5 5 5
uiSetTool select
getIoFlowFlag
fit
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {VDD VSS} -type core_rings -follow core -layer {top metal1 bottom metal1 left metal2 right metal2} -width {top 0.8 bottom 0.8 left 0.8 right 0.8} -spacing {top 0.8 bottom 0.8 left 0.8 right 0.8} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 1 -extend_corner {} -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
selectWire 168.9450 2.9200 169.7450 168.1600 2 VDD
deselectAll
selectWire 2.9650 2.9200 169.7450 3.7200 1 VDD
deselectAll
selectWire 1.3650 1.3200 171.3450 2.1200 1 VSS
deselectAll
zoomSelected
zoomSelected
gui_select -rect {168.219 4.466 191.102 -4.609}
deselectAll
gui_select -rect {183.606 -3.820 154.411 17.485}
zoomSelected
deselectAll
fit
clearGlobalNets
globalNetConnect VDD -type pgpin -pin VDD -inst * -module {}
globalNetConnect VSS -type pgpin -pin VSS -inst * -module {}
gui_select -rect {5.280 4.860 -14.841 5.649}
gui_select -rect {2.124 6.833 9.226 -6.976}
gui_select -rect {-35.750 20.247 10.014 -8.554}
zoomSelected
deselectAll
gui_select -rect {0.354 0.119 -1.187 -0.261}
zoomSelected
deselectAll
selectObject IO_Pin {IM_IN[31]}
deselectAll
selectObject IO_Pin CLK
deselectAll
fit
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { metal1(1) metal10(10) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { metal1(1) metal10(10) } -nets { VDD VSS } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { metal1(1) metal10(10) }
gui_select -rect {-22.337 21.430 193.469 -6.582}
zoomSelected
deselectAll
gui_select -rect {-11.288 21.955 176.411 -3.799}
zoomSelected
zoomIn
deselectAll
selectWire 5.1300 4.9550 167.5800 5.1250 1 VDD
deselectAll
selectWire 5.1300 6.3550 167.5800 6.5250 1 VSS
deselectAll
fit
setPlaceMode -prerouteAsObs {1 2 3 4 5 6 7 8}
setPlaceMode -fp false
placeDesign
setDrawView fplan
setDrawView place
setDrawView ameba
setDrawView place
zoomIn
gui_select -rect {48.809 109.803 68.799 63.907}
zoomSelected
deselectAll
selectWire 5.1300 98.7550 167.5800 98.9250 1 VSS
deselectAll
selectInst datapath_instr_decode_memory_U1516
deselectAll
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postCTS
optDesign -postCTS -hold
saveDesign risc_v_lite.enc
getDrawView
setDrawView fplan
win
dumpToGIF snapshots/ss_risc_v_lite_postcts.fplan.gif
getDrawView
setDrawView amoeba
win
dumpToGIF snapshots/ss_risc_v_lite_postcts.amoeba.gif
getDrawView
setDrawView place
win
dumpToGIF snapshots/ss_risc_v_lite_postcts.place.gif
checkPlace checkplace.ss.rpt
reset_parasitics
extractRC
rcOut -setload risc_v_lite.setload -rc_corner my_rc
rcOut -setres risc_v_lite.setres -rc_corner my_rc
rcOut -spf risc_v_lite.spf -rc_corner my_rc
rcOut -spef risc_v_lite.spef -rc_corner my_rc
getFillerMode -quiet
addFiller -cell FILLCELL_X8 FILLCELL_X4 FILLCELL_X32 FILLCELL_X2 FILLCELL_X16 FILLCELL_X1 -prefix FILLER
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail
saveDesign risc_v_lite.enc
setAnalysisMode -analysisType onChipVariation
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postRoute
optDesign -postRoute -hold
reset_parasitics
extractRC
rcOut -setload risc_v_lite.setload -rc_corner my_rc
rcOut -setres risc_v_lite.setres -rc_corner my_rc
rcOut -spf risc_v_lite.spf -rc_corner my_rc
rcOut -spef risc_v_lite.spef -rc_corner my_rc
saveDesign risc_v_lite.enc
getDrawView
setDrawView fplan
win
dumpToGIF snapshots/ss_risc_v_lite_postroute.fplan.gif
getDrawView
setDrawView amoeba
win
dumpToGIF snapshots/ss_risc_v_lite_postroute.amoeba.gif
getDrawView
setDrawView place
win
dumpToGIF snapshots/ss_risc_v_lite_postroute.place.gif
checkPlace checkplace.ss.rpt
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix risc_v_lite_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix risc_v_lite_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix risc_v_lite_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix risc_v_lite_postRoute_SETUP -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix risc_v_lite_postRoute_HOLD -outDir timingReports
verifyConnectivity -type all -error 1000 -warning 50
setVerifyGeometryMode -area { 0 0 0 0 } -minWidth true -minSpacing true -minArea true -sameNet true -short true -overlap true -offRGrid false -offMGrid true -mergedMGridCheck true -minHole true -implantCheck true -minimumCut true -minStep true -viaEnclosure true -antenna false -insuffMetalOverlap true -pinInBlkg false -diffCellViol true -sameCellViol false -padFillerCellsOverlap true -routingBlkgPinOverlap true -routingCellBlkgOverlap true -regRoutingOnly false -stackedViasOnRegNet false -wireExt true -useNonDefaultSpacing false -maxWidth true -maxNonPrefLength -1 -error 1000
verifyGeometry
setVerifyGeometryMode -area { 0 0 0 0 }
reportGateCount -level 5 -limit 100 -outfile risc_v_lite.gateCount
saveNetlist risc_v_lite.v
all_hold_analysis_views 
all_setup_analysis_views 
write_sdf  -ideal_clock_network risc_v_lite.sdf
saveDesign risc_v_lite.enc
set_power_analysis_mode -reset
set_power_analysis_mode -method static -corner max -create_binary_db true -write_static_currents true -honor_negative_energy true -ignore_control_signals true
reset_parasitics
extractRC
rcOut -setload risc_v_lite.setload -rc_corner my_rc
rcOut -setres risc_v_lite.setres -rc_corner my_rc
rcOut -spf risc_v_lite.spf -rc_corner my_rc
rcOut -spef risc_v_lite.spef -rc_corner my_rc
set_power_analysis_mode -reset
set_power_analysis_mode -method static -corner max -create_binary_db true -write_static_currents true -honor_negative_energy true -ignore_control_signals true
set_power_output_dir -reset
set_power_output_dir power
set_default_switching_activity -reset
set_default_switching_activity -input_activity 0.2 -period 10.0
read_activity_file -reset
read_activity_file -format VCD -scope /tb_risc_v_lite_v2/dut -start {} -end {} -block {} ../vcd/risc_v_lite_rou.vcd
set_power -reset
set_powerup_analysis -reset
set_dynamic_power_simulation -reset
report_power -rail_analysis_format VS -outfile power/risc_v_lite.rpt
set_power_analysis_mode -reset
set_power_analysis_mode -method static -corner max -create_binary_db true -write_static_currents true -honor_negative_energy true -ignore_control_signals true
selectInst FILLER_12411
set_power_output_dir -reset
set_power_output_dir power
set_default_switching_activity -reset
set_default_switching_activity -input_activity 0.2 -period 10.0
read_activity_file -reset
read_activity_file -format VCD -scope /tb_risc_v_lite_v2/dut -start {} -end {} -block {} ../vcd/risc_v_lite_rou.vcd
set_power -reset
set_powerup_analysis -reset
set_dynamic_power_simulation -reset
report_power -rail_analysis_format VS -outfile power/risc_v_lite.rpt
