#################################################################
#	This Script File Contains the Following Procedures  	#
#	Build_Horizon					    	#
#	Build_Period_Managers				    	#
#	Build_Capacity_Patterns				    	#
#	Build_CFI						#
#	Build_Locations						#
#################################################################

#################################################################
#	Build Horizon						#
#################################################################

# no longer used
proc Build_Horizon {} {
	cal horizon set [cast date3 time $model(horizon_start)] [cast date3 time $model(horizon_end)]
	echo "start=[cast time date1 [cal horizon get start]],end=[cast time date1 [cal horizon get end]]";
}

#################################################################
#	Build Period Managers                       	  	#
#################################################################

proc Build_Period_Managers {} {
	global path model;

	set fp [open "$path(data)/adx_period_manager.csv" r];
	gets $fp;

	set pMgr {};
	set First 1;
	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,];
		#
		set PeriodMgrId [lindex $linestring 0];
		set HorizonStart [lindex $linestring 1];
		set pIndex [lindex $linestring 2];
		set BucketType [lindex $linestring 3];
		set NumBucket [lindex $linestring 4];
		echo "cal: $linestring,$pIndex";
		if {$pIndex == 1} {
			if {$First} {
				set First 0;
			} else {
				echo "idx=1,pMgrElem=$pMgrElem"
				lappend pMgr $pMgrElem;
			}
			cal period_mgr add $PeriodMgrId;
			cal period_mgr set default $PeriodMgrId;
			set pMgrElem {};
			set hDays 0;
			lappend pMgrElem $PeriodMgrId;
			set model(horizon_start) [cast date1 time [e2a_date $HorizonStart] ];
		}
		set pMgrPeriod {};
		lappend pMgrPeriod $BucketType;
		lappend pMgrPeriod $NumBucket;
		lappend pMgrElem $pMgrPeriod;
		if {$BucketType == "DAY"} {
			set hDays [expr $hDays + $NumBucket];
		} elseif {$BucketType == "WEEK"} {
			set hDays [expr $hDays + $NumBucket*7];
		} elseif {$BucketType == "MONTH"} {
			set hDays [expr $hDays + $NumBucket*30];
		}
		echo "pMgrElem=$pMgrElem";
		echo "pMgr=$pMgr";
	}
	close $fp;
	#
	lappend pMgr $pMgrElem;
	echo "cal list: $pMgr";
	set model(horizon_end) [expr $model(horizon_start) + 86400*$hDays];
	echo "horizon [cast time date1 $model(horizon_start)]-[cast time date1 $model(horizon_end)]"
	cal horizon set $model(horizon_start) $model(horizon_end);
	#
	for {set pm_ix 0} {$pm_ix < [llength $pMgr]} {incr pm_ix} {
		set pMgrCur [lindex $pMgr $pm_ix];
		cal period_mgr set id [lindex $pMgrCur 0];
		set start [cal horizon get start];
		for {set p_ix 1} {$p_ix < [llength $pMgrCur]} {incr p_ix} {
			set pCur [lindex $pMgrCur $p_ix];
			set bType [lindex $pCur 0];
			set bNum [lindex $pCur 1];
			for {set pe_ix 0} {$pe_ix < $bNum} {incr pe_ix} {
				if {$bType == "DAY"} {
					set start [expr $start + 86400];
				} elseif {$bType == "WEEK"} {
					set start [expr $start + 86400*7];
				} elseif {$bType == "MONTH"} {
					set start [expr $start + 86400*30];
				}
				cal period add $start;
			}
		}
	}
	echo "start=[cast time date1 [cal horizon get start]],end=[cast time date1 [cal horizon get end]]";
}

#################################################################
#   	Build Capacity Patterns			      		#
#################################################################

