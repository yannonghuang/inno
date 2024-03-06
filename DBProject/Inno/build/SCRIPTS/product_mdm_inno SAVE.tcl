#########################################################################
#									#
#	This Script File Contains the Following Procedures		#
#									#
#	Build_Product							#
#	Build_Material							#
#									#
#	Updated by Ed Lawton 2/6/2017					#
#									#
#########################################################################

# prebuild parameter defaults
proc Build_ProdArea {} {
}
#
proc demo_config_products {} {
	if {[catch {method attribute add_integer Org_Pref}]} {
		echo "method attribute Org_Pref existed";
	} else {
		method attribute set Org_Pref max 1000000000;
	}
	
	set maxC [com@location get number];
	for {set c_ix 0} {$c_ix < $maxC} {incr c_ix} {
		com@location set ix $c_ix;
		#
		com@location set level_look_ahead [expr [com@location get explosion] + 1];
		# save original method_alt elem pref
		if {[catch {method_alt set id [com@location get method_alt]}]} {
			continue;
		}
		set maxM [method_alt elem get number];
		for {set m_ix 0} {$m_ix < $maxM} {incr m_ix} {
			method_alt elem set ix $m_ix;
			method set id [method_alt elem get id];
			method attribute_value set Org_Pref [method_alt elem get pref];
		}
	}
}
# not used?
proc Build_Material {} {
	global path
	
	set fp [open "$path(data)/adx_material_inno.csv" r]
	gets $fp
	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		#
		set MatId [lindex $linestring 0]
		set Desc [lindex $linestring 1]
		set GradeNo [lindex $linestring 2]
		set StdSize [lindex $linestring 3]
		set MinSize [lindex $linestring 4]
		set MaxSize [lindex $linestring 5]
		set IncrSize [lindex $linestring 6]
		set TransSize [lindex $linestring 7]
		set Lead [lindex $linestring 8]
		set Loc [lindex $linestring 9]
		set obs [lindex $linestring 10]
		set com_area [lindex $linestring 11]
		set hier_1_1_tla [lindex $linestring 12]
		set hier_1_2_model [lindex $linestring 13]
		set hier_1_3_fam [lindex $linestring 14]
		set asmloc [lindex $linestring 15]
		set pm_cost [lindex $linestring 16]
		set ss_cost [lindex $linestring 17]
		set car_cost [lindex $linestring 18]
		set fabloc [lindex $linestring 19]
		set cycle_days [lindex $linestring 20]
		set prod_fam [lindex $linestring 21]
		set end_item [lindex $linestring 22]
		set prod_group [lindex $linestring 23]
		set h_2_1_area [lindex $linestring 24]
		set h_2_2_all_area [lindex $linestring 25]

		catch {com add $MatId}
		com set type M
		com set id $MatId
		
		if { $hier_1_1_tla != "-" } {
			com attribute_value set HIER_LEVEL_1 $hier_1_1_tla
		}
		if { $hier_1_2_model != "-" } {
			com attribute_value set HIER_LEVEL_2 $hier_1_2_model
		}
		if { $hier_1_3_fam != "-" } {
			com attribute_value set HIER_LEVEL_3 $hier_1_3_fam
		}
		
		if {[catch {com@location add $MatId@$Loc $MatId $Loc}]} {
			if {[catch {com@location set id $MatId@$Loc}]} {
				scp_log "Mat - $MatId@$Loc : Mat cannot be added!"
			} else {
				scp_log "Mat - $MatId@$Loc : Mat already exists"
			} ; #end of inv id check
		} else {
			if {$obs != "-"} {
				inv set obsolete $obs
			}
			if { $Desc != "-" } {
				com@location set desc $Desc
			}

			catch {com@location set grade_number $GradeNo}

			if { $StdSize != "-" } {
				com@location set max_lot $StdSize
				com@location set standard_lot $StdSize
			} else {
				scp_log "Create_Mat - $MatId: Product without M3ndard Lot Size!"
			}
			if {$ss_cost != "-"} {
				com@location set safety_stock_cost $ss_cost
			}
			if {$car_cost != "-"} {
				com@location set carry_cost $car_cost
			}
			if { $MinSize != "-" } {
				if { $MinSize > $StdSize } {
					scp_log "Create_Mat - $MatId: Product min lot size greater then M3ndard!"
				} else {
					com@location set min_lot $MinSize
				}
			}
			if { $MaxSize != "-" } {
				if { $MaxSize < $StdSize } {
					scp_log "Create_Mat - $MatId : Product max lot size less then M3ndard!"
				} else {
					com@location set max_lot $MaxSize
				}
			}
			if { $IncrSize != "-" } {
				com@location set incr_lot $IncrSize
			}
			if { $TransSize != "-" } {
				com@location set trans_lot $TransSize
			}
			if { $com_area != "-" } {
				com@location attribute_value set AREA $com_area
				com@location attribute_value set PROD_AREA $com_area
			}
		}
	}
	close $fp
}
#
proc Build_Product {} {
	global path
	#
	set fp [open "$path(data)/adx_product_inno.csv" r]
	gets $fp
	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,];
		#echo "com:$linestring";
		#
		set ProdId [lindex $linestring 0];
		set Desc [lindex $linestring 1];
		set Type [lindex $linestring 2];
		set pArea [lindex $linestring 3];
		set hier1 [lindex $linestring 4];
		set hier2 [lindex $linestring 5];
		set hier3 [lindex $linestring 6];
		set fg_hier1 [lindex $linestring 7];
		set fg_hier2 [lindex $linestring 8];
		set fg_hier3 [lindex $linestring 9];
		set endItem [lindex $linestring 10];
		set mat_status [lindex $linestring 17]; # 6 extra attributes Chris added go above: YNH
		set late_forecast [lindex $linestring 18];
		set late_sales [lindex $linestring 19];
		#
		catch {com add $ProdId}
		com set type $Type;
		com set id $ProdId;
		com set desc $Desc;
		com attribute_value set HIER_LEVEL_1 $hier1;
		com attribute_value set HIER_LEVEL_2 $hier2;
		com attribute_value set HIER_LEVEL_3 $hier3;
		com attribute_value set FG_HIER_LEVEL_1 $fg_hier1;
		com attribute_value set FG_HIER_LEVEL_2 $fg_hier2;
		com attribute_value set FG_HIER_LEVEL_3 $fg_hier3;
		if { $pArea != "-" } {
			com attribute_value set PRODAREA $pArea;
		}
		if { $endItem != "-" } {
			com attribute_value set END_ITEM $endItem;
		}
		if { $mat_status != "-" } {
			com attribute_value set A_MAT_STATUS $mat_status;
		}
		if { $late_forecast != "-" } {
			com attribute_value set LATE_FORECAST $late_forecast;
		}
		if { $late_sales != "-" } {
			com attribute_value set LATE_SALES $late_sales;
		}
	}
	close $fp
}
#
proc Build_ComLoc {} {
	global path;
	global prodUnitCost;

	set fp [open "$path(data)/adx_productlocation_inno.csv" r]
	#gets $fp
	gets $fp headstring;
	set obj com@location;
	set headstring [split $headstring ,];
	set udarange [importUDAs $obj $headstring];
	#
	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,];
		#echo "comloc:$linestring";
		set ProdId [lindex $linestring 0];
		set Desc [lindex $linestring 1];
		set Loc [lindex $linestring 2];
		set Type [lindex $linestring 3];
		set Res [lindex $linestring 4];
		set MinSize [lindex $linestring 5];
		set MaxSize [lindex $linestring 6];
		set StdSize [lindex $linestring 7];
		set IncrSize [lindex $linestring 8];
		set BuildPer [lindex $linestring 9];
		set Obs [lindex $linestring 10];
		set TimeFence [lindex $linestring 11];
		set CFIType [lindex $linestring 12];
		set CFIFamily [lindex $linestring 13];
		set Inv [lindex $linestring 14];
		set rev [lindex $linestring 15];
		set Share [lindex $linestring 16];
		set Mix [lindex $linestring 17];
		set pArea [lindex $linestring 18];
		set hier1 [lindex $linestring 19];
		set hier2 [lindex $linestring 20];
		set hier3 [lindex $linestring 21];
		set UnitCost [lindex $linestring 22];
		set loc_id [lindex $linestring 23];
		set hold_cost [lindex $linestring 24];
		set prod_fam [lindex $linestring 25];
		set prod_group [lindex $linestring 26];
		set opOverridetype [lindex $linestring 27];
		set srcUda [lindex $linestring 28];
		set fabTech [lindex $linestring 29];
		set asmPkg [lindex $linestring 30];
		set shared [lindex $linestring 31];
		set fabLoc [lindex $linestring 31];
		#set mat_status [lindex $linestring 25];
		#set late_forecast [lindex $linestring 26];
		#set late_sales [lindex $linestring 27];
		#
		if {[catch {com@location add $ProdId@$Loc $ProdId $Loc}]} {
			if {[catch {com@location set id $ProdId@$Loc}]} {
				echo "Prod - $ProdId@$Loc : Product cannot be added!"
				scp_log "Prod - $ProdId@$Loc : Product cannot be added!"
			} else {
				scp_log "Prod - $ProdId@$Loc : Product already exists"
			} ; #end of inv id check
		} else {
			#echo "...[com@location get id] added";
			if {$CFIType != "-"} {
				com@location set cfi_type $CFIType
				com@location set cfi $CFIFamily
			}
			if {$BuildPer != "-"} {
				com@location set build_period $BuildPer
			}
			if {$rev != "-"} {
				com@location set revenue $rev
			}
			if { $Desc != "-" } {
				com@location set desc $Desc
			}
			if { $StdSize != "-" } {
				com@location set max_lot $StdSize
				com@location set standard_lot $StdSize
			} else {
				scp_log "Create_Prod - $ProdId : Product without M3ndard Lot Size!"
			}
			if { $MinSize != "-" } {
				if { $MinSize > $StdSize } {
					scp_log "Create_Prod - $ProdId : Product min lot size greater then M3ndard!"
				} else {
					com@location set min_lot $MinSize
				}
			}
			if { $MaxSize != "-" } {
				if { $MaxSize < $StdSize } {
					scp_log "Create_Prod - $ProdId : Product max lot size less then M3ndard!"
				} else {
					com@location set max_lot $MaxSize
				}
			}
			if { $IncrSize != "-" } {
				com@location set incr_lot $IncrSize
			}
			if { $Share != "-" } {
				com@location set share $Share
			}
			if { $Mix != "-" } {
				com@location set mix $Mix
			}
			if { $Inv != "-" } {
				com@location set inventory $Inv
			}
			if { $Obs != "-" } {
				com@location set obsolete $Obs
			}
			if { $pArea != "-" } {
				com@location attribute_value set PROD_AREA $pArea
			}
			if { $prod_fam != "-"} {
				com@location attribute_value set PRODUCT_FAMILY $prod_fam
			}
			if { $prod_group != "-"} {
				com@location attribute_value set PRODUCT_GROUP $prod_group
			}
			if { $hier1 != "-"} {
				com@location attribute_value set HIER_LEVEL_1 $hier1
			}
			if { $hier2 != "-"} {
				com@location attribute_value set HIER_LEVEL_2 $hier2
			}
			if { $hier3 != "-"} {
				com@location attribute_value set HIER_LEVEL_3 $hier3
			}
			if { $UnitCost != "-" } {
				#echo "[com@location get id] cost=[com@location attribute_value get product_unit_cost] to be $UnitCost";
				#com@location attribute_value set product_unit_cost $UnitCost;
				set prodUnitCost($ProdId@$Loc) $UnitCost;
			} else {
				set prodUnitCost($ProdId@$Loc) 0;
			}
			if { $hold_cost != "-"} {
				com@location attribute_value set HOLD_COST $hold_cost
			}
			if { $loc_id != "-" } {
				com@location attribute_value set LOC_ID $loc_id
			}
			if { $opOverridetype != "-" } {
				com@location attribute_value set OpOverrideType	$opOverridetype;
			}
			if { $srcUda != "-" } {
				com@location attribute_value set SOURCING_UDA $srcUda;
			}
			if { $fabTech != "-" } {
				com@location attribute_value set TECHNOLOGY $fabTech;
			}
			if { $asmPkg != "-" } {
				com@location attribute_value set PACKAGE $asmPkg;
			}
			if { $shared != "-" } {
				com@location attribute_value set SHARED $shared;
			}
			if { $fabLoc != "-" } {
				com@location attribute_value set FAB_LOC $fabLoc;
			}
			#if { $mat_status != "-" } {
			#	com@location attribute_value set A_MAT_STATUS $mat_status;
			#} [lindex $linestring 27];
		}
		for {set i 0} {$i < [llength $udarange]} {incr i} {
			set utmp [split [lindex $udarange $i] :]
			set u_ix [lindex $utmp 0]
			set u_id [lindex $utmp 1]
			if {[lindex $linestring $u_ix] != "-"} {
			    echo "Method ($linestring $u_ix): $obj setting $u_id to [lindex $linestring $u_ix]"	
				$obj attribute_value set $u_id [lindex $linestring $u_ix]

			}
		}
	}
	close $fp
}

