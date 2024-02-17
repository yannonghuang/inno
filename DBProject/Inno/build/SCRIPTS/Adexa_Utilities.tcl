#***************************************
#
# Name: Benson Yeh
# Date: May 1, 2011
#
# Purpose: General Utilities required for RTOPS scripts
#
#***************************************

global path
global scriptpath
global datapath
global reportpath
global logfile
global casepath

proc scp_log {message} {

	global path
	global scriptpath
	global datapath
	global reportpath
	global logfile

	### Add to Log file
	set fp [open $logfile a]
	puts $fp $message
	close $fp

} ; #end of scp_log

proc Turn_Display {on_off_flag} {
	
	#display update $on_off_flag
	problem update $on_off_flag
	connect $on_off_flag
	lot sort $on_off_flag
	com@location explosion $on_off_flag
	
} ; #end of Turn_Display

#***************************************
#
# Name: Benson Yeh
# Date: Sept 23, 2011
#
# Purpose: Create a version number based on current time
#***************************************
proc Get_Software_Version {} {
	

	if {[software scp] == "yes"} {
		set app "SCP"
	} ; #scp check
	if {[software pp] == "yes"} {
		set app "PP"
	} ; #scp check
	#if {[software sfs] == "yes"} {
	#	set app "SFS"
	#} ; #scp check

	set ver [software version]	
	set ver [string range $ver 8 [string length $ver]]
	set ver [split $ver "."]
	set ver [join $ver ""]

	set result "$app$ver"

	return $result

} ; #end of Get_Version_Number

#***************************************
#
# Name: Benson Yeh
# Date: June 23, 2011
#
# Purpose: Create a version number based on current time
#***************************************
proc Get_Version_Number {} {
	
	set time_counter [misc unix_time]
	set cur_time [cast time date3 $time_counter]
	echo $cur_time
        set cur_list [split $cur_time " "]
        set cur_date [lindex $cur_list 0]
        set cur_time [lindex $cur_list 1]
	#echo "DATE: $cur_date   TIME: $cur_time"
        set cur_date_list [split $cur_date "/"]
        set yy [lindex $cur_date_list 0]
        set mm [lindex $cur_date_list 1]
        set dd [lindex $cur_date_list 2]
	#echo "YR: $yy  MTH: $mm DAY: $dd"
        set cur_time_list [split $cur_time ":"]
	set hh [lindex $cur_time_list 0]
	set mn [lindex $cur_time_list 1]
	set ss [lindex $cur_time_list 2]
	set result "20$yy$mm$dd$hh$mn$ss"
	return $result

} ; #end of Get_Version_Number
#***************************************
#
# Name: Benson Yeh
# Date: June 23, 2011
#
# Purpose: Plan Cleanup Tools
#***************************************

proc Delete_Planned_Lots {} {

	Delete_Lots "not_started"

} ; #end of Delete_Planned_Lots

proc Delete_Fixed_Lots {} {

	Delete_Lots "fixed"

} ; #end of Delete_fixed_Lots

proc Delete_Lots {status} {

	planner unsched all
	
	### loop through lot info
	set idx 0
	while {$idx < [lot get number]} {
		lot set ix $idx
		if {[lot get status] == $status} {
			lot delete [lot get id]
		} else {
			incr idx
		} ; #end of lot status check		
	} ; #end of while loop thru lots
} ; #end of Delete_Lots


proc Delete_Planned_Supplies {} {
	
	### loop through supply info
	set idx 0
	while {$idx < [supply get number]} {
		supply set ix $idx
		if {[supply get status] == "p"} {
			supply delete [supply get id]
		} else {
			incr idx
		} ; #end of supply status check		
	} ; #end of while loop thru supply
} ; #end of Delete_Planned_Supplies

proc Delete_Lots {status} {

	planner unsched all
	
	### loop through lot info
	set idx 0
	while {$idx < [lot get number]} {
		lot set ix $idx
		if {[lot get status] == $status} {
			lot delete [lot get id]
		} else {
			incr idx
		} ; #end of lot status check		
	} ; #end of while loop thru lots
} ; #end of Delete_Lots