proc Build_Capacity_Patterns {} {
	global path;
	
	set fp [open "$path(data)/adx_cappattern.csv" r];
	gets $fp;

	set pMgr {};
	set First 1;
	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,];
		#
		set patID [lindex $linestring 0];
		set patIdx [lindex $linestring 1];
		set patDur [lindex $linestring 2];
		set patQty [lindex $linestring 3];
		if {$patIdx == 0} {
			if {$First} {
				set First 0;
			} else {
				cal pattern segment set number [llength $patSeg];
				for {set s_ix 0} {$s_ix < [llength $patSeg]} {incr s_ix} {
					set curSeg [lindex $patSeg $s_ix];
					cal pattern segment set ix $s_ix;
					cal pattern segment set dur [lindex $curSeg 0];
					cal pattern segment set qty [lindex $curSeg 1];
				}
			}
			catch {cal pattern add $patID};
			set patSeg {};
		}
		set patSegElem {};
		lappend patSegElem $patDur;
		lappend patSegElem $patQty;
		lappend patSeg $patSegElem;
	}
	close $fp;
}

#################################################################
#	Build CFIs						#
#################################################################

proc Build_CFI {} {
   	global errfp path;
	
	set fp [open "$path(data)/adx_cfi_family.csv" r]
	gets $fp
   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		set Fam_ID [lindex $linestring 0]
		set cfi_type [lindex $linestring 1]
		set Min_Cfi [lindex $linestring 2]
		set Std_Cfi [lindex $linestring 3]
		set Tol_Cfi [lindex $linestring 4]

		if {$cfi_type == "FACTOR"} {
			if {[catch {cfi factor add $Fam_ID $Min_Cfi $Std_Cfi $Tol_Cfi}]} {
				set msg "Cfi - $cfi_type $Fam_ID: CFI cannot be added!"
				puts $errfp $msg
			}
		} else {
			if {[catch {cfi cycle add $Fam_ID $Min_Cfi $Std_Cfi $Tol_Cfi}]} {
				set msg "Cfi - $cfi_type $Fam_ID: CFI cannot be added!"
				puts $errfp $msg
			}
		}
   	}
   close $fp
}

#################################################################
#	Build_Locations						#
#################################################################

proc Build_Locations {} {
   	global errfp path
	#
   	#catch {location attribute add_string LOC_ID};
   	#catch {location attribute add_string LOC_TYPE};
   	#catch {location attribute add_string REGION};
	#
	set fp [open "$path(data)/adx_location.csv" r]
   	gets $fp
   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,];
		set Loc [lindex $linestring 0]
		set loc_type [lindex $linestring 1]
		set loc_desc [lindex $linestring 2]
		set hier_level_1 [lindex $linestring 3]
		set hier_level_2 [lindex $linestring 4]
		set hier_level_3 [lindex $linestring 5]
		set tzone [lindex $linestring 6]
		set holiday [lindex $linestring 7];
		set dst_rule [lindex $linestring 8];
		set latitude [lindex $linestring 9];
		set longitude [lindex $linestring 10];
		set locId [lindex $linestring 11];
		set locType [lindex $linestring 12];
		set region [lindex $linestring 13];
		#echo "location:$linestring,tzone=$tzone";
		if {[catch {location add $Loc}]} {
			set msg "Location: $Loc cannot be added!"
			puts $errfp $msg
		} else {
			if {$loc_desc != "-"} {
				location set desc $loc_desc
	   		}
	   		if {$tzone != "-"} {
				location set time_zone $tzone
	   		}
	   		if {$hier_level_1 != "-"} {
				location attribute_value set HIER_LEVEL_1 $hier_level_1;
	   		}
			if {$hier_level_2 != "-"} {
				location attribute_value set HIER_LEVEL_2 $hier_level_2;
	   		}
			if {$hier_level_3 != "-"} {
				location attribute_value set HIER_LEVEL_3 $hier_level_3;
	   		}
			if {$loc_type != "-"} {
				location set type $loc_type;
			}
			if {$longitude != "-"} {
				location set x_position $longitude;
			}
			if {$latitude != "-"} {
				location set y_position $latitude;
			}
			if {$locId != "-"} {
				location attribute_value set LOC_ID $locId;
			}
			if {$locType != "-"} {
				location attribute_value set LOC_TYPE $locType;
			}
			if {$region != "-"} {
				location attribute_value set REGION $region;
			}
		}
   	}
	close $fp;
}
