#################################################################
#	This Script File Contains the Following Procedures
#	Connect_MethAlt_to_Product
#   Build_Method_Alt
#   Build_Purchase_Method
#   Build_Method
#	Build_Route
#	Build_Bill_of_Material                         
#	Build_RouteSeg
#	Build_StepSeq
#	Build_Operation
#	Build_Op_Overrides
#################################################################

proc Connect_MethAlt_to_Product {} {
   	global errfp path;

   	set fp [open "$path(data)/adx_productlocation_inno.csv" r];
   	gets $fp
   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		#echo "product: $linestring";
		set ProdId [lindex $linestring 0];
		set Loc [lindex $linestring 2];
		#
		
		if [catch {com@location set id "$ProdId@$Loc"} err] {echo "!!$err:com@location set id $ProdId@$Loc"; continue}
		if [catch {com@location set method_alt "$ProdId@$Loc"} err] {echo "!!$err:com@location set method_alt $ProdId@$Loc"; continue}
   	}
   	close $fp
}
#
proc Build_Vendor {} {
	global data_path error_path;
	global errfp path;
	#
	set fp [open "$path(data)/adx_vendor_inno.csv" r];
	gets $fp;
	#
	while {[gets $fp linestring] > 0} {
		#echo $linestring
		set linestring [split $linestring ,]
		set id [lindex $linestring 0];
		set descr [lindex $linestring 1];
		set hier1 [lindex $linestring 2];
		set hier2 [lindex $linestring 3];
		set hier3 [lindex $linestring 4];
		set venType [lindex $linestring 5];
		#
		vendor add $id;
		vendor set desc $descr;
		if {$venType != "-"} {
			vendor attribute_value set VENDOR_TYPE $venType;
		}
		if {$hier1 != "-"} {
			vendor attribute_value set HIER_LEVEL_1 $hier1;
		}
		if {$hier2 != "-"} {
			vendor attribute_value set HIER_LEVEL_2 $hier2;
		}
		if {$hier3 != "-"} {
			vendor attribute_value set HIER_LEVEL_3 $hier3;
		}
	}
	close $fp;
}
#
proc Build_Purchase_Method {} {
   	global errfp model path

   	set fp [open "$path(data)/adx_method_buy_inno.csv" r]
   	gets $fp

   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,];
		echo "p-mthd:$linestring"
		set MatId [lindex $linestring 0];
		set Loc [lindex $linestring 1];
		set Pref [lindex $linestring 2];
		set pm_cost [lindex $linestring 3];
		set minsupply [lindex $linestring 4];
		set maxsupply [lindex $linestring 5];
		set leaddays [lindex $linestring 6];
		set cycledays [lindex $linestring 7];
		set vendorid [lindex $linestring 8];
		set effstart [lindex $linestring 9];
		set effend [lindex $linestring 10];
		set hier1 [lindex $linestring 11];
		set hier2 [lindex $linestring 12];
		set hier3 [lindex $linestring 13];
		set puCost [lindex $linestring 14];
		#
		set mthdID "P_$MatId\_$vendorid\@$Loc";
		if {[catch {method add_purchase $mthdID $Loc}]} {
			if {[catch {method set id $mthdID}]} {
	   			set msg "Methods - $mthdID : Method id Invalid"
	   			puts $errfp $msg
	   		} else {
				set msg "Methods - $mthdID : Method Already Exists"
	   			puts $errfp $msg
	   		}
		} else {
			method set id $mthdID;
			if { $leaddays != "-" } {
				method set lead $leaddays
			}
			if {$pm_cost != "-"} {
				#method attribute_value set Usage_Cost $pm_cost
				method attribute_value set COST_DIRECT $pm_cost;
				if {$pm_cost > 0} {
					method attribute_value set COST_INDIRECT 0;
				}
			}
			if { $cycledays != "-" } {
		   		method set cycle $cycledays
			}
			method set max_supply $maxsupply
			method set min_supply $minsupply
			method set standard_lot $maxsupply
			method set trans_lot $minsupply
			method set min_lot $minsupply
			method set max_lot $maxsupply
			method set incr_lot $minsupply
			if { $vendorid != "-" } {
				#if {[catch {vendor set id $vendorid}]} {
				#	vendor add $vendorid;
				#}
		   		method set vendor $vendorid
			}
			#
			#echo MatId:$MatId
			com set id $MatId;
			set pArea [com attribute_value get PRODAREA];
			if {$pArea != "-"} {
				method attribute_value set PROD_AREA $pArea
			}
			#echo "com@location set id $MatId@$Loc"
			com@location set id $MatId@$Loc;
			method attribute_value set LOC_ID [com@location attribute_value get LOC_ID];
			#
			if {[catch {method_alt add "$MatId\@$Loc"}]} {
				method_alt set id "$MatId\@$Loc";
			}
			
			#echo !!MAKE..[method_alt get id]
			
			method_alt elem add $mthdID;
			method_alt elem set pref $Pref;
			#if {$pArea == "FG" && $model(DC_PO) == 0} {
			#	method_alt elem set pref 0;
			#} else {
			#	method_alt elem set pref $Pref;
			#}
			# effectivity dates in date1 format
			if { $effstart != "-" } {
				method_alt elem set eff_start [e2d_date $effstart];
			}
			if { $effend != "-" } {
				method_alt elem set eff_end [e2d_date $effend];
			}
		}
		#echo !!1.[method get id]..$hier1.$hier2.$hier3
		method attribute_value set HIER_LEVEL_1 $hier1;
		method attribute_value set HIER_LEVEL_2 $hier2;
		method attribute_value set HIER_LEVEL_3 $hier3;
		method attribute_value set process_unit_cost $puCost;
		#echo !!2.[method get id]..[method attribute_value get HIER_LEVEL_1].[method attribute_value get HIER_LEVEL_2].[method attribute_value get HIER_LEVEL_2]
		
   	}
   	close $fp;
}
#
proc Build_Method_Make {} {
   	global errfp model path;
	global altBomParent altBom altBomChild;
	#
   	set fp [open "$path(data)/adx_method_make_inno.csv" r]
   	#gets $fp;
	gets $fp headstring;
	set obj method;
	set headstring [split $headstring ,];
	set udarange [importUDAs $obj $headstring];
	#
	set mLine {};
	set lProdId {};
	set lLoc {};
	set lRoute {};
	set lPref {};
	set lCost {};
	set lBoMId {};
	set lBoGId {};
	set leff_start {};
	set leff_end {};
	#set ldmSpec {};
	#set lassyloc {};
   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		# "method: $linestring";
		lappend mLine $linestring;
		lappend lProdId [lindex $linestring 0];
		lappend lLoc [lindex $linestring 1];
		lappend lRoute [lindex $linestring 2];
		lappend lPref [lindex $linestring 3];
		lappend lCost [lindex $linestring 4];
		lappend lBoMId [lindex $linestring 5];
		lappend lBoGId [lindex $linestring 6];
		lappend leff_start [lindex $linestring 7];
		lappend leff_end [lindex $linestring 8];
		#lappend ldmSpec [lindex $linestring 9];
		#lappend lassyloc [lindex $linestring 10];
		#lappend lfabloc [lindex $linestring 11];
 		lappend lhier1 [lindex $linestring 9];
		lappend lhier2 [lindex $linestring 10];
		lappend lhier3 [lindex $linestring 11];
		lappend lpuCost [lindex $linestring 12];
  	}
   	close $fp;
	#
	for {set l_ix 0} {$l_ix < [llength $lProdId]} {incr l_ix} {
		set ProdId [lindex $lProdId $l_ix];
		set Loc [lindex $lLoc $l_ix];
		set Route [lindex $lRoute $l_ix];
		set Pref [lindex $lPref $l_ix];
		set Cost [lindex $lCost $l_ix];
		set BoMId [lindex $lBoMId $l_ix];
		set BoGId [lindex $lBoGId $l_ix];
		set effstart [lindex $leff_start $l_ix];
		set effend [lindex $leff_end $l_ix];
		#set dmSpec [lindex $ldmSpec $l_ix];
		#set assyloc [lindex $lassyloc $l_ix];
		#set fabloc [lindex $lfabloc $l_ix];
		set hier1 [lindex $lhier1 $l_ix];
		set hier2 [lindex $lhier2 $l_ix];
		set hier3 [lindex $lhier3 $l_ix];
		set puCost [lindex $lpuCost $l_ix];
		set linestring [lindex $mLine $l_ix];


		#set idx [lsearch -sorted $altBomParent $ProdId];
		#set mylength [llength $altBomParent]
		#echo "$ProdId"
		set rList [array get altBomParent $ProdId]
		#echo "===== $rList"
		if {[llength $rList] > 0} {
			set lAltBom [lindex $rList 1];
			#set lAltBom [lindex $altBomParent $idx];
		    #echo "lsearch -all $altBomParent $ProdId = $lAltBom"
		
			set prefereceList [split $Pref |]; #YNH
			echo "...prefereceList=$prefereceList"; #YNH
			for {set b_ix 0} {$b_ix < [llength $lAltBom]} {incr b_ix} {
				set myPreference [lindex $prefereceList $b_ix]; #YNH
				set altBomId [lindex $lAltBom $b_ix];
				set mthdId [format "M_%s_%s_%s_%s" $ProdId $Route $altBomId $Loc];
				#set mthdId [format "M_%s_%s_%s" $ProdId $Route $altBomId];	YNH			
				#echo "lAltBom method add_manufacture $mthdId $Loc"
				
				#if [catch {method add_manufacture $mthdId $Loc} err] {echo "$err...mthdId=$mthdId"; continue}; #YNH					
				method add_manufacture $mthdId $Loc; 
				
				method set id $mthdId;
				echo "...ProdId=$ProdId,BoMId=$BoMId,Route=$Route,altBomId=$altBomId";
				
				if [catch {method set bom $altBomId} err] {echo "$err...altBomId=$altBomId"; continue}; #YNH						
				#method set bom $altBomId;
				
				method set route $Route;
				if {$Cost != "-"} {
					method attribute_value set COST_DIRECT $Cost;
					if {$Cost > 0} {
						method attribute_value set COST_INDIRECT 0;
					}
				}
				if {$BoGId != "-"} {
					method set bog $BoGId
				}
#				method attribute_value set DM_SPEC [lindex $ldmSpec [lsearch $lProdId [lindex $altBomChild $b_ix]]];
				com set id $ProdId;
				set pArea [com attribute_value get PRODAREA];
				if {$pArea != "-"} {
					method attribute_value set PROD_AREA $pArea;
				}
				#if {$assyloc != "-"} {
				#	method attribute_value set ASSY_LOC $assyloc;
				#}
				#if {$fabloc != "-"} {
				#	method attribute_value set FAB_LOC $fabloc;
				#}
				com@location set id $ProdId@$Loc;
				method attribute_value set LOC_ID [com@location attribute_value get LOC_ID];
				# add method_alt elem							
				if {[catch {method_alt add $ProdId@$Loc}]} { 				
					method_alt set id $ProdId@$Loc;			
				} 

				#if [catch {method_alt elem add $mthdId} err] {echo "$err...mthdId=$mthdId"; continue}; #YNH					
				method_alt elem add $mthdId;
				
				if [catch {method_alt elem set pref $myPreference} err] {echo "$err...myPreference=$myPreference"}; #YNH				
				#method_alt elem set pref $Pref; YNH
				
				# TBA: effectivity dates in date1 format
				if { $effstart != "-" } {
					method_alt elem set eff_start [e2d_date $effstart];
				}
				if { $effend != "-" } {
					method_alt elem set eff_end [e2d_date $effend];
				}
			}
		} else {
		    if {$BoMId eq ""} {set BoMId $Loc}  ;#vn patch
			set mthdId "M_$ProdId\_$Route\_$BoMId\_$Loc";
			#set mthdId "M_$ProdId\_$Route\_$BoMId"; YNH			
			#echo "M_$ProdId\_$Route\_$BoMId method add_manufacture $mthdId $Loc"
			method add_manufacture $mthdId $Loc;
			method set id $mthdId;
			#echo "...ProdId=$ProdId,BoMId=$BoMId,Route=$Route,dmSpec=$dmSpec";
			if [catch {method set bom $BoMId} err] {echo "$err...ProdId=$ProdId,BoMId=$BoMId,Route=$Route, Loc=$Loc"; continue} #YNH
			#if [catch {method set bom $BoMId} err] {echo "$err...ProdId=$ProdId,BoMId=$BoMId,Route=$Route, Loc=$Loc"} YNH
        
			echo "...ProdId=$ProdId,BoMId=$BoMId,Route=$Route"		
			method set route $Route;
			
			if {$Cost != "-"} {
				method attribute_value set COST_DIRECT $Cost;
				if {$Cost > 0} {
					method attribute_value set COST_INDIRECT 0;
				}
			}
			if {$BoGId != "-"} {
				method set bog $BoGId;
			}
			#if {$dmSpec != "-"} {
			#	method attribute_value set DM_SPEC $dmSpec;
			#}
			#if {$Pref > 100} {}
			#if {$Cfi_Type != "-"} {
			#	method set cfi_type $Cfi_Type
			#	method set cfi $Cfi_Id
			#}
			com set id $ProdId;
			set pArea [com attribute_value get PRODAREA];
			if {$pArea != "-"} {
				method attribute_value set PROD_AREA $pArea
			}
			#if {$assyloc != "-"} {
			#	method attribute_value set ASSY_LOC $assyloc;
			#}
			#if {$fabloc != "-"} {
			#	method attribute_value set FAB_LOC $fabloc;
			#}
			com@location set id $ProdId@$Loc;
			method attribute_value set LOC_ID [com@location attribute_value get LOC_ID];
			# add method_alt elem
			if {[catch {method_alt add $ProdId@$Loc}]} {
				method_alt set id $ProdId@$Loc;
			}
			
			#echo !!MAKE..[method_alt get id]
			
			method_alt elem add $mthdId;
			#echo "$mthdId:pArea=$pArea,model(DC_MFG)=$model(DC_MFG)"
			#if {$pArea == "FG" && $model(DC_MFG) == 0} {
			#	#echo "...disable method";
			#	method_alt elem set pref 0;
			#} else {
			#	method_alt elem set pref $Pref;
			#}
			method_alt elem set pref $Pref;
			# effectivity dates in date1 format
			if { $effstart != "-" } {
				method_alt elem set eff_start [e2d_date $effstart];
			}
			if { $effend != "-" } {
				method_alt elem set eff_end [e2d_date $effend];
			}
		}
		method attribute_value set HIER_LEVEL_1 $hier1;
		method attribute_value set HIER_LEVEL_2 $hier2;
		method attribute_value set HIER_LEVEL_3 $hier3;
		method attribute_value set process_unit_cost $puCost;
		#
		for {set i 0} {$i < [llength $udarange]} {incr i} {
			set utmp [split [lindex $udarange $i] :]
			set u_ix [lindex $utmp 0]
			set u_id [lindex $utmp 1]
			if {[lindex $linestring $u_ix] != "-"} {
				$obj attribute_value set $u_id [lindex $linestring $u_ix]
				#echo "Method : $obj setting $u_id to [lindex $linestring $u_ix]"
			}
		}
	}
}
#
proc Build_Method_Move {} {
   	global errfp model path;
	
   	set fp [open "$path(data)/adx_transportation_inno.csv" r]
   	#set fp [open "$path(data)/adx_method_alt.csv" r]
   	gets $fp
   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		#echo "move: $linestring";
		set ProdId [lindex $linestring 0];
		set From [lindex $linestring 1];
		set To [lindex $linestring 2];
		set tRoute [lindex $linestring 3];
		set Mode [lindex $linestring 4];
		set Pref [lindex $linestring 5];
		set Cost [lindex $linestring 6];
		set Time [lindex $linestring 7];
		set TimeUOM [lindex $linestring 8];
		set effstart [lindex $linestring 9];
		set effend [lindex $linestring 10];
		set destType [lindex $linestring 11];
		set AssyLoc [lindex $linestring 12];
		set hier1 [lindex $linestring 13];
		set hier2 [lindex $linestring 14];
		set hier3 [lindex $linestring 15];
		set puCost [lindex $linestring 16];
		#
		if {$tRoute == "-"} { ; #dummy route
			set bomSuffix "$To\_$From\_$Mode";
			set transId "T_$bomSuffix";
			if {[catch {op add $transId}]} {
				op set id $transId;
			} else {
				if {$TimeUOM == "HOURS"} {
					set first [expr $Time * 3600];
				} else {
					# default is DAYS
					set first [expr $Time * 86400];
				}
				op set first $first;
				op set bor_alt "T_BORALT_MOVE";
				step_seq add $transId;
				step_seq set id $transId;
				step_seq step add 1;
				step_seq step set op $transId;
				route_segment add $transId;
				route_segment elem add $transId;
				route add $transId;
				route elem add $transId;
			}
			set mthdId [format "T_%s_%s_%s_%s" $ProdId $To $From $Mode];
			set tRoute $transId;
			set tBom [format "B_%s_%s" $ProdId $bomSuffix];
		} else {
			set tBom [format "B_%s_%s" $ProdId $tRoute];
			set mthdId [format "T_%s_%s" $ProdId $tRoute];
		}
		echo "transport:$mthdId,$tBom,$tRoute";
		if {[catch {bom add $tBom}]} {
			bom set id $tBom;
		}
		#echo "bom elem add $ProdId"
		bom elem add $ProdId;
		#echo "method add_transport $mthdId $From"
		method add_transport $mthdId $From;
		if [catch {method set bom $tBom} err] {echo "$err:method set bom $tBom"} ;# vn patch
		method set route $tRoute	
		method attribute_value set COST_DIRECT $Cost;
		method attribute_value set COST_INDIRECT 0;
		com set id $ProdId;
		set pArea [com attribute_value get PRODAREA];
		if {$pArea != "-"} {
			method attribute_value set PROD_AREA $pArea
		}
		if {$AssyLoc != "-"} {
			method attribute_value set ASSY_LOC $AssyLoc
		}
		# add method_alt elem
		if {[catch {method_alt add $ProdId@$To}]} {
			method_alt set id $ProdId@$To;
		}
		method_alt elem add $mthdId;
		#if {$pArea == "FG" && $destType == "DC" && $model(DC_MFG) == 0} {
		#	#echo "...disable method";
		#	method_alt elem set pref 0;
		#} else {
		#	method_alt elem set pref $Pref;
		#}
		method_alt elem set pref $Pref;
		# effectivity dates in date1 format
		
#		echo "!!method_alt elem set eff_start $effstart"
		if { $effstart != "-" } {
			method_alt elem set eff_start [e2d_date $effstart];
		}
		if { $effend != "-" } {
			method_alt elem set eff_end [e2d_date $effend];
		}
		method attribute_value set HIER_LEVEL_1 $hier1;
		method attribute_value set HIER_LEVEL_2 $hier2;
		method attribute_value set HIER_LEVEL_3 $hier3;
		method attribute_value set process_unit_cost $puCost;
	}
   	close $fp;
}
# obsolete
proc Build_Method_Alt {} {
   
	global errfp path
   	set fp [open "$path(data)/adx_method_alt_inno.csv" r]
   	gets $fp

   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		#echo "malt: $linestring";
		set MethAltId [lindex $linestring 0]
		set Type [lindex $linestring 1]
		set Route [lindex $linestring 4]
		set Part [lindex $linestring 5]
		set MoveId [lindex $linestring 6]
		set Pref [lindex $linestring 9]
		set Effstart [lindex $linestring 10]
		set EffEnd [lindex $linestring 11]
		set Percent [lindex $linestring 12]
		set Cost [lindex $linestring 13]

		if {[catch {method_alt add $MethAltId}]} {
			method_alt set id $MethAltId;
		}
		if {$Type == "M"} {
	   		method_alt elem add "M_$Part\_$Route"
		} else {
			method_alt elem add $MoveId
		}
	      
		if {$Pref != "-"} {
	   		method_alt elem set pref $Pref
		}
		# method_alt elem cost factor should be 1 (defualt)
		#if {$Cost != "-"} {
		#	method_alt elem set cost $Cost
		#}		
		if {$Effstart != "-"} {
		   	set dmon [lindex $Effstart 0]
		   	set dday [lindex $Effstart 1]
		   	set dyear [lindex $Effstart 2]
			set Effstart2 "$dyear/$dmon/$dday"
		   	method_alt elem set eff_start [cast date1 time $Effstart2]
		}
		if {$EffEnd != "-"} {
		   	set dmon [lindex $EffEnd 0]
		   	set dday [lindex $EffEnd 1]
		  	set dyear [lindex $EffEnd 2]
			set EffEnd2 "$dyear/$dmon/$dday"		   
  		   	method_alt elem set eff_end [cast date1 time $EffEnd2]		
         	}
		if {$Percent != "-"} {
  	   		method_alt elem set percent $Percent
		}
   	}
   	close $fp
}
#
proc Build_Route {} {

   	global path errfp

   	set fp [open "$path(data)/adx_route_inno.csv" r]
   	gets $fp

   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,];
		#echo "route:$linestring";
		set pArea [lindex $linestring 0];
		set RouteId [lindex $linestring 1];
		set SegId [lindex $linestring 2];
		set SegIx [lindex $linestring 3];
		set StepIx [lindex $linestring 4];
		set OpId [lindex $linestring 5];
		#
		catch {step_seq add $SegId};
		step_seq set id $SegId;
		step_seq step add $StepIx;
		step_seq step set op $OpId;
		catch {route_segment add $SegId};
		route_segment set id $SegId;
		if {![catch {route_segment elem add $SegId}]} {
			route_segment elem set pref 1;
		}	
		#
		if {[catch {route add $RouteId}]} {
	   		if {[catch {route set id $RouteId}]} {
	   			set msg "Route $RouteId : Invalid Route Id"
	   			puts $errfp $msg
				continue;
	   		} else {
				set msg "Route $RouteId : Route Already Exists"
	   			puts $errfp $msg
			}
		}
		if {[route elem get number] >= $SegIx} {
			route elem set ix [expr $SegIx - 1];
			if {[route elem get id] == $SegId} {
				continue;
			}
		}
	   	if {[catch {route elem add $SegId}]} {
			set msg "Route $RouteId : Invalid Route Segment $RouteSegId"
			puts $errfp $msg
	   	}
   	}
   	close $fp
}