proc Identify_Lots_and_Supplies_without_Demands {} {

	catch {lot attribute add_string DEMAND_EXIST}
	catch {supply attribute add_string DEMAND_EXIST}
	
	set used_inv_list [Get_ALL_Used_Inv]
	
	### loop through supply info
	set sup_max [supply get number]
	for {set sup_ix 0} {$sup_ix < $sup_max} {incr sup_ix} {
		supply set ix $sup_ix
		set sup_id [supply get id]
		echo "Evaluating SUPPLY for demand: $sup_id"
		set sup_inv [supply get inv]
		if {[lsearch $used_inv_list $sup_inv] == -1} {
			echo "No Demand Supply: [supply get id]"
			supply attribute_value set "DEMAND_EXIST" "Y"
		} else {
			supply attribute_value set "DEMAND_EXIST" "N"
		} ; #end if lsearch supply		
	} ; #end of for loop thru supplies

	### loop through lot info
	set lot_max [lot get number]
	for {set lot_ix 0} {$lot_ix < $lot_max} {incr lot_ix} {
		lot set ix $lot_ix
		set lot_id [lot get id]
		echo "Evaluating LOT for demand: $lot_id"
		set lot_inv [lot get inv]
		if {[lsearch $used_inv_list $lot_inv] == -1} {
			echo "No Demand WIP: [lot get id]"
			lot attribute_value set "DEMAND_EXIST" "Y"
		} else {
			lot attribute_value set "DEMAND_EXIST" "N"
		} ; #end if lsearch lot		
	} ; #end of for loop thru lots	
	
} ; #end of Identify_Lots_and_Supplies_without_Demands

proc Delete_Lots_and_Supplies_without_Demands {} {
	
	set used_inv_list [Get_ALL_Used_Inv]
	
	### loop through supply info
	set idx 0
	while {$idx < [supply get number]} {
		supply set ix $idx
		echo "Evaluating SUPPLY: [supply get id]"
		set inv_id [supply get inv]
		if {[lsearch $used_inv_list $inv_id] == -1} {
			echo "Deleting [supply get id]"
			supply delete [supply get id]
		} else {
			incr idx
		} ; #end of supply status check		
	} ; #end of while loop thru supply

	planner unsched all
	
	### loop through lot info
	set idx 0
	while {$idx < [lot get number]} {
		lot set ix $idx
		set inv_id [lot get inv]
		if {[lsearch $used_inv_list $inv_id] == -1 && [lot get status] != "in_process"} {
			echo "Deleting [lot get id]"
			lot delete [lot get id]
		} else {
			incr idx
		} ; #end of lot status check		
	} ; #end of while loop thru lots
} ; #end of Delete_Lots_and_Supplies_without_Demands

#***************************************
#
# Name: Benson Yeh
# Date: June 23, 2011
#
# Purpose: Object Information Tools
#***************************************
proc Get_Inv_with_Demands {} {

	set inv_list ""

	set dem_max [demand get number]
	for {set dem_ix 0} {$dem_ix < $dem_max} {incr dem_ix} {
		demand set ix $dem_ix
		set dem_inv [demand get inv]
		if {[lsearch $inv_list $dem_inv] == -1} {
			lappend inv_list $dem_inv
		} ; #end of check inv_list
	} ; #end of for loop thru demands
	return $inv_list
} ; #end of Get_Inv_with_Demands 

#***************************************
#
# Name: Benson Yeh
# Date: Sept 23, 2011
#
# Purpose: Retrieve all used inv in supply chain (recursive) for a given inv_id
#***************************************
proc Get_Used_Inv_List {inv_id} {
	set mat_list ""

	inv set id $inv_id
	set metalt_id [inv get method_alt]
	
	method_alt set id $metalt_id
	set metalt_elem_max [method_alt elem get number]
	for {set metalt_elem_ix 0} {$metalt_elem_ix < $metalt_elem_max} {incr metalt_elem_ix} {
		method_alt set id $metalt_id
		method_alt elem set ix $metalt_elem_ix
		set method_id [method_alt elem get id]
		method set id $method_id

		set met_type [method get type]
		if {$met_type == "P"} {
			continue
		} ; #end of method type check
		
		set loc_id [method get location]		
		set bom_id [method get bom]
		
		if {$bom_id == "-"} {
			continue
		} ; #end of catch		
	
		bom set id $bom_id
		set bom_max [bom elem get number]
		for {set bom_ix 0} {$bom_ix < $bom_max} {incr bom_ix} {

			bom set id $bom_id
			bom elem set ix $bom_ix
			set com_id [bom elem get id]
			set bom_inv "$com_id@$loc_id"
			if {[lsearch $mat_list $bom_inv] == -1} {
				lappend mat_list $bom_inv
				set upstream_list [Get_Used_Inv_List $bom_inv]
				set mat_list [concat $mat_list $upstream_list]
			} ; #end of lsearch
		} ; #end of loop thru BOM
	} ; #end of loop thru method alt elements
	
	set result [Lunique $mat_list]
	return $result
} ;#end of Get_Used_Inv_List

#***************************************
#
# Name: Benson Yeh
# Date: Sept 23, 2011
#
# Purpose: Retrieve all used inv in supply chain for all inv with demands
#***************************************

proc Get_ALL_Used_Inv {} {
	
	set demand_inv_list [Lunique [Get_Inv_with_Demands]]
	
	set used_inv_list ""
	set deminv_max [llength $demand_inv_list]
	for {set ix 0} {$ix < $deminv_max} {incr ix} {
		set demand_inv [lindex $demand_inv_list $ix]
		
		echo "Evaluating #: $ix out of $deminv_max :: INV: $demand_inv"
		lappend used_inv_list $demand_inv
		set dem_inv_used_list [Get_Used_Inv_List $demand_inv]
		set used_inv_list [Lunique [concat $used_inv_list $dem_inv_used_list]]
	} ; #end for thru demand_inv
	
	return $used_inv_list
	
} ; #end of Get_ALL_Used_Inv

#***************************************
#
# Name: Benson Yeh
# Date: June 23, 2011
#
# Purpose: Object Verification Tools
#***************************************
proc Verify_Com {com_id} {

	set result 0

	if {[catch {com set id $com_id}] == 0} {
		set result 1
	} ; #end of if
	
	return $result

} ; #end of procedure Verify_Com

proc Verify_BOM {bom_id} {

	set result 0

	if {[catch {bom set id $bom_id}] == 0} {
		set result 1
	} ; #end of if
	
	return $result

} ; #end of procedure Verify_BOM

proc Verify_Inv {inv_id} {

	set result 0

	if {[catch {inv set id $inv_id}] == 0} {
		set result 1
	} ; #end of if
	
	return $result

} ; #end of procedure Verify_BOM

#***************************************
#
# Name: Benson Yeh
# Date: June 29, 2011
#
# Purpose: Parsing tools
#***************************************
proc Get_Prod_from_Method {met_id} {

	set prod_id "-"

	method set id $met_id
	set m_txt [string range $met_id 3 [string length $met_id]]
	set m_last [expr [string first "_" $m_txt] - 1]
	set prod_id [string range $m_txt 0 $m_last]
	return $prod_id

} ; #end of procedure Get_Prod_from_Method

proc Get_Prod_from_Com {com_id} {

	set prod_id "-"

	com set id $com_id
	set c_last [expr [string last "_" $com_id] - 1]
	set prod_id [string range $com_id 0 $c_last]
	return $prod_id

} ; #end of procedure Get_Prod_from_Com

proc Get_Type_from_Com {com_id} {

	set type_id "-"

	com set id $com_id
	set c_last [expr [string last "_" $com_id] + 1]
	set type_id [string range $com_id $c_last [string length $com_id]]
	return $type_id

} ; #end of procedure Get_Prod_from_Com

proc ConvertTimeToDate {u_date} {

	set s_date "20[cast time date3 $u_date]"

	return $s_date	
} ; #end 

#***************************************
#
# Name: Benson Yeh
# Date: May 6, 2011
#
# Purpose: Enter a commidity id and find an appropriate BOG (first)
# Assumes: Assumes BOG description field will have commodity
# Note:       
#***************************************
proc Get_Com_BOG {com_id} {

	set bog_list "-"

	### Loop thru BOGs 
	set bog_max [bog get number]
	for {set bog_ix 0} {$bog_ix < $bog_max} {incr bog_ix} {
		bog set  ix $bog_ix
		set bog_id [bog get id]
		set bog_desc [bog get desc]
		if {$com_id == $bog_desc} {
			lappend bog_list $bog_id	
		} ; #end of bog check	
	} ; #end of for stmt thru bogs

	return $bog_list

} ; #end of procedure Get_Com_BOG



#***************************************
#
# Name: Benson Yeh
# Date: June 29, 2011
#
# Purpose: List tools
#***************************************
proc Lmatch {list1 list2} {

	set result 1

	set L1 [lsort $list1]
	set L2 [lsort $list2]

	set m1 [llength $L1]
	set m2 [llength $L2]

	if {$m1 == $m2} {
		for {set ix 0} {$ix < $m1} {incr ix} {
			set t1 [lindex $L1 $ix]
			set t2 [lindex $L2 $ix]
			if {$t1 != $t2} {
				set result 0
			}
		} ; #end of for
	} else {
		set result 0
	} ; #end of max check
	return $result

} ; #end of procedure Lamtch

proc Lunique {input_list} {

	set output_list ""
	
	foreach item $input_list {
		if {[lsearch $output_list $item] == -1} {
			lappend output_list $item	
		}	
	}
		
	return $output_list

} ; #end of procedure Lamtch


#***************************************
#
# Name: Benson Yeh
# Date: June 29, 2011
#
# Purpose: Creation Tools
#***************************************
proc Create_Firm_Supply {sup_id sdesc inv_id sqty sdate} {

	supply add $sup_id
	supply set desc $sdesc
	supply set status "f"
	supply set com@location $inv_id
	supply set qty $sqty
	supply set time $sdate

} ; #end of procedure Create_Firm_Supply


#***************************************
#
# Name: Benson Yeh
# Date: August 1, 2011
#
# Purpose: Math Tools
#***************************************

proc Round_Down {val rounder} {
       set nval [expr floor($val*$rounder) /$rounder]
       return $nval
} ; #end of procedure Round_Down

