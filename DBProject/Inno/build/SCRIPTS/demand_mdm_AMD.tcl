#################################################################
#								#
#	This Script File Contains the Following Procedures	#
#								#
#	Build_Demand						#
#	Create_Demand						#
#	Build_Customer						#
#	Create_Customer						#
#	Build_ATP_CTP						#
#	Create_ATP_CTP						#
#								#
#################################################################

proc Build_Demand {} {
   	global errfp path

   	set fp [open "$path(data)/adx_demand_AMD.csv" r]
   	gets $fp
	#
   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		#echo "dem:$linestring";
		set id [lindex $linestring 0]
		set desc [lindex $linestring 1]
		set cust [lindex $linestring 2]
		set status [lindex $linestring 3]
		set prio [lindex $linestring 4]
		set reqDue [lindex $linestring 5]
		set prod [lindex $linestring 7]
		set loc [lindex $linestring 8]
		set qty [lindex $linestring 9]
		set rev [lindex $linestring 12]
		set allocation [lindex $linestring 13]
		set dmSpec [lindex $linestring 14];
		set assyLoc [lindex $linestring 15];
		set demId [lindex $linestring 16];
		set wireColor [lindex $linestring 17];
      
		catch {demand add $id}
	   	if {$desc != "-" } {
			demand set desc $desc
  	   	}
	   	if {$status != "-"} {
			if {$status == 1} {
				catch {demand set status "Firm"};
			} elseif {$status == 2} {
				catch {demand set status "Plan"};
			} else {
				catch {demand set status "Plan"};
			}
	   	}
	   	if { $prio != "-" } {
			demand set prio $prio
	   	}
	   	if { $reqDue != "-" } {
			set reqDue [split $reqDue "/"]
			set month [lindex $reqDue 0]
			if {[string length $month] == "1"} {
				set month 0$month
			}
			set day [lindex $reqDue 1]
			if {[string length $day] == 1} {
				set day 0$day
			}
			set year [lindex $reqDue 2]
			set reqDue $year/$month/$day
			set reqDue [cast date1 time $reqDue]
			if {$status == "Conf"} {
				demand set due_com $reqDue
			} else {
		   		demand set due_req $reqDue
			}
	   	}
		if {$rev != "-"} {
			demand set revenue $rev
	   	}
		# temporary for lacking customer csv
		if {$cust != "-"} {
			if {[catch {customer set id $cust}]} {
				customer add $cust;
				set hierList [split $cust _];
				customer attribute_value set HIER_LEVEL_3 [lindex $hierList 0];
				customer attribute_value set HIER_LEVEL_2 [format "%s_%s" [lindex $hierList 0] [lindex $hierList 1]];
				customer attribute_value set HIER_LEVEL_1 $cust;
			}
			demand set customer $cust;
		}
		# end customer
		#if {$fabloc != "-"} {
		#	demand attribute_value set FAB_LOC $fabloc
	   	#}
	   	#if {$bumploc != "-"} {
		#	demand attribute_value set BUMP_LOC $bumploc
	   	#}
	   	#if {$probeloc != "-"} {
		#	demand attribute_value set PROBE_LOC $probeloc
	   	#}
	   	#if {$dbloc != "-"} {
		#	demand attribute_value set DB_LOC $dbloc
	   	#}
	   	if {$assyLoc != "-"} {
			demand attribute_value set ASSY_LOC_S $assyLoc
	   	}
	   	#if {$testloc != "-"} {
		#	demand attribute_value set TEST_LOC_S $testloc
	   	#}
		if {$demId != "-"} {
			demand attribute_value set DEMAND_ID_S $demId;
		}
	   	if {$wireColor != "-"} {
			demand attribute_value set WIRE_COLOR_S $wireColor;
	   	}
		#
 		demand elem set ix 0
		demand elem set com@location $prod\@$loc
	  	#if {$grade != "-" && $grade > 1} {
	   	   	demand elem set grade 1
		#}
		if { $qty != "-" } {
		   	demand elem set qty $qty
		}
   	}
   	close $fp;
}

proc Build_Customer {} {

	global data_path error_path
	global errfp path

	#set fp [open "$data_path/customer.csv" r]
	#set errfp [open "$error_path/model_clean.err" a]
	set fp [open "$path(data)/ADEXA_DEMAND6.csv" r]
	#parse_fields $fp "Create_Customer"

	gets $fp

	while {[gets $fp linestring] > 0} {
		#echo $linestring
		set linestring [split $linestring ,]

		set id [lindex $linestring 0]
		set descr [lindex $linestring 1]
		set pref [lindex $linestring 2]
		set hier_1_1_customer [lindex $linestring 3]
		set hier_1_2_bus_seg [lindex $linestring 4]

		customer add $id
		customer set desc $descr
		if {$hier_1_1_customer != "-"} {
			customer attribute_value set HIER_1_1_Customer $hier_1_1_customer
		}
		if {$hier_1_1_business_segment != "-"} {
               customer attribute_value set HIER_1_1_Business_Segment $hier_1_2_bus_seg
            }

       }
       customer set id _default
       customer attribute_value set HIER_1_1_Customer "_default"
       customer attribute_value set HIER_1_1_Business_Segment "All Customers"

	close $errfp
	close $fp

}

proc Create_Customer { linestring index} {

	global errfp
	global loc_id

	set customer [lindex $linestring 0]
	set customerGrp [lindex $linestring 1]

	catch {customer add $customer}
	catch {cust_grp add $customerGrp}
	catch {cust_grp elem add $customer}

}

proc Build_ATP_CTP {} {


	global data_path

echo "DATAPATH == $data_path"
	set fp [open "$data_path/ATP_CTP.csv" r]
	parse_fields $fp "Create_ATP_CTP"

	close $fp

}


proc Create_ATP_CTP { linestring index} {

	global loc_id

	set CTPIndex [lindex $linestring 0]
	set parent [lindex $linestring 1]
	set child [lindex $linestring 2]
	set location [lindex $linestring 3]
	
	catch {bom add BoM_$CTPIndex$parent}
	bom set id BoM_$CTPIndex$parent
	catch {bom elem add $child}
	catch {bom elem set rate 1}
	method add_convert $CTPIndex$parent\_$location $location
	method set id $CTPIndex$parent\_$location
	method set bom BoM_$CTPIndex$parent

#added to set method_alt to that of the parent inventory
#echo $parent
#echo $location
	com@location set id [format "%s_%s" $location $parent]
#echo "here..... [com@location get id]"
	set method_alt [inv get method_alt]
	method_alt set id $method_alt
#end changes

	method_alt elem add $CTPIndex$parent\_$location
	method_alt elem set pref 0

}