# obsolete
#########################################################################################
#											#							
# Building Route Segment - Route Segment = Step Sequence = Operation			#
#											#
#########################################################################################
proc Build_RouteSeg {} {

   	global path errfp

   	set fp [open "$path(data)/adx_operation_inno.csv" r]
   	gets $fp

   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		set RouteSegId [lindex $linestring 0]
		route_segment add $RouteSegId
		route_segment elem add $RouteSegId
		route_segment elem set pref 1		
   	}
   	close $fp
}
#
proc Build_Operation {} {
   	global path errfp

   	set fp [open "$path(data)/adx_operation_inno.csv" r]
   	gets $fp;
   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		#
		set op [lindex $linestring 0]
		set desc [lindex $linestring 1]
		set min_wait [lindex $linestring 2]
		set max_wait [lindex $linestring 3]
		set setup [lindex $linestring 4]
		set first_batch [lindex $linestring 5]
		set first [lindex $linestring 6]
		set uph [lindex $linestring 7]
		set post [lindex $linestring 8]
		set batchscale [lindex $linestring 9]
		set yield [lindex $linestring 10]
		set yieldlossqty [lindex $linestring 11]		
		set boralt [lindex $linestring 12]
		set setup_type [lindex $linestring 13]
		set proc_type [lindex $linestring 14]
		set cap_type [lindex $linestring 15]
		set transLot [lindex $linestring 16]
		
		if {[catch {op add $op}]} {
	   		set msg "Operation - $op : Invalid Operation Id $op"
	   		puts $errfp $msg
		} else {
	   		op set desc $desc
	   		if { $min_wait != "-" } {
				op set min_wait $min_wait
	   		}
			if { $first != "-" } {
		   		op set first $first;
				if { $uph != "-" } {
					set runTime [expr 3600.0/$uph];
					op set incr $runTime;
				}
	   		} elseif {$uph != "-"} {
				set runTime [expr 3600.0/$uph ];
				op set first $runTime;
				op set incr $runTime;
	   		} else {
				op set first 0;
				op set incr 0;
			}
			#echo "first=$first,uph=$uph,[op get first],[op get incr]"
			if {$setup != "-"} {
				op set default_setup [expr $setup*3600];
			}
			if {$post != "-"} {
				op set post [expr $post*3600];
			}
			if { $yield != "-" } {
	   			op set yield $yield
	   		}
			if { $yieldlossqty != "-" } {
	   			op set yield_loss_qty $yieldlossqty
	   		}
	   		if { $max_wait != "-" } {
				op set max_wait $max_wait
	   		}
	   		if { $batchscale != "-" } {
				op set batch_scale $batchscale
	   		}
	   		if { $setup_type != "-" } {
				op set setup_type $setup_type
	   		}
			if {$cap_type != "-"} {
				op set capable_type $cap_type
			}
			if {$first_batch == "Y"} {
				op set first_batch_only yes
			}
 	   		if { $boralt != "-" } {
				if {[catch {bor_alt set id $boralt}]} {
					set msg " Operation - $op : Invalid BoR Alt Id $boralt"
	   				puts $errfp $msg
		 		} else {
					if {[catch {op set bor_alt $boralt}]} {
			   			set msg " Operation - $op : Empty BoR Alt $boralt"
	   		   			puts $errfp $msg
					}
				}
	   		}
		}
   	}
   	close $fp;
}
#
proc Build_Op_Overrides {} {
   	global path errfp
   	echo "started Build_Op_Overrides"

   	set fp [open "$path(data)/adx_op_override_inno.csv" r]
   	gets $fp
   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		echo "opoverride: $linestring";
		set op [lindex $linestring 0];
		set com [lindex $linestring 1];
		set res [lindex $linestring 2];
		set start_time [lindex $linestring 3];
		set end_time [lindex $linestring 4];
		set minWait [lindex $linestring 5];
		set maxWait [lindex $linestring 6];
		set setup [lindex $linestring 7];
		set firstBatch [lindex $linestring 8];
		set first [lindex $linestring 9];
		set uph [lindex $linestring 10];
		set post [lindex $linestring 11];
		set batchscale [lindex $linestring 12];
		set yield [lindex $linestring 13];
		set yieldlossqty [lindex $linestring 14];		
		set boralt [lindex $linestring 15];
		set setup_type [lindex $linestring 16];
		set proc_type [lindex $linestring 17];
		set cap_type [lindex $linestring 18];
		set transLot [lindex $linestring 19];
		#
		if { $op == "-" } {
			continue;
		}
 	   	op set id $op;
		if { $first != "-" } {
			set firstTime $first;
			if { $uph != "-" } {
				set runTime [expr 3600/$uph];
			} else {
				set runTime $first;
			}
		} elseif {$uph != "-"} {
			set runTime [expr 3600/$uph ];
			set firstTime $runTime;
		} else {
			set firstTime 0;
			set runTime 0;
		}
		if {$setup != "-"} {
			set Setup [expr $setup*3600];
		} else {
			set Setup 0;
		}
		if {$post != "-"} {
			set Post [expr $post*3600];
		} else {
			set Post 0;
		}
	   	if { $start_time != "-" } {
			op time_override add [cast date1 time $start_time];
			op time_override set default_setup $Setup;
			op time_override set first $firstTime;
			op time_override set incr $runTime;
			op time_override set post $Post;
			if {$yield != "-"} {
				op time_override set yield $yield;
			}
			if {$boralt != "-"} {
				op time_override set bor_alt $boralt;
			}
		}
		if { $res != "-" } {
			if {[catch {op res_override add $res}]} {
				echo "duplicate res override: $op $res";
			} else {
				op res_override set id $res;
				op res_override set default_setup $Setup;
				op res_override set first $firstTime;
				op res_override set incr $runTime;
				op res_override set post $Post;
				if {$yield != "-"} {
					op res_override set yield $yield;
				}
				if {$boralt != "-"} {
					op res_override set bor_alt $boralt;
				}
			}
		}
		if { $com != "-" } {
			if {[catch {op com_override add $com}]} {
				echo "duplicate com override: $op $com";
			} else {
				op com_override set id $com;
				op com_override set default_setup $Setup;
				op com_override set first $firstTime;
				op com_override set incr $runTime;	
				op com_override set post $Post;
				if {$yield != "-"} {
					op com_override set yield $yield;
				}
				if {$boralt != "-"} {
					op com_override set bor_alt $boralt
				}
			}
	   	}
	}
   	close $fp;
}
#
proc demo_config_method_hierarchy {} {
	echo "...demo_config_method_hierarchy";
	catch {method attribute add_string "com_HIER_LEVEL_1"};
	catch {method attribute add_string "com_HIER_LEVEL_2"};
	catch {method attribute add_string "com_HIER_LEVEL_3"};
	catch {method attribute add_string "wafer"};
	catch {method attribute add_string "bump"};
	catch {method attribute add_string "probecard"};
	catch {method attribute add_string "prober"};
	catch {method attribute add_string "assy"};
	catch {method attribute add_string "test_handler"};
	catch {method attribute add_string "test_lb"};
	catch {method attribute add_string "tester"};
	catch {method attribute add_string "other"};
	catch {method attribute add_string "Primary_Process"};
	#catch {lot attribute add_string "Package"};
	#get resGrp parameters
	#
	# populate proimary method indicator
	set maxC [com@location get number];
	for {set c_ix 0} {$c_ix < $maxC} {incr c_ix} {
		com@location set ix $c_ix;
		if {[catch {method_alt set id [com@location get method_alt]}]} {
			continue;
		}
		set primary_ix 0;
		set topPref 999999999;
		set maxM [method_alt elem get number];
		if {$maxM > 0} {
			if {$maxM > 1} {
				#echo "com=[com@location get id],m_alt=[com@location get method_alt]";
			}
			for {set m_ix 0} {$m_ix < $maxM} {incr m_ix} {
				method_alt elem set ix $m_ix;
				set cur_pref [method_alt elem get pref];
				if {$topPref > $cur_pref} {
					set topPref $cur_pref;
					set primary_ix $m_ix;
				}
				method set id [method_alt elem get id];
				method attribute_value set Primary_Process 0;
			}
			method_alt elem set ix $primary_ix;
			method set id [method_alt elem get id];
			method attribute_value set Primary_Process 1;
		}
	}
	# method hierarchy
	set maxM [method get number];
	for {set m_ix 0} {$m_ix < $maxM} {incr m_ix} {
		method set ix $m_ix;
		method attribute_value set com_HIER_LEVEL_3 [method attribute_value get HIER_LEVEL_3];
		method attribute_value set com_HIER_LEVEL_2 [method attribute_value get HIER_LEVEL_2];
		method attribute_value set com_HIER_LEVEL_1 [method attribute_value get HIER_LEVEL_1];
		if {[method get type] != "M"} {
			if {[method get type] == "T"} {
				method attribute_value set HIER_LEVEL_1 TRANSPORT;
				method attribute_value set HIER_LEVEL_2 TRANSPORT;
				method attribute_value set HIER_LEVEL_3 TRANSPORT;
			} elseif {[method get type] != "M"} {
				set mId [lindex [split [method get id] _] 1];
				method attribute_value set HIER_LEVEL_1 $mId;
				method attribute_value set HIER_LEVEL_2 $mId;
				method attribute_value set HIER_LEVEL_3 PURCHASE;
			}
			continue;
		}
		route set id [method get route];
		route elem set ix 0;
		route_segment set id [route elem get id];
		route_segment elem set ix 0;
		step_seq set id [route_segment elem get step_seq];
		set m_hl1 "";
		set pArea [method attribute_value get PROD_AREA];
		# if multiple op, last one overwrite previous
		#echo "route=[route get id], [step_seq step get number] steps";
		for {set s_ix 0} {$s_ix < [step_seq step get number]} {incr s_ix} {
			step_seq step set ix $s_ix;
			op set id [step_seq step get op];
			#if {[op get first] > 0} {}
				# get resource
				bor_alt set id [op get bor_alt];
				bor_alt elem set ix 0;
				bor set id [bor_alt elem get id];
				#echo ">>>bor=[bor get id]";
				bor elem set ix 0;
				set m_hl1 $pArea;
				#multiple res
				for {set ra_ix 0} {$ra_ix < [bor elem get number]} {incr ra_ix} {
					bor elem set ix $ra_ix;
					res_alt set id [bor elem get id];
					res_alt elem set ix 0; #to be reviewed: 1st res may not be the preferred
					set resId [res_alt elem get id];
					#echo "ra_ix=$ra_ix,resId=$resId"
					#set hl1 [format "%s_%s" $hl1 [lindex $l_resId 0]];
					res set id $resId;
					set r_hl1 [res attribute_value get HIER_LEVEL_1];
					set l_r_hl1 [split $r_hl1 _];
					#echo "m_hl1_tmp=$m_hl1_tmp,[lindex $l_r_hl1 2]"
					set m_hl1 [format "%s_%s" $m_hl1 [lindex $l_r_hl1 2]];
					#set res_hier2 [split [res attribute_value get HIER_LEVEL_2] _];
					if {[lindex $l_r_hl1 0] eq "TEST"} {
						if {[lindex $l_r_hl1 1] eq "HANDLERS"} {
							method attribute_value set test_handler $resId;
						} elseif {[lindex $l_r_hl1 1] eq "LOADBOARDS"} {
							method attribute_value set test_lb $resId;
						} elseif {[lindex $l_r_hl1 1] eq "TESTERS"} {
							method attribute_value set tester $resId;
						}
					} elseif {[lindex $l_r_hl1 0] eq "PROBE"} {
						if {[lindex $l_r_hl1 1] eq "PROBERS"} {
							method attribute_value set prober $resId;
						} elseif {[lindex $l_r_hl1 1] eq "PRPOBECARDS"} {
							method attribute_value set probecard $resId;
						}
					} else {
						method attribute_value set other $resId;
					}
				}
				#set m_hl1 [format "%s%s" $pArea $m_hl1_tmp];
			#{}
		}
		#echo "mthd=[method get id],$m_hl1"
		#set hl1 [string trimleft $hl1 "_"];
		#set hl1 [format "%s%s" [method attribute_value get HIER_LEVEL_3] $hl1];
		#method attribute_value set HIER_LEVEL_1 $m_hl1;
		#method attribute_value set HIER_LEVEL_2 $m_hl1;
		#method attribute_value set HIER_LEVEL_3 $pArea;
	}
}