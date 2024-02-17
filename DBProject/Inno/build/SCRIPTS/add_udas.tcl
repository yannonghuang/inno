proc add_uda {} {

#UDAs from test.data

	com@location attribute add_cost product_unit_cost
	com@location attribute add_cost process_unit_cost
	
	constraint attribute add_string root_cause_count
	constraint attribute add_string first_late_demand
	
	demand attribute add_string root_cause
	
	lot attribute add_string root_cause_count
	lot attribute add_string first_late_demand
	lot attribute add_float p_calculated_product_unit_cost
	lot attribute add_cost product_unit_cost
	lot attribute add_cost process_unit_cost
	
	res attribute add_string root_cause_count
	res attribute add_string first_late_demand

	supply attribute add_string root_cause_count
	supply attribute add_string first_late_demand
	supply attribute add_string UserNote
	supply attribute add_integer UserFlag
	supply attribute add_float p_calculated_product_unit_cost
	supply attribute add_cost product_unit_cost
	supply attribute add_cost process_unit_cost

	
#UDAs for SFS 	
	    
	lot attribute add_integer sequence_order
	lot attribute add_string sequence_determined
	
#UDAs for Hierarchies	
	com attribute add_string HIER_LEVEL_1
	com attribute add_string HIER_LEVEL_2
	com attribute add_string HIER_LEVEL_3
	com attribute add_string FG_HIER_LEVEL_1
	com attribute add_string FG_HIER_LEVEL_2
	com attribute add_string FG_HIER_LEVEL_3
	com attribute add_string PROD_AREA

	com attribute add_float END_ITEM
	com attribute set END_ITEM max 1
	
	com@location attribute add_string HIER_LEVEL_1
	com@location attribute add_string HIER_LEVEL_2
	com@location attribute add_string HIER_LEVEL_3
	com@location attribute add_string FG_HIER_LEVEL_1
	com@location attribute add_string FG_HIER_LEVEL_2
	com@location attribute add_string FG_HIER_LEVEL_3
	com@location attribute add_string PROD_AREA
	com@location attribute add_float END_ITEM
	
	customer attribute add_string HIER_LEVEL_1
	customer attribute add_string HIER_LEVEL_2
    customer attribute add_string HIER_LEVEL_3

	location attribute add_string HIER_LEVEL_1
	location attribute add_string HIER_LEVEL_2
	location attribute add_string HIER_LEVEL_3

	method attribute add_string HIER_LEVEL_1
	method attribute add_string HIER_LEVEL_2
	method attribute add_string HIER_LEVEL_3

#	method attribute add_string LOC_ID
#	method attribute add_string LOC_1
#	method attribute add_string LOC_2
#	method attribute add_string LOC_3

	res attribute add_string HIER_LEVEL_1
	res attribute add_string HIER_LEVEL_2
	res attribute add_string HIER_LEVEL_3

	supply attribute add_string HIER_LEVEL_1
	supply attribute add_string HIER_LEVEL_2
	supply attribute add_string HIER_LEVEL_3

	com@location attribute add_string PURCHASE
	com@location attribute add_string SIZE
	com@location attribute add_string COLOUR

#UDAs for product configuration 

	method attribute add_string SIZE
	method attribute add_string COLOUR	
	
	demand attribute add_string SIZE
	demand attribute add_string COLOUR
	
	supply attribute add_string SIZE	
	supply attribute add_string COLOUR

    lot attribute add_string SIZE
	lot attribute add_string COLOUR

#	lot attribute add_string SAFETY_USAGE
#	lot attribute add_string BLEND	
#	lot attribute add_string POSITION
#	lot attribute add_string LOC_1
#	lot attribute add_string LOC_2
#	lot attribute add_string LOC_3
}
#
global path
set fp [open "$path(data)/ADEXA_UDA_SETTINGS.txt" w]
puts $fp UDA_SETTINGS
close $fp
#
proc importUDAs {dataobj headstring} {
	
	global path;
	set ulist { }
	for {set i 0} {$i < [llength $headstring]} {incr i} {
		set headername [lindex $headstring $i]
		set headertmp [split $headername _];
		echo ">>>>>> headertmp=$headertmp";
		if {[lindex $headertmp 0] == "UDA"} {
			set fp [open "$path(data)/ADEXA_UDA_SETTINGS.txt" a];
			set utype [lindex $headertmp 1]

			set udirection [lindex $headertmp 2]
			if {$udirection == "to"} {
				set udirection [lindex $headertmp 2]_[lindex $headertmp 3]
				set udefault [lindex $headertmp 4]
			} else {
				set udefault [lindex $headertmp 3]
			}
			set uname [regsub UDA_$utype\_$udirection\_$udefault\_ $headername ""];
			echo ">>>>>> uname=$uname";
			
			catch {$dataobj attribute add_$utype $uname}
			#$dataobj attribute add_$utype $uname
			puts $fp "Adding $dataobj attribute called $uname of type $utype"
			echo "Adding $dataobj attribute called $uname of type $utype"
			
			if {$utype == "float"} {
				$dataobj attribute set $uname max 999999
				$dataobj attribute set $uname min 0
			}
			if {$utype == "cost"} {
				$dataobj attribute set $uname max 999999
				$dataobj attribute set $uname min 0
			}
			if {$udirection != "-"} {
				puts $fp "$dataobj attribute set $uname propagation_direction $udirection"
			}
			if {$udefault != "-"} {
				puts $fp "$dataobj attribute set $uname propagate_default_value $udefault"
			}
			lappend ulist $i:$uname
			close $fp
		}
	}
	return $ulist
}