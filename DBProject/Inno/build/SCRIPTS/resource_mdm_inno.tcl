########################################################################$
#									#
#	This Script File Contains the Following Procedures		#
#									#
#	Build_Resources							#
#	Build_Resource_Alternatives_Groups				#
#	Build_Bills_of_Resources					#
#	Build_BoR_Alternatives						#						
#	Build_Wip_Buffers						#
#	Build_PM_Programs						#
#	Build_PM_Resources						#
#									#
#	Update by Ed Lawton 02/01/2017					#
#									#
#########################################################################

proc Build_Resources {} {
	global path errfp
	
	set fp [open "$path(data)/adx_resource_inno.csv" r]
	gets $fp

	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,];
		#echo "res:$linestring"
		set ResId [lindex $linestring 0];
		set Desc [lindex $linestring 1];
		set Loc [lindex $linestring 2];
		set ResType [lindex $linestring 3];
		set BatchPeriod [lindex $linestring 4];
		set BatchType [lindex $linestring 5];
		set AvgBatch [lindex $linestring 6];
		set MinBatch [lindex $linestring 7];
		set MaxBatch [lindex $linestring 8];
		set Speed [lindex $linestring 9];
		set MultiRes [lindex $linestring 10];
		set Care [lindex $linestring 11];
		set Delay [lindex $linestring 12];
		set PrdMngr [lindex $linestring 13];
		set SetupMatrix [lindex $linestring 14];
		set CapType [lindex $linestring 15];
		set MixType [lindex $linestring 16];
		set RES_H1 [lindex $linestring 17];
        set RES_H2 [lindex $linestring 18];
        set RES_H3 [lindex $linestring 19];
		set opOverridetype [lindex $linestring 20];
		#
		if {$ResType == "C"} {
			if { [catch {res add_crew $ResId}] } {
				set msg "Resource - $ResId : Duplicate Resource Id - $ResId"
				#puts $errfp $msg
				puts $msg;
			} else {
				res set id $ResId
			}
		} else {
			if { [catch {res add $ResId}] } {
				set msg "Resource - $ResId : Duplicate Resource Id - $ResId"
				#puts $errfp $msg
				puts $msg;
	     	} else {
				res set id $ResId
			}
        }
		catch {res set location $Loc};
		if { $MaxBatch != "-" } {
			res set max_batch $MaxBatch
		}
		if { $AvgBatch != "-" } {
			res set avg_batch $AvgBatch
		}
		if { $MinBatch != "-" } {
		   res set min_batch $MinBatch
		}
		if { $MultiRes != "-" } {
		   res set multi_res $MultiRes
		}
		if { $MixType != "-" } {
		   res set mix_type $MixType
		}
		if {$RES_H1 != "-"} {
			res attribute_value set HIER_LEVEL_1 $RES_H1
			#res attribute_value set HIER_1_1_RES_TYPE $RES_H1
		}
		if {$RES_H2 != "-"} {
  			res attribute_value set HIER_LEVEL_2 $RES_H2                  
		   	#res attribute_value set HIER_1_2_RES_GROUP $RES_H2
		}
		if {$RES_H3 != "-"} {
			res attribute_value set HIER_LEVEL_3 $RES_H3
			#res attribute_value set HIER_1_3_ALL_RES $RES_H3
		}
		if { $SetupMatrix != "-" } {
			#echo "Setup Matrix: $SetupMatrix for RES [res get id]"
			res set setup_matrix $SetupMatrix
			res set setup_mode on
			# res set rds_algorithm least_setup_order
		}
		if {$CapType != "-"} {
			set splitCT [split $CapType ~]
			set cType [regsub -all " " $splitCT ,]
			res set capable_type $cType
		}
		if { $PrdMngr != "-" } {
			if { [catch {cal period_mgr set id $PrdMngr}] } {
				set msg "Resource - $PrdMngr : Invalid Period Manager ID"
				puts $errfp $msg
			} else {
				res set period_mgr $PrdMngr
			}
		}
		if { $Care != "-" } {
			res set care $Care
		}
		if { $Delay != "-" } {
			res set delay $Delay
		}
		if { $opOverridetype != "-" } {
			res set OpOverrideType $opOverridetype;
		}
   	}
   	close $fp
}

proc Build_ResCapInter {} {
	global path;
	
	set fp [open "$path(data)/adx_rescapinter_inno.csv" r];
	gets $fp;
	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,];
		#echo "rescapinter: $linestring";
		set ResId [lindex $linestring 0];
		set Start [lindex $linestring 1];
		set Offset [lindex $linestring 2];
		set capFactor [lindex $linestring 3];
		set capPat [lindex $linestring 4];
		#
		res set id $ResId;
		if {$Start != "-"} {
			res inter add [cast date1 time $Start];
		} else {
			#res inter add [cal horizon get start];
			res inter set ix 0;
		}
		if { $Offset != "-" } {
			res inter set offse $Offset;
		}
		if { $capFactor != "-" } {
			res inter set factor $capFactor;
		}
		if { $capPat != "-" } {
			res inter set pat $capPat;
		}
	}
	close $fp;
}

