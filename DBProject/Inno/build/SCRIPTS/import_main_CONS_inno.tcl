#Note path change when migrated!
#source c:/Adexa/projects/innolight/Chris/SCP/SCRIPTS/import_main_CONS_inno.tcl
##############################################################################
##
##	 Model Building Template
##
##############################################################################

proc set_FG_hierarchy {} {
	set maxCom [com@location get number];
	for {set c_ix 0} {$c_ix < $maxCom} {incr c_ix} {
		com@location set ix $c_ix;
		if {[com attribute_value get PROD_AREA] == "TEST"} {
			com set type F;
			com attribute_value set FG_HIER_LEVEL_3 [com attribute_value set HIER_LEVEL_3];
			com attribute_value set FG_HIER_LEVEL_2 [com attribute_value set HIER_LEVEL_2];
			com attribute_value set FG_HIER_LEVEL_1 [com attribute_value set HIER_LEVEL_1];
		} else {
			com attribute_value set FG_HIER_LEVEL_3 "Not FG";
			com attribute_value set FG_HIER_LEVEL_2 "Not FG";
			com attribute_value set FG_HIER_LEVEL_1 "Not FG";
		}
	}
}
#
proc run {} {
	global path errfp;
	global fdate ftime;

	filepm new;
	#tk_cube_disable_auto_update
	Initialize;
	set tcl_precision 17
	Import_MDM;	

}

proc SAVE_run {} {
	global path errfp;
	global fdate ftime;

	filepm new;
	#tk_cube_disable_auto_update
	Initialize;
	set tcl_precision 17
	Import_MDM;	
	
#model_error_check {{include_severity {high medium}} {maximum_error_count 10000}}
set num [constraint get number]
for {set i 0} {$i < $num} {incr i} {constraint set ix $i; constraint set enabled 0}
#demand delete all; supply delete all; demand add 1; demand set inv 280-1806@TH_CB
#demand delete all; supply delete all; demand add 1; demand set inv 260-0199@TH_OB
#demand delete all; supply delete all; demand add 1; demand set qty 1000; demand set inv 500-4292@TL_MOD


#return "MODEL OK"	
	
	#
	SetPlannerModes;
	set_modes;
	#
	#filepm save ./data/FABLESS_CONS_UNSOLVED_MODEL_V70620\_$fdate\_$ftime.data
	BalanceAndSched
	#
	

	
	
	postSolve;
	#Rebuild Cube Reports
	tk_cube_model_init
	#filepm save ./data/FABLESS_CONS_SOLVED_MODEL_V70620\_$fdate\_$ftime.data
	#filepm save c:/adexa/demos/non_integrated/fabless/scp/cases/FABLESS_CONS2_SOLVED_MODEL_VERSION41_TCL.data
    #source $path(script)/std_export_scripts.tcl;
	#Save model back to the database
	#save_model_constrained

	#Save report measures
	#demo_export_main_rpt
}