#***************************************
#
# Name: Benson Yeh
# Date: October 4, 2011
#
# Purpose: Data Tools - converts null to blank string
#***************************************
proc Check_Null {args} {
    if {[llength $args] == 0} then {
       set arg ""
    } elseif {[llength $args] == 1} then {
       set arg [lindex $args 0]
    } else {
       error "Wrong # args: foo ?arg?"
    }
    return $arg
} ; #end of Check_Null

#***************************************
#
# Name: Benson Yeh
# Date: August 1, 2011
#
# Purpose: UDS Tools
#***************************************

proc LOAD_UDS_MODEL {model_id with_sfs error_log} {

	#set model_id "DGSCP"
	uds opendb MS_SQL $model_id apsdbo apsdbo
	uds case_id set _bas
	uds validate schema
	uds errors_allowed set 10000000
	uds log_file set_name $error_log
	if {$with_sfs == "Y"} {
		uds load all
	} else {
		uds load
	} ; #end of sfs check
	
	uds closedb

} ; #end of procedure LOAD_UDS_MODEL

proc uds_load_DISCP {{ver 0}} {

	global path
	global logpath
	
	set path d:/RTAPS
	set logpath $path/log
	set udslogpath $logpath/uds
	
	if {$ver == 0} {
		set ver_number [Get_Version_Number]
	} else {
		set ver_number $ver
	} ; #end of if ver check
	
	set udslogfile "$udslogpath/DISCP_udslog_$ver_number.txt"
	
	LOAD_UDS_MODEL DISCP Y $udslogfile
	
} ; #end of uds_load_DISCP

proc uds_load_DGSCP {{ver 0}} {

	global path
	global logpath
	
	set path d:/RTAPS
	set logpath $path/log
	set udslogpath $logpath/uds
	
	if {$ver == 0} {
		set ver_number [Get_Version_Number]
	} else {
		set ver_number $ver
	} ; #end of if ver check
	
	set udslogfile "$udslogpath/DGSCP_udslog_$ver_number.txt"
	
	LOAD_UDS_MODEL DGSCP N $udslogfile
	
} ; #end of uds_load_DGSCP


#***************************************
#
# Name: Benson Yeh
# Date: October 1, 2011
#
# Purpose: SFS Tools
#***************************************

proc Count_Resources_by_loc {loc_id} {

	set max [res get number]
	set count 0
	for {set ix 0} {$ix < $max} {incr ix} {
		res set ix $ix
		set res_loc [res get location]
		if {$loc_id == $res_loc} {
			incr count
		} ; #end of if
	} ; #end of loop

	return $count
} ; #end of Count_SFS_Resources

proc Count_SFS_Resources {} {

	set max [res get number]
	set count 0
	for {set ix 0} {$ix < $max} {incr ix} {
		res set ix $ix
		set is_chosen [res get is_chosen]
		if {$is_chosen == 1} {
			incr count
		} ; #end of if
	} ; #end of loop

	return $count
} ; #end of Count_SFS_Resources

proc Count_SFS_Bottlenecks {} {

	set max [res get number]
	set count 0
	for {set ix 0} {$ix < $max} {incr ix} {
		res set ix $ix
		set is_bottleneck [res get is_bottleneck]
		if {$is_bottleneck == 1} {
			incr count
		} ; #end of if
	} ; #end of loop

	return $count
} ; #end of Count_SFS_Bottlenecks


proc Show_SFS_Res_Activity {res_id} {

	res set id $res_id
	set act_num [res sfsact get number]
	echo "TOTAL ACTS: $act_num"
	for {set act_ix 0} {$act_ix < $act_num} {incr act_ix} {
		res sfsact set ix $act_ix
		if {[catch {sfsact get type}] != 0} {
			set type "no activity"
		} else {
			set type [sfsact get type]
		} ; #end of type check
		echo "ACT#: $act_ix  TYPE: $type"
	
	} ; #end of for stmt

} ; #end of Show_SFS_Res_Activity

proc Get_Resources_Used_by_Lots_List {} {

	set res_list ""
	set lot_max [lot get number]
	for {set lot_ix 0} {$lot_ix < $lot_max} {incr lot_ix} {
		lot set ix $lot_ix
		set lot_id [lot get id]
		set temp_list [Get_Resources_Used_by_Lot $lot_id]
		set res_list [concat $res_list $temp_list]
	} ; #end of lot loop
	set res_list [Lunique $res_list]
	return $res_list
} ; #end of Get_Resources_Used_by_Lots_List