proc Build_ResCapExc {} {
	global path;
	
	set fp [open "$path(data)/adx_rescapexc_inno.csv" r];
	gets $fp;
	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,];
		set ResId [lindex $linestring 0];
		set Start [lindex $linestring 1];
		set excDur [lindex $linestring 2];
		set excQty [lindex $linestring 3];
		#
		res set id $ResId;
		res exc add [cast date1 time $Start];
		if { $excDur != "-" } {
			res exc set dur $excDur;
		}
		if { $excQty != "-" } {
			res exc set qty $excQty;
		}
	}
	close $fp;
}

#########################################################################
#	Create Resource Alternatives					#
#########################################################################
proc Build_Resource_Alt_Groups {} {

   	global path errfp

   	set fp [open "$path(data)/adx_resalt_inno.csv" r]
   	gets $fp

   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		#
		set OpId [lindex $linestring 0]
		set ResAltId [lindex $linestring 1]
		set Pref [lindex $linestring 2]
		set ResId [lindex $linestring 3]

		catch {res_alt add $ResAltId};
		res_alt set id $ResAltId; # YNH
		
		if { [catch {res_alt elem add $ResId}] } {
			if {[catch {res set id $ResId}]} {
				set msg "Resource Alt - $ResAltId : Invalid Resource $ResId"
			} else {
				set msg "Resource Alt - $ResAltId : Resource Already Exists $ResId"
			}
			puts $errfp $msg
		}
   	}
   	close $fp
}

#########################################################################
#	Create Bills-of-Resources					#
#########################################################################
proc Build_Bill_of_Resource {} {

   	global path errfp

   	set fp [open "$path(data)/adx_bor_inno.csv" r]
   	gets $fp

   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		#
		set BoRId [lindex $linestring 0]
		set ResAltId [lindex $linestring 2]
		set Usagerate [lindex $linestring 3]

		catch {bor add $BoRId}
		bor set id $BoRId;
		#
		if { [catch {bor elem add $ResAltId}] } {
			if {[catch {res_alt set id $ResAltId}]} {
		   		set msg "BoR - $BoRId : Invalid Resource Alt $ResAltId"
			} else {
		   		set msg "BoR - $BoRId : Resource Alt Already Exists $ResAltId"
			}
			puts $errfp $msg
		} else {
			catch {bor elem set rate $Usagerate}
   		}
   	}
   	close $fp
}

#########################################################################
#	Create Bill-of-Resources Alternatives				#
#########################################################################
proc Build_BoR_Alternatives {} {

   	global path errfp

   	set fp [open "$path(data)/adx_bora_inno.csv" r]
   	gets $fp;

   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		#echo "bora: $linestring";
		set BoRAltId [lindex $linestring 0]
		set BoRId [lindex $linestring 1]
		set Pref [lindex $linestring 2]

		catch {bor_alt add $BoRAltId}

		if { [catch {bor_alt elem add $BoRId}] } {
			if {[catch {bor set id $BoRId}]} {
		   		set msg "BoR Alt- $BoRAltId : Invalid BoR $BoRId"
			} else {
		   		set msg "BoR Alt - $BoRAltId : BoR Already Exists $BoRId"
			}
			puts $errfp $msg
		}
		bor_alt elem set pref $Pref
   	}
   	close $fp
}

#########################################################################
#	Add Wip Buffers			 				#
#########################################################################

proc Build_Wip_Buffers {} {

   	global path errfp

   	set fp [open "$path(data)/WIP_Buffers.csv" r]
   	gets $fp

   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]

    		set Id [lindex $linestring 0]
		set Desc [lindex $linestring 1]
		set Max [lindex $linestring 2]
		set Min [lindex $linestring 3]

		wipbuffer add $Id
		wipbuffer set desc $Desc
		wipbuffer set max_buffer $Max
		wipbuffer set min_buffer $Min
   	}
   	close $fp

}

#########################################################################
#	Add Preventative Mainenance Programs				#
#########################################################################

proc Build_PM_Programs {} {

   	global path errfp
   	set fp [open "$path(data)/PM_Programs.csv" r]
   	gets $fp

   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
   		set linestring [split $linestring ,]

		prevmain add [lindex $linestring 0]
		prevmain set id [lindex $linestring 0]
		prevmain set desc [lindex $linestring 1]
		prevmain set uom [lindex $linestring 2]
		prevmain set cycle [lindex $linestring 3]
		prevmain set cycle_type [lindex $linestring 4]
		prevmain set tolerance [lindex $linestring 5]
		prevmain set duration [lindex $linestring 6]
		prevmain set bor [lindex $linestring 7]
   	}
   	close $fp
}

proc Build_PM_Resources {} {

	global path errfp
	set fp [open "$path(data)/PM_Resources.csv" r]
	gets $fp

	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		res set id [lindex $linestring 0]
	 	res prevmain add [lindex $linestring 1]
	 	res prevmain set id [lindex $linestring 1]
	 	res prevmain set offset [lindex $linestring 2]
	 	res prevmain set prevmain [lindex $linestring 3]
	}
	close $fp
}


