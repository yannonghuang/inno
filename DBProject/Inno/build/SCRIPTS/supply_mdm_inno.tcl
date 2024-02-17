#############################################################
#									#
#	This Script File Contains the Following Procedures	        #
#									#
#	Build_Die_Supply							#
#									#
#############################################################


proc Import_Supply {} {
	global errfp path

   	set fp [open "$path(data)/adx_supply_inno.csv" r]
   	gets $fp
   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,];
		#echo "supply:$linestring";
		set sup_id [lindex $linestring 0]
		set vendor [lindex $linestring 2]
		set loc [lindex $linestring 3]
		set part [lindex $linestring 4]
		set sup_due [lindex $linestring 5]
		set qty [lindex $linestring 6]
		set status [lindex $linestring 7]
		set pMethod [lindex $linestring 8];
		set Cost [lindex $linestring 9];
		set fabLoc [lindex $linestring 10];
		set lot [lindex $linestring 12];
		set assyLoc [lindex $linestring 23];
		set testLoc [lindex $linestring 24];
		set dmSpec [lindex $linestring 25];
		set demId [lindex $linestring 26];
		set wireColor [lindex $linestring 27];
		set prodArea [lindex $linestring 28];
		set invAlloc [lindex $linestring 29];
  
  
		set com_loc $part@$loc
		#set com_loc $part\@$loc		
		#echo "...part=$part,loc=$loc";		
		#echo "...sup_id=$sup_id,com_loc=$com_loc";
		supply add $sup_id
		supply set com@location $com_loc
		supply set status $status
		supply set qty $qty
		if {$pMethod != "-"} {
			supply set method $pMethod;
		}
		if {$Cost != "-"} {
			supply set cost $Cost;
		}
		if {$lot != "-"} {
			supply attribute_value set LOT_ID $lot	
		}
		if {$fabLoc != "-"} {
			supply attribute_value set FAB_LOC $fabLoc;
		}
		if {$assyLoc != "-"} {
			supply attribute_value set ASSY_LOC $assyLoc;
		}
		if {$testLoc != "-"} {
			supply attribute_value set TEST_LOC $testLoc;
		}
		if {$dmSpec != "-"} {
			supply attribute_value set DM_SPEC $dmSpec;
		}
		#if {$demId != "-"} {
		#	supply attribute_value set DEMAND_ID $demId;
		#}
		if {$wireColor != "-"} {
			supply attribute_value set WIRE_COLOR $wireColor;
		}
		if {$prodArea != "-"} {
			supply attribute_value set PROD_AREA $prodArea;
		}
		if {$invAlloc != "-"} {
			supply attribute_value set ALLOCATION $invAlloc;
		}
		#
		if {$sup_due != "-"} {
			#set split_dt [split $sup_due /]
			#set month [lindex $split_dt 0]
			#if {[string length $month] == "1"} {
			#	set month 0$month
			#}
			#set day [lindex $split_dt 1]
			#if {[string length $day] == 1} {
			#	set day 0$day
			#}
			#set year [lindex $split_dt 2]
			#set adexa_dt $year/$month/$day
			#supply set time [cast date1 time $adexa_dt]
			supply set time [cast date1 time $sup_due]
		} else {
			supply set time [cal horizon get start]
		}
   	}
	close $fp
}