proc Get_Resources_Used_by_Lot {lot_id} {

	set res_list ""
	lot set id $lot_id
	set lot_inv [lot get inv]
	set lot_route [lot get route]
	route set id $lot_route
	set rt_max [route elem get number]
	for {set rt_ix 0} {$rt_ix < $rt_max} {incr rt_ix} {
		route elem set ix $rt_ix
		set rs_id [route elem get id]
		route_segment set id $rs_id
		set rs_max [route_segment elem get number]
		for {set rs_ix 0} {$rs_ix < $rs_max} {incr rs_ix} {
			route_segment elem set ix $rs_ix
			set ss_id [route_segment elem get step_seq]
			step_seq set id $ss_id
			set ss_max [step_seq step get number]
			for {set ss_ix 0} {$ss_ix < $ss_max} {incr ss_ix} {
				step_seq step set ix $ss_ix
				set op_id [step_seq step get op]
				op set id $op_id
				set bora_id [op get bor_alt]
				set temp_list [Get_Resource_List_from_BORALT $bora_id]
#scp_log "LOTID: $lot_id ROUTE: $lot_route ROUTE_SEG: $rs_id STEPSEQ: $ss_id OP: $op_id BORA: $bora_id"				
#scp_log "STD RES LIST: $temp_list"
				set res_list [concat $res_list $temp_list]
				### check overrides
				set com_list [Get_ComOverrides_List_from_Op $op_id]
#scp_log "OP OVERRIDE COM LIST: $com_list"
				com@location set id $lot_inv
				set com_id [inv get commodity]
				if {[lsearch $com_list $com_id] != -1} {
					op com_override set id $com_id
					set bora_id [op com_override get bor_alt]
					set tmp_list [Get_Resource_List_from_BORALT $bora_id]
#scp_log "OVR RES LIST: $tmp_list"
					set res_list [concat $res_list $tmp_list]
				} ; #end of catch op override
			} ; #end of loop thru step seq
		} ; #end of loop thru route segment
	} ; #end loop thru route elem
	set res_list [Lunique $res_list]
	return $res_list
} ; #end of Get_Resources_Used_by_Lot

proc Get_Resource_List_from_BORALT {bora_id} {

	set res_list ""
	bor_alt set id $bora_id
	set bora_max [bor_alt elem get number]
	for {set bora_ix 0} {$bora_ix < $bora_max} {incr bora_ix} {
		bor_alt elem set ix $bora_ix
		set bor_id [bor_alt elem get id]
		bor set id $bor_id
		set bor_max [bor elem get number]
		for {set bor_ix 0} {$bor_ix < $bor_max} {incr bor_ix} {
			bor elem set ix 0
			set ra_id [bor elem get id]
			res_alt set id $ra_id
			set ra_max [res_alt elem get number]
			for {set ra_ix 0} {$ra_ix < $ra_max} {incr ra_ix} {
				res_alt elem set ix $ra_ix
				set res_id [res_alt elem get id]
				#echo "RES: $res_id"
				lappend res_list $res_id
			} ; #end loop thru res_alt
		} ; #end loop thtru bor
	} ; #end loop thru bor_alt	
	
	return $res_list
} ; #end of Get_Resource_List_from_BORALT


 proc Get_ComOverrides_List_from_Op {op_id} {
 
	set com_list ""
	op set id $op_id
	set max [op com_override get number]
	for {set ix 0} {$ix < $max} {incr ix} {
		op com_override set ix $ix
		set com_id [op com_override get id]
		lappend com_list $com_id
	} ; #end of for loop
	return $com_list
 } ; #end of Get_ComOverrides_List_from_Op

proc Turn_off_Inactive_Resources {} {

	set max [res get number]
	for {set ix 0} {$ix < $max} {incr ix} {
		res set ix $ix
		set res_id [res get id]
		res set is_chosen 0
		if {[res act get number] > 0} {
			res set is_chosen 1
		} ; #end of if range
	} ; #end of for loop

} ; #end of Turn_off_Inactive_Resources

#***************************************
#
# Name: Benson Yeh
# Date: October 1, 2011
#
# Purpose: Model Cleanup Tools
#***************************************
proc Delete_Unused_ComLocations {keep_location_list} {
	
	set inv_max [inv get number]
	set inv_delete_list ""
	for {set inv_ix 0} {$inv_ix < $inv_max} {incr inv_ix} {
		inv set ix $inv_ix
		set inv_id [inv get id]
		set inv_loc [inv get location]
		if {[lsearch $keep_location_list $inv_loc] == -1} {
			lappend inv_delete_list $inv_id
		} ; #end of if lsearch
	} ; #end of loop thru inv
	
	set count 0
	foreach inv_id $inv_delete_list {
	echo "Deleting INV: $inv_id"
		inv delete $inv_id
		incr count
	} ; #end of foreach stmt
	
	scp_log "Deleted $count com@locations."
} ; #end of Delete_Unused_ComLocations

proc Delete_Unused_MethodAltGroups {} {
	
	set mag_delete_list ""
	set mag_max [method_alt get number]
	for {set mag_ix 0} {$mag_ix < $mag_max} {incr mag_ix} {
		method_alt set ix $mag_ix
		set mag_id [method_alt get id]
		set ref [method_alt referenced_by com@location get number]
		if {$ref == 0} {
			lappend mag_delete_list $mag_id
		} ; #end of ref chck
	} ; #end of for loop
	
	set count 0
	foreach mag_id $mag_delete_list {
	echo "Deleting MAG: $mag_id"
		method_alt delete $mag_id
		incr count
	} ; #end of foreach stmt
	
	scp_log "Deleted $count Method Alternative Groups."	
	
} ; #end of Delete_Unused_MethodAltGroups 