proc demo_set_product_unit_cost {} {
	global path
	global prodUnitCost;

	for {set c_ix 0} {$c_ix < [com@location get number]} {incr c_ix} {
		com@location set ix $c_ix;
		com@location attribute_value set product_unit_cost $prodUnitCost([com@location get id]);
	}
	return;
	set fp [open "$path(data)/adx_productlocation_inno.csv" r]
	gets $fp
	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		set ProdId [lindex $linestring 0];
		set Loc [lindex $linestring 2];
		set UnitCost [lindex $linestring 22];
		com@location set id $ProdId@$Loc;
		if { $UnitCost != "-" } {
			#echo "[com@location get id] cost=[com@location attribute_value get product_unit_cost] to be $UnitCost";
			com@location attribute_value set product_unit_cost $UnitCost;
		}
	}
	close $fp
}

#
proc demo_set_PSIGroup {} {
	global model;
	
	echo "...set PSI Group";
	set maxCom [com@location get number];
	for {set c_ix 0} {$c_ix < $maxCom} {incr c_ix} {
		com@location set ix $c_ix;
		if {[com@location attribute_value get PROD_AREA] eq "FAB"} {
			set comId  [com@location get commodity];
			com set id $comId;
			com attribute_value set PSI_GROUP $comId;
		}
	}
	for {set c_ix 0} {$c_ix < $maxCom} {incr c_ix} {
		com@location set ix $c_ix;
		set pArea [com@location attribute_value get PROD_AREA];
		if {$pArea == "RAW"} {
			continue;
		}
		set comId [com@location get commodity];
		set comLoc [com@location get id];
		#echo "PSI:comLoc=$comLoc,pArea=$pArea";
		set psiGrp [demo_get_PSIGroup $comLoc 0];
		if {$psiGrp == "-"} {
			set psiGrp "UNASSIGNED";
		}
		#echo ".....>>psi=$comLoc,$psiGrp";
		com set id $comId;
		com attribute_value set PSI_GROUP $psiGrp;
		com@location set id $comLoc;
		com@location attribute_value set PSI_GROUP $psiGrp;
	}
}
#
proc demo_get_PSIGroup {psi_comloc psi_level} {
	global _fileName;
	#
	incr psi_level;
	if {$psi_level > 14} {
		echo "----->return from $psi_comloc: circular bom?"
		return "Circular BOM?";
	}
	com@location set id $psi_comloc;
	com set id [com@location get commodity];
	#echo "----->demo_get_PSIGroup:$psi_comloc,psi_level=$psi_level,parea=[com attribute_value get PROD_AREA]";
	if {[com attribute_value get PROD_AREA] eq "FAB"} {
		# KB, LF w/o KB, or sourced LF
		#echo ".....>return from $psi_comloc,[com@location attribute_value get PROD_AREA],[com attribute_value get PSI_GROUP],psi_level=$psi_level";
		return [com attribute_value get PSI_GROUP];
	}
	if {[catch {method_alt set id [com@location get method_alt]}]} {
		echo ".....>return from $psi_comloc,ma=[com@location get method_alt])";
		return "UNASSIGNED";
	}
	set nMethod [method_alt elem get number];
	for {set m_ix 0} {$m_ix < $nMethod} {incr m_ix} {
		method_alt elem set ix $m_ix;
		#method_alt elem set ix 0; #all alternatives should be the same
		if {[catch {method set id [method_alt elem get id]}]} {
			echo ".....>return from $psi_comloc,m=[method_alt elem get id])";
			return "UNASSIGNED";
		}
		if {[method get type] == "P"} {
			continue;
		} elseif {[method get type] == "T"} {
			set loc [method get location];
		} else {
			set loc [com@location get location];
		}
		set bomID [method get bom];
		if {[catch {bom set id $bomID}]} {
			echo ".....>retrun from $psi_comloc,bom=$bomID";
			return "UNASSIGNED";
		}
		bom set id $bomID;
		bom elem set ix 0;
		set comlocID [format "%s@%s" [bom elem get id] $loc];
		#set c_m_ix $m_ix;
		set maId [method_alt get id];
		set psiGroup [demo_get_PSIGroup $comlocID $psi_level];
		#echo ".....> return from recursive: m_ix=$m_ix,c_m_ix=$c_m_ix,psi_level=$psi_level,nMethod=$nMethod,ma=[method_alt get id]"
		#set m_ix $c_m_ix;
		method_alt set id $maId;
		#set nBomElem [bom elem get number];
		#for {set be_ix 0} {$be_ix < $nBomElem} {incr be_ix} {
		#	#echo "...bom=[bom get id],bomID=$bomID,be_ix=$be_ix";
		#	bom set id $bomID;
		#	bom elem set ix $be_ix;
		#	set comlocID [format "%s@%s" [bom elem get id] $loc];
		#	set psiGroup [demo_get_PSIGroup $comlocID $psi_level];
		#}
	} 
	#echo "return psi-$psi_comloc-level=$psi_level-$psiGroup";
	return $psiGroup;
	
}
