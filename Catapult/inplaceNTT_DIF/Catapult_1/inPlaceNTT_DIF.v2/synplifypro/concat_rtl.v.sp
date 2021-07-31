## HLS SP synthesis script
## Generated for stage extract

set hls_status 0

proc run_cmd { cmd errstr } {
  upvar hls_status hls_status
  puts $cmd
  set retVal {}
  if { !$hls_status } {
    if { [catch { set retVal [uplevel 1 [list eval $cmd] ] } ] } {
      puts "Error: Unable to $errstr."
      set hls_status 1
    }
  } else {
    puts "Error: $errstr skipped due to previous errors."
  }
  set retVal
}

# Source custom SynplifyPro script for specified stage
# stage is one of: initial analyze synthesis reports final
proc source_custom_script { stage } {
   global env
   if { [info exists env(SynplifyPro_CustomScriptDirPath)] } {
      set dir_path $env(SynplifyPro_CustomScriptDirPath)
      if { $dir_path ne "" } {
         set script [file join $dir_path sp_${stage}.tcl]
         if { [file exists $script] } {
            set cmd "source $script"
            set msg [list run custom script $script]
            uplevel 1 [list run_cmd $cmd $msg]
         } else {
            puts "WARNING: script=$script does not exist"
         }
      }
   } else {
      puts "WARNING: env(SynplifyPro_CustomScriptDirPath) does not exist"
   }
}

# Reporting settings
puts "-- Requested 4 fractional digits for design 'inPlaceNTT_DIF' timing"
puts "-- Requested 4 fractional digits for design 'inPlaceNTT_DIF' capacitance"
puts "-- Characterization mode: p2p "

# Environment variable settings
set CATAPULT_HOME "/opt/mentorgraphics/Catapult_10.5c/Mgc_home"
   project -new inPlaceNTT_DIF_proj

# Source potential custom script
source_custom_script initial

# family='VIRTEX-7' partval='xc7vx690tffg1761-2'
# Quartus version 
   #set_option -pipe 1
   set_option -technology VIRTEX7
   set_option -part XC7vx690t
   set_option -package ffg1761
   set_option -speed_grade -2
   set_option -disable_io_insertion 1
   set_option -frequency 50.0
   add_file -verilog ../concat_rtl.v

   # Source potential custom script
   source_custom_script analyze

   # SDC Timing Constraints
   add_file -constraint ./concat_rtl.v.sp.sdc
   # set top inPlaceNTT_DIF

   # Source potential custom script
   source_custom_script synthesis
puts "-- Starting synthesis for design 'inPlaceNTT_DIF'"
   project -save
   project -run

   # Source potential custom script
   source_custom_script reports
   project -close

# Source potential custom script
source_custom_script final
puts "-- Synthesis finished for design 'inPlaceNTT_DIF'"