proc Delete_Unused_Methods {} {
	
	set met_delete_list ""
	set met_max [method get number]
	for {set met_ix 0} {$met_ix < $met_max} {incr met_ix} {
		method set ix $met_ix
		set met_id [method get id]
		set ref [method referenced_by method_alt get number]
		if {$ref == 0} {
			lappend met_delete_list $met_id
		} ; #end of ref chck
	} ; #end of for loop
	
	set count 0
	foreach met_id $met_delete_list {
	echo "Deleting METHOD: $met_id"
		method delete $met_id
		incr count
	} ; #end of foreach stmt
	
	scp_log "Deleted $count Methods."	
	
} ; #end of Delete_Unused_Methods

proc Delete_Unused_Routes {} {
	
	set delete_list ""
	set max [route get number]
	for {set ix 0} {$ix < $max} {incr ix} {
		route set ix $ix
		set route_id [route get id]
		set ref [route referenced_by method get number]
		if {$ref == 0} {
			lappend delete_list $route_id
		} ; #end of ref chck
	} ; #end of for loop
	
	set count 0
	foreach route_id $delete_list {
	echo "Deleting ROUTE: $route_id"
		route delete $route_id
		incr count
	} ; #end of foreach stmt
	
	scp_log "Deleted $count Routes."	
	
} ; #end of Delete_Unused_Routes

proc Delete_Unused_RouteSegments {} {
	
	set delete_list ""
	set max [route_segment get number]
	for {set ix 0} {$ix < $max} {incr ix} {
		route_segment set ix $ix
		set route_ss_id [route_segment get id]
		set ref [route_segment referenced_by route get number]
		if {$ref == 0} {
			lappend delete_list $route_ss_id
		} ; #end of ref chck
	} ; #end of for loop
	
	set count 0
	foreach routeseg_id $delete_list {
	echo "Deleting ROUTE SEGMENT: $routeseg_id"
		route_segment delete $routeseg_id
		incr count
	} ; #end of foreach stmt
	
	scp_log "Deleted $count Route Segments."	
	
} ; #end of Delete_Unused_RouteSegmentss

proc Delete_Unused_StepSequences {} {
	
	set delete_list ""
	set max [step_seq get number]
	for {set ix 0} {$ix < $max} {incr ix} {
		step_seq set ix $ix
		set ss_id [step_seq get id]
		set ref [step_seq referenced_by route_segment get number]
		if {$ref == 0} {
			lappend delete_list $ss_id
		} ; #end of ref chck
	} ; #end of for loop
	
	set count 0
	foreach ss_id $delete_list {
	echo "Deleting STEP SEQUENCE: $ss_id"
		step_seq delete $ss_id
		incr count
	} ; #end of foreach stmt
	
	scp_log "Deleted $count Step Sequences."	
	
} ; #end of Delete_Unused_StepSequences

proc Delete_Unused_Operations {} {
	
	set delete_list ""
	set max [op get number]
	for {set ix 0} {$ix < $max} {incr ix} {
		op set ix $ix
		set op_id [op get id]
		set ref [op referenced_by step_seq get number]
		if {$ref == 0} {
			lappend delete_list $op_id
		} ; #end of ref chck
	} ; #end of for loop
	
	set count 0
	foreach op_id $delete_list {
	echo "Deleting OPERATION: $op_id"
		op delete $op_id
		incr count
	} ; #end of foreach stmt
	
	scp_log "Deleted $count Operations."	
	
} ; #end of Delete_Unused_Operations

proc Delete_Unused_BORALTS {} {
	
	set delete_list ""
	set max [bor_alt get number]
	for {set ix 0} {$ix < $max} {incr ix} {
		bor_alt set ix $ix
		set bora_id [bor_alt get id]
		set ref [bor_alt referenced_by op get number]
		if {$ref == 0} {
			lappend delete_list $bora_id
		} ; #end of ref chck
	} ; #end of for loop
	
	set count 0
	foreach bora_id $delete_list {
	echo "Deleting BOR_ALT: $bora_id"
		bor_alt delete $bora_id
		incr count
	} ; #end of foreach stmt
	
	scp_log "Deleted $count BOR Alternatives."	
	
} ; #end of Delete_Unused_BORALTS


proc Delete_Unused_BORs {} {
	
	set delete_list ""
	set max [bor get number]
	for {set ix 0} {$ix < $max} {incr ix} {
		bor set ix $ix
		set bor_id [bor get id]
		set ref [bor referenced_by bor_alt get number]
		if {$ref == 0} {
			lappend delete_list $bor_id
		} ; #end of ref chck
	} ; #end of for loop
	
	set count 0
	foreach bor_id $delete_list {
	echo "Deleting BOR: $bor_id"
		bor delete $bor_id
		incr count
	} ; #end of foreach stmt
	
	scp_log "Deleted $count BORs."	
	
} ; #end of Delete_Unused_BORs