#
proc add_UDAs {} {

    #demand attribute add_string ASSY_LOC_S; #in adx_uda
    #lot attribute add_string ASSY_LOC_S; #in adx_uda
    #lot attribute add_string ASSY_LOC; #in adx_uda
    #method attribute add_string ASSY_LOC; #in adx_uda
    #supply attribute add_string ASSY_LOC; #in adx_uda

    demand attribute add_string TESTLOC_S
    lot attribute add_string TESTLOC_S
    lot attribute add_string TESTLOC
    method attribute add_string TESTLOC
    supply attribute add_string TESTLOC

    #demand attribute add_string DEMAND_ID_S
    #lot attribute add_string DEMAND_ID_S
    #lot attribute add_string DEMAND_ID
    #method attribute add_string DEMAND_ID
    #supply attribute add_string DEMAND_ID

    #demand attribute add_string CUST_ID
    #lot attribute add_string CUST_ID
    #lot attribute add_string CUSTOMER_ID
    #method attribute add_string CUSTOMER_ID
    #supply attribute add_string CUSTOMER_ID

    method attribute add_string WIRE_COLOR
    supply attribute add_string WIRE_COLOR
    lot attribute add_string WIRE_COLOR
	lot attribute add_string WIRE_COLOR_S
	demand attribute add_string WIRE_COLOR_S

    supply attribute add_string PROD_AREA
}
#
proc Initialize {} {
	global path errfp logfile model fdate ftime;
	global datasrc uname pword load_tables constrained_solve_tables unconstrained_solve_tables

	#set path(main) "c:/Adexa/demos/NON_INTEGRATED/FABLESS/SCP";
# vn	
	#set path(main) "c:/Adexa/projects/innolight/SCP";	
	set path(main) "w:";		
	#set path(main) "c:/Adexa/Innolight/SCP";

	set path(data) "$path(main)/DATA";
	#set path(data) "$path(main)/DATA-full";
	#set path(data) "$path(main)/DATA-aos";
	set path(constraint_data) "$path(main)/DATA_CONSTRAINTS";
	set path(error) "$path(main)/LOGS";
	set path(script) "$path(main)/SCRIPTS";
	set logfile $path(error)/scp_log.txt;
	#
    set datasrc adx12
    set uname MDM_FAB_UDS; #adx_scp_uds
    set pword demo321
    #set load_tables _SOP
    set constrained_solve_tables _FABLESS
	#
    set fdate [clock format [clock seconds] -format {%Y%m%d}]
    set ftime [clock format [clock seconds] -format {%H%M}]

	# Model parameters
	set model(solver) "scp";
	# was 4/3/17-10/3/17
	#set model(horizon_start) "2017/07/09 00:00:00";
	#set model(horizon_end) "2018/07/15 00:00:00";
	set model(DC_MFG) 0;
	set model(DC_PO) 1;

############

#	source $path(script)/data_transform_inno.tcl;
#   Transform_BOM
#	echo CHECK!; xxx
############

	source $path(script)/model_tool.tcl;
	#
    source $path(script)/add_udas.tcl
	source $path(script)/Adexa_Utilities.tcl
	source $path(script)/calendar_mdm_inno.tcl
	#source $path(script)/holidays_mdm.tcl
	source $path(script)/create_per_mgr_inno.tcl
	source $path(script)/resource_mdm_inno.tcl
	source $path(script)/process_mdm_inno.tcl
	source $path(script)/product_mdm_inno.tcl
	source $path(script)/bom_mdm_inno.tcl
	#source $path(script)/customers_mdm.tcl
	#Supply for AMD demo
	source $path(script)/supply_mdm_inno.tcl
	#Demand for AMD demo
	#source $path(script)/demand_mdm_AMD.tcl
	source $path(script)/demand_mdm_inno.tcl
	source $path(script)/uda_mdm.tcl
	#source $path(script)/import_constraints.tcl
    #source $path(script)/comloc_grades_mdm.tcl
    #source $path(script)/bog_mdm.tcl
    #source $path(script)/boc_mdm.tcl
    source $path(script)/script_util.tcl;
    #source $path(script)/wip_mdm_inno.tcl
    #source $path(script)/safety_stock_mdm.tcl
    #Solve Script for AMD model
    source $path(script)/solve_model.tcl;
}
#
proc Import_MDM {} {
	global path errfp model;

	filepm new
	set start [filepm unix_time]
	set errfp [open "$path(error)/Model_Log.txt" w]
	catch {location add Default}

	echo "Model Building starting.............................[cast time date3 $start]"
	puts $errfp "Model Building starting.............................[cast time date3 $start]"

	#########################################################################
	# These Procedures can be found in the uda_mdm.tcl script  		#
	#########################################################################
	echo "	Build UDAs......................................................"
	Build_UDA;
	add_UDAs;

	#########################################################################
	# These Procedures can be found in the calendar_mdm.tcl script  	#
	#########################################################################
	#echo "	Build Horizon..................................................."
	#Build_Horizon
	echo "   Build Period Managers ........................................."
	Build_Period_Managers
	#return;
	echo "   Build Capacity Patterns........................................"
	Build_Capacity_Patterns
	echo "   Build CFIs....................................................."
	Build_CFI
	if {$model(solver) == "scp"} {
		echo "   Build Locations................................................"
		Build_Locations
	}
	echo "   Build ProdArea................................................."
	Build_ProdArea;

	#########################################################################
	# These Procedures can be found in the resource_mdm.tcl script 		#
	#########################################################################
	echo "   Build Resources................................................"
	Build_Resources
	echo "   Build ResCapInter.............................................."
	Build_ResCapInter;
	#echo "   Build ResCapExc................................................"
	#Build_ResCapExc;
	echo "   Build Resource Alternatives...................................."
	Build_Resource_Alt_Groups
	echo "   Build Bill-of-Resources........................................"
	Build_Bill_of_Resource
	echo "   Build Bill-of-Resource Alternatives..........................."
	Build_BoR_Alternatives
	#echo "   Adding Holidays................................................"
	#Import_Holidays

	#########################################################################
	# These Procedures can be found in the process_mdm.tcl script  		#
	#########################################################################
	echo "   Build Operations..............................................."
	Build_Operation
	#echo "   Build Step Seq................................................."
	#Build_Step_Seq
	#echo "   Build Route Segment............................................"
	#Build_RouteSeg
	echo "   Build Route...................................................."
	Build_Route

	#########################################################################
	# This Procedure can be found in the product_mdm.tcl script   		#
	#########################################################################
	echo "   Build Products................................................."
	Build_Product;
	Build_ComLoc;

	#########################################################################
	# These Procedures can be found in the bom_mdm.tcl script 	        #
	#########################################################################
	echo "   Build Bill of Materials........................................."
	Import_BOM
	#echo "   Build Bill of Grades............................................"
	#Build_BOG
	#echo "   Build Comloc Grades............................................."
	#Build_Comloc_Grades
	#Build_BOC

	#########################################################################
	# These Procedures can be found in the process_mdm.tcl script 	        #
	#########################################################################
	#catch {method attribute add_string HIER_LEVEL_1};
	#catch {method attribute add_string HIER_LEVEL_2};
	#catch {method attribute add_string HIER_LEVEL_3};
	#catch {method attribute add_cost process_unit_cost};
	echo "   Build Purchase Methods.........................................."
	Build_Vendor;
	Build_Purchase_Method
	echo "   Build Manufacturing Methods....................................."
	Build_Method_Make
	echo "   Build Transportation Methods...................................."
	#Build_Operation_Move
	Build_Method_Move
	#echo "   Build Method Alternatives......................................."
	#Build_Method_Alt
	echo "   Connect MethAlt to Product......................................"
	Connect_MethAlt_to_Product
	echo "   Build Op Overrides.............................................."
	Build_Op_Overrides;
	#############################################################
	#Add Method for Die Wire Color - Renasis Demo
	#adhocMethods;
	
	###################################################################
	# This Procedure can be found in the Import_Supply.tcl script ##
	###################################################################
	#echo "   Build WIP Information....................................... "
	#Import_Workorder
	echo "   Build Supply Information.................................... "
	Import_Supply

	###################################################################
	# This Procedure can be found in the Import_Demand.tcl script ##
	###################################################################
	#Import_Customers
	echo "   Build Demand................................................ "
	Build_Customer;
	Build_Demand;
	###################################################################
	# This procedure can be found in the import_safety_stock.tcl script
	###################################################################
	echo "   Build Safety Stock.......................................... "
	#Import_Safety_Stock
	#echo "   Build inv PerMgrs........................................... "
	#Create_Inv_PerMgrs

	#############################################################
	#Add GradeDecomposition Example - Renasis Demo
	#adhocData;

	# fix lot size multiples
	#correct_lot_sizes;
	#
	#demo_config_products;
	# method hierarchy
	### demo_config_method_hierarchy; #vng remove
	# PSI Group
	#if {$model(DC_MFG) == 1} {
	#	demo_set_PSIGroup;
	#}

	#for {set d 0} {$d < [demand get number]} {incr d} {
	#	demand set ix $d
	#	set dID [demand get id]
	#	set dmdID [demand attribute_value get DEMAND_ID_S]
	#	if {$dmdID == "-"} {
	#		demand attribute_value set DEMAND_ID_S "$dID;FREE"
	#	}
	#}
	#
	#set_FG_hierarchy;
	##model_adjustment;
	#
	# Add Propagation Settings
	#add_propogation; #merged into set_modes

	#fix customer hierarchy
	#for {set c_ix 0} {$c_ix < [customer get number]} {incr c_ix} {
	#	customer set ix $c_ix;
	#	customer attribute_value set HIER_LEVEL_1 CUSTOMER;
	#	customer attribute_value set HIER_LEVEL_2 CUSTOMER;
	#}

	#filepm save ./data/demoConstraint.data;
	#constraint set id _default;
	###################################################################
	#Import Matching Constraints
	###################################################################
	#config_constraint "GFG";
	config_constraint "*";
	#constraint set id _default;
	# set graybox constraints
	#source ./tcl/java/tool_core_demo.tcl
	#source ./tcl/java/tool_constraints.tcl
	source $path(script)/tool_constraints_demo.tcl
    echo "Before Greybox";
	#toolGenerateStartsConstraints "$path(data)/adx_graybox.csv"; #when using tool_constraints_demo.tcl
	#tool_generate_starts_constraints_demo "$path(data)/adx_graybox-newui.csv"; #when using tool_constraints.tcl
	tool_generate_starts_constraints_demo "$path(data)/adx_graybox_inno.csv"; #when using tool_constraints.tcl	
	echo "After Greybox";
	# can only run after aggregation model initialized
	#echo "   Add Product Unit Cost.........................................."
	#demo_set_product_unit_cost;
	#echo ""
	set end [filepm unix_time]
	echo "Model Building Ending...............................[cast time date3 $end]"
	set seconds [expr $end - $start]
	echo "Total duration Lasting..............................[cast time dur_sec $seconds]"

	close $errfp
	#update_gui on
}
#
proc adhocMethods {} {
	#method attribute add_string WIRE
	#supply attribute add_string WIRE
	#lot attribute add_string WIRE
	#lot attribute add_string WIRE_S
	#demand attribute add_string WIRE_S

	method set id M_ASM3_ASSY-M2_ASM3
	method attribute_value set WIRE_COLOR "OTHER"
	echo "Adding Method M2 GOLD"
	method add_manufacture M_ASM3_ASSY-M2_ASM3_GOLD
	method set location ASSY-M2
	method set bom ASM3
	method set route ASSY-M2
	method attribute_value set ASSY_LOC "ASSY-M2"
	method attribute_value set WIRE_COLOR "GOLD"
	method attribute_value set PROD_AREA "ASSY"
	method_alt set id ASM3@ASSY-M2
	echo "Adding Method M2 COPPER"
	method add_manufacture M_ASM3_ASSY-M2_ASM3_COPPER
	method set location ASSY-M2
	method set bom ASM3
	method set route ASSY-M2
	method attribute_value set ASSY_LOC "ASSY-M2"
	method attribute_value set WIRE_COLOR "COPPER"
	method attribute_value set PROD_AREA "ASSY"
	method_alt set id ASM3@ASSY-M2
	#
	method_alt set id ASM3@ASSY-M2
	method_alt elem add M_ASM3_ASSY-M2_ASM3_COPPER
	method_alt elem add M_ASM3_ASSY-M2_ASM3_GOLD
	method_alt elem set ix 0
	method_alt elem delete [method_alt elem get id]

	method set id M_ASM3_ASSY-M3_ASM3
	method attribute_value set WIRE_COLOR "OTHER"
	echo "Adding Method M3 GOLD"
	method add_manufacture M_ASM3_ASSY-M3_ASM3_GOLD
	method set location ASSY-M3
	method set bom ASM3
	method set route ASSY-M3
	method attribute_value set ASSY_LOC "ASSY-M3"
	method attribute_value set WIRE_COLOR "GOLD"
	method attribute_value set PROD_AREA "ASSY"
	method_alt set id ASM3@ASSY-M3
	echo "Adding Method M3 COPPER"
	method add_manufacture M_ASM3_ASSY-M3_ASM3_COPPER
	method set location ASSY-M3
	method set bom ASM3
	method set route ASSY-M3
	method attribute_value set ASSY_LOC "ASSY-M3"
	method attribute_value set WIRE_COLOR "COPPER"
	method attribute_value set PROD_AREA "ASSY"
	method_alt set id ASM3@ASSY-M3

	method_alt set id ASM3@ASSY-M3
	method_alt elem add M_ASM3_ASSY-M3_ASM3_COPPER
	method_alt elem add M_ASM3_ASSY-M3_ASM3_GOLD
	method_alt elem set ix 0
	method_alt elem delete [method_alt elem get id]
}
#
proc adhocData {} {
	lot set id WIP-12
	lot attribute_value set GradeDecomposition "1, 85000;2, 10000;3, 5000"
	lot grade_decomposition set

	lot add WIP-GRADES
	lot set inv DIE1@ASSY-M2
	lot set qty 1000
	lot set status waiting_after
	lot attribute_value set GradeDecomposition "1, 800;2, 150;3, 50"
	lot grade_decomposition set
	lot set due [cal horizon get start]
	#
	for {set i 0} {$i < [inv get number]} {incr i} {
		inv set ix $i
		inv set replenish_period 30
	}
}
#
proc correct_lot_sizes {{mode fix}} {
	echo ">>>>> correct_lot_sizes";
	set methodCount 0;
	set comLocCount 0;
	set object "method";
	set methodCount [fix_obj_lot_sizes $object];
	set object "com@location";
	set comLocCount [fix_obj_lot_sizes $object];
	echo "total methods checked: $methodCount";
	echo "total com@location checked: $comLocCount";
	echo "<<<<< correct_lot_sizes";
}
#
proc fix_obj_lot_sizes {object {mode fix}} {
	set verb "please change";
	if { $mode eq "fix" } {
		set verb "changing";
	}
	set errorCount_max 0;
	set errorCount_standard 0;
	set errorCount_min 0;
	set errorCount_incr 0;
	set objCount 0;
	set object_number [$object get number];
	for { set object_ix [expr $object_number - 1] } { $object_ix >= 0 } { incr object_ix -1 } {
		$object set ix $object_ix;
		#if {[string first "1045285_D598416@1017" [$object get id]] < 0} {
		#	continue;
		#}
		#echo "$object-[$object get id] started";
		set objID [$object get id];
		incr objCount;
		set skip_lots_fix 0;
		if {[$object get max_lot] == "-"} {
			#echo "----->,$objID,max_lot empty";
			#$object set max_lot 99999999;
			set skip_lots_fix 1;
		} else {
			set max_lot [expr {int([$object get max_lot])}];
		}
		if {[$object get standard_lot] == "-"} {
			#echo "----->,$objID,standard_lot empty";
			#set standard_lot $max_lot;
			#333$object set standard_lot $max_lot;
			set skip_lots_fix 1;
		} else {
			set standard_lot [expr {int([$object get standard_lot])}];
		}
		if {[$object get min_lot] == "-"} {
			#echo "----->,$objID,min_lot empty";
			#set min_lot 1;
			#$object set min_lot 1
			set skip_lots_fix 1;
		} else {
			set min_lot [expr {int([$object get min_lot])}];
		}
		if {[$object get incr_lot] == "-"} {
			#echo "----->,$objID,incr_lot empty";
			#set incr_lot 1;
			#$object set incr_lot 1;
			set skip_lots_fix 1;
		} else {
			set incr_lot [expr {int([$object get incr_lot])}];
			if {$incr_lot eq 0} {
				echo "----->,$objID,incr_lot = 0";
				set incr_lot 1;
				$object set incr_lot 1;
			}
		}
		if {$skip_lots_fix} {
			continue;
		}
		#echo "...fix $object lot size:[$object get id]-min/incr/max/std:[format \"%.0f,%.0f,%.0f,%.0f\"\
		#	$min_lot $incr_lot $max_lot $standard_lot]";
		set modulo [expr int($incr_lot)];
		# temporary fix
		if {$standard_lot > $max_lot} {
			echo "----->,$objID,standard_lot > max_lot";
			set standard_lot $max_lot;
			$object set max_lot 9999999;
		}
		if {$min_lot > $standard_lot} {
			echo "----->,$objID,min_lot > standard_lot";
			set min_lot $standard_lot;
		}
		#echo "...fix min/incr/max/std: $min_lot $incr_lot $max_lot $standard_lot";
		$object set min_lot 1;
		#echo "min set";
		$object set standard_lot 1;
		#echo "std set";
		$object set max_lot 99999999;
		#echo "max set";
		$object set standard_lot $standard_lot;
		$object set max_lot $max_lot;
		$object set min_lot $min_lot;
		# now check for multiples
		if { $max_lot eq "-" || [expr int($max_lot) % $modulo] != 0 } {
			set increaseSize 1;
			set new_max_lot [expr $modulo * ($increaseSize + (int($max_lot) / $modulo))];
			if { $mode eq "fix" } {
				$object set max_lot $new_max_lot;
			}
			if { $increaseSize } {
				echo "----->,$objID,max_lot not multiple of $modulo $verb from $max_lot to $new_max_lot";
			} else {
				echo "----->,$objID,max_lot not multiple of $modulo $verb from - to $new_max_lot";
			}
			incr errorCount_max;
		}
		#echo "standard_lot=$standard_lot,modulo=$modulo";
		if { $standard_lot eq "-" || [expr int($standard_lot) % $modulo] != 0 } {
			set increaseSize 1;
			if { $standard_lot eq "-" } {
				set standard_lot $new_max_lot;
				if { [expr int($standard_lot) % $modulo] == 0 } {
					set increaseSize 0;
				}
			}
			set new_standard_lot [expr $modulo * ($increaseSize + (int($standard_lot) / $modulo))];
			if { $mode eq "fix" } {
				$object set standard_lot $new_standard_lot;
			}
			if { $increaseSize } {
				echo "----->,$objID,standard_lot not multiple of $modulo $verb from $standard_lot to $new_standard_lot";
			} else {
				echo "----->,$objID,standard_lot not multiple of $modulo $verb from - to $new_standard_lot";
			}
			incr errorCount_standard;
		}
		if { $min_lot eq "-" || [expr int($min_lot) % $modulo] != 0 } {
			set increaseSize 1;
			set new_min_lot [expr $modulo * ($increaseSize + (int($min_lot) / $modulo))];
			if { $mode eq "fix" } {
				$object set min_lot $new_min_lot;
			}
			if { $increaseSize } {
				echo "----->,$objID,min_lot not multiple of $modulo $verb from $min_lot to $new_min_lot";
			} else {
				echo "----->,$objID,min_lot not multiple of $modulo $verb from - to $new_min_lot";
			}
			incr errorCount_min;
		}
		if {$object == "method" && [method get type] == "P"} {
			if {[$object get max_supply] < [$object get min_lot]} {
				echo "----->method,$objID,max_supply < min_lot";
				$object set max_supply [$object get min_lot];
			}
		}
		#echo "$object-[$object get id] completed";
	}
	if { $errorCount_max || $errorCount_standard || $errorCount_min || $errorCount_incr } {
		echo "max_lot errors: $errorCount_max";
		echo "standard_lot errors: $errorCount_standard";
		echo "min_lot errors: $errorCount_min";
		echo "incr_lot errors: $errorCount_incr";
	}
	return $objCount;
}
#
proc postSolve {} {
	catch {supply attribute add_string "KIT_ALERT"};
	#
	set alertThreshold [expr 7 * 86400];
	for {set s_ix 0} {$s_ix < [supply get number]} {incr s_ix} {
		supply set ix $s_ix;
		if {[supply get status] == "s" || [expr [supply get time] - [cal horizon get start]] < $alertThreshold} {
			supply attribute_value set KIT_ALERT "NO";
		} else {
			supply attribute_value set KIT_ALERT "YES";
		}
	}
}
#
run