proc Delete_Unused_RESALTS {} {
	
	set delete_list ""
	set max [res_alt get number]
	for {set ix 0} {$ix < $max} {incr ix} {
		res_alt set ix $ix
		set resa_id [res_alt get id]
		set ref [res_alt referenced_by bor get number]
		if {$ref == 0} {
			lappend delete_list $resa_id
		} ; #end of ref chck
	} ; #end of for loop
	
	set count 0
	foreach resa_id $delete_list {
	echo "Deleting RES_ALT: $resa_id"
		res_alt delete $resa_id
		incr count
	} ; #end of foreach stmt
	
	scp_log "Deleted $count Resource Alternatives."	
	
} ; #end of Delete_Unused_RESALTS

proc Delete_Unused_Resources {} {
	
	set delete_list ""
	set max [res get number]
	for {set ix 0} {$ix < $max} {incr ix} {
		res set ix $ix
		set res_id [res get id]
		set ref [res referenced_by res_alt get number]
		if {$ref == 0} {
			lappend delete_list $res_id
		} ; #end of ref chck
	} ; #end of for loop
	
	set count 0
	set save_count 0
	foreach res_id $delete_list {
	echo "Deleting Resource: $res_id"
		res delete $res_id
		incr count
		incr save_count
	} ; #end of foreach stmt

	if {$save_count == 1000} {
		filepm save_with_rds d:/rtaps/case/rtsfs1020_CP.data
		set save_count 0
	} ; #end of save count chck	

	scp_log "Deleted $count Resources."	
	
} ; #end of Delete_Unused_Resources

proc Delete_Unused_Resources_for_SFS {} {
	
	set max [res get number]
	set res_list ""
	for {set ix 0} {$ix < $max} {incr ix} {
		res set ix $ix
		set res_id [res get id]
		lappend res_list $res_id 
	} ; #end of for loop

	set count 0
	foreach res_id $res_list {
		if {[catch {res delete $res_id}] != 0} {
			continue
		} ; #end of catch
		incr count
	} ; #end of for loop	
	
	scp_log "Deleted $count Resources."	
	
} ; #end of Delete_Unused_Resources_for_SFS

proc Verify_LOT_Capable_Type {lot_id} {
	
	lot set id $lot_id
	set lot_method [lot get method]
	set lot_inv [lot get inv]
	inv set id $lot_inv
	set lot_com [inv get commodity]
	set lot_route [lot get route]

} ; #end of Verify_LOT_Capable_Type


proc Get_Ops_Used_by_Lot {lot_id} {

	set res_list ""
	lot set id $lot_id
	scp_log "Evaluating LOT ID: $lot_id"
	set lot_inv [lot get inv]
	set lot_route [lot get route]
	route set id $lot_route
	set rt_max [route elem get number]
	for {set rt_ix 0} {$rt_ix < $rt_max} {incr rt_ix} {
		route elem set ix $rt_ix
		set rs_id [route elem get id]
		route_segment set id $rs_id
		set rs_max [route_segment elem get number]
		for {set rs_ix 0} {$rs_ix < $rs_max} {incr rs_ix} {
			route_segment elem set ix $rs_ix
			set ss_id [route_segment elem get step_seq]
			step_seq set id $ss_id
			set ss_max [step_seq step get number]
			for {set ss_ix 0} {$ss_ix < $ss_max} {incr ss_ix} {
				step_seq step set ix $ss_ix
				set op_id [step_seq step get op]
				op set id $op_id
				scp_log "DEFAULT OP: $op_id CAPABLE TYPE: [op get capable_type]"
				

			} ; #end of loop thru step seq
		} ; #end of loop thru route segment
	} ; #end loop thru route elem
	set res_list [Lunique $res_list]
	return $res_list
} ; #end of Get_Ops_Used_by_Lot

#***************************************
#
# Name: Benson Yeh
# Date: November 11, 2011
#
# Purpose: Search Tools
# Assume RT_OUT final demand spot
#***************************************
proc Get_Where_Used_FG_List {orig_inv} {

	set answer ""
	set inv_list ""
	inv set id $orig_inv
	set orig_loc [inv get location]
	
	### return empty list if inv provided is already demand location 
	if {$orig_loc != "RT_OUT"} {
		#echo "EVALUATING: $orig_inv"
		set orig_com [inv get commodity]
		com set id $orig_com
		set bom_max [com referenced_by bom get number]
		for {set bom_ix 0} {$bom_ix < $bom_max} {incr bom_ix} {
			com set id $orig_com
			com referenced_by bom set ix $bom_ix
			set bom_id [com referenced_by bom get id]
			bom set id $bom_id
			set met_max [bom referenced_by method get number]
			for {set met_ix 0} {$met_ix < $met_max} {incr met_ix} {
				bom set id $bom_id
				bom referenced_by method set ix $met_ix
				set met_id [bom referenced_by method get id]
				method set id $met_id
				set ma_max [method referenced_by method_alt get number]
				for {set ma_ix 0} {$ma_ix < $ma_max} {incr ma_ix} {
					method set id $met_id
					set method_loc [method get location]
					if {$method_loc  != $orig_loc} {
						continue
					} ; #end loc check
					method referenced_by method_alt set ix $ma_ix
					set ma_id [method referenced_by method_alt get id]
					method_alt set id $ma_id
					set inv_max [method_alt referenced_by com@location get number]
					for {set inv_ix 0} {$inv_ix < $inv_max} {incr inv_ix} {
						method_alt set id $ma_id
						method_alt referenced_by com@location set ix $inv_ix
						set inv_id [method_alt referenced_by com@location get id]
						inv set id $inv_id
						set inv_loc [inv get location]
						if {$inv_loc == "RT_OUT"} {
							#echo "Found FG: $inv_id"
							lappend inv_list $inv_id
						} else {
							#echo "Search for FG from: $inv_id"
							set fg_list [Get_Where_Used_FG_List $inv_id]
							set inv_list [concat $inv_list $fg_list]
							set inv_list [Lunique $inv_list]
						} ; #end of inv RT_OUT check 						
					} ; #end if inv loop 
				} ; #end of method_alt loop
			} ; #end of method loop
		} ; #end of for M3tment thru bom number
		set answer $inv_list
	} ; #end of if RTOUT check
	return $answer

} ; #end of Get_Where_Used_FG_List


proc Find_No_Demand_Supply_and_WIP {} {
	
	set supply_list ""
	set sup_max [supply get number]
	for {set sup_ix 0} {$sup_ix < $sup_max} {incr sup_ix} {
		supply set ix $sup_ix
		set sup_id [supply get id]
		set sup_inv [supply get inv]
		set fg_list [Get_Where_Used_FG_List $sup_inv]
		set num_demands 0
		foreach fg_id $fg_list {
			inv set id $fg_id
			set demand_number [com@location demand get number]
			set num_demands [expr $num_demands + $demand_number]
		} ; #end foreach thru fglist
		if {$num_demands == 0} {
			lappend supply_list $sup_id
		} ; #end of numdemands check
	} ; #end of lot loop
	
	set lot_list ""
	set lot_max [lot get number]
	for {set lot_ix 0} {$lot_ix < $lot_max} {incr lot_ix} {
		lot set ix $lot_ix
		set lot_id [lot get id]
		set lot_inv [lot get inv]
		set fg_list [Get_Where_Used_FG_List $lot_inv]
		set num_demands 0
		foreach fg_id $fg_list {
			inv set id $fg_id
			set demand_number [com@location demand get number]
			set num_demands [expr $num_demands + $demand_number]
		} ; #end foreach thru fglist
		if {$num_demands == 0} {
			lappend lot_list $lot_id
		} ; #end of numdemands check				
	} ; #end of lot loop

	set answer ""
	lappend answer $supply_list
	lappend answer $lot_list
	return $answer
} ; #end of Find_No_Demand_Supply_and_WIP

proc Delete_Lots_and_Supplies_without_Demands_New {} {
	
	set result [Find_No_Demand_Supply_and_WIP]
	set supply_list [lindex $result 0]
	set lot_list [lindex $result 1]
	
	### loop through supply info
	foreach sup_id $supply_list {
		echo "Deleting supply: $sup_id"
		supply delete $sup_id
	} ; #end of foreach thru supplies

	planner unsched all
	### loop through lot info
	foreach lot_id $lot_list {
		echo "Deleting lot: $lot_id"
		lot delete $lot_id
	} ; #end of foreach thru lots
	
	echo "Deleted [llength $supply_list] supplies."
	echo "Deleted [llength $lot_list] WIP."

	#scp_log "Deleted [llength $supply_list] supplies."
	#scp_log "Deleted [llength $lot_list] WIP."
	
} ; #end of Delete_Lots_and_Supplies_without_Demands_New


proc Add_Dummy_Route {} {

	res add R_DUMMY
	res set care 0
	res set location Default
	res attribute_value set HIER_1_2_RES_GROUP Default
	res_alt add RA_DUMMY
	res_alt elem add R_DUMMY
	bor add BOR_DUMMY
	bor elem add RA_DUMMY
	bor_alt add BORA_DUMMY
	bor_alt elem add BOR_DUMMY
	op add OP_DUMMY
	op set bor_alt BORA_DUMMY
	op set first 0.0
	step_seq add SS_DUMMY
	step_seq step add 10
	step_seq step set op OP_DUMMY
	route_segment add RS_DUMMY
	route_segment elem add SS_DUMMY
	route add GENERIC
	route elem add RS_DUMMY

} ; #end of Add_Dummy_Route


