#
proc SetPlannerModes {} {
	global dmd_threshold
   
	# EMS Planner mode
	#Default EMS settings
	planner mode activate_ems_defaults

	#Enable Demand sorting
	planner mode set prebalance_demands on
	#Enable material and Capacity Constraints
	planner mode set sched mat_and_cap
	#planner mode set sched no_mat_no_cap

	#EMS Planner mode
   	#planner mode set consider_method_capacity on; #Indirectly turns off uda_match
	planner mode set method_capacity_build_period on

	#The following command resolves short demands when Use-to-Exhaust enabled
	#Required for certain models that use EMS
	planner mode set method_capacity_diamond_graph on

	#Set planner modes for constraint based planning
	planner mode set explicit_constraints_balance on
   	planner mode set explicit_constraints_schedule on

	planner mode set method_capacity_supplies_by_bucket off

	#When this flag is set to on, EMS determines if the WIP/supply is early or late
	#compared to the projected due date of demand and selects the WIP/supply
	#representing the least lost time. When this flag is set to off, EMS
	#consumes current level WIP/supply without considering the availability date.
	planner mode set consider_wip_availability on
   	planner mode set method_capacity_regular_schedule off
   	planner mode set yield_rounding ceil
	#
	planner mode set recover_connections on;
	##planner mode set recover_connections_policy recover_connections_as_used;
	planner mode set recover_connections_policy recover_connections_as_ordered_and_used;

	#planner mode set ems_refinement_upstream_solution_partialing_by_time on
	#In addition to setting resource care flag = 3, we need this planner mode
	# to avoid resource overloads
	# planner mode set avoid_resource_overloads yes
}
#
proc set_modes {} {
	global path;
	#Set planner modes for constraint based planning
	# planner mode set explicit_constraints_balance on
	# planner mode set explicit_constraints_schedule on

	# 34016: for method_starts constraints with context only for demands then we
	# should propagate the demand id to the lots created for the demand.
	catch {demand attribute add_string ADX_DEMAND_ID};
	catch {lot attribute add_string ADX_DEMAND_ID};
	demand attribute set ADX_DEMAND_ID propagation_direction upstream
	demand attribute set ADX_DEMAND_ID propagate_default_value no
	lot attribute set ADX_DEMAND_ID propagation_direction upstream
	lot attribute set ADX_DEMAND_ID propagate_default_value no
	set demand_number [demand get number];
	for { set demand_ix 0 } { $demand_ix < $demand_number } { incr demand_ix } {
		demand set ix $demand_ix;
		demand attribute_value set ADX_DEMAND_ID [demand get id];
	}
	#
	#demand attribute set DEMAND_ID_S propagation_direction upstream
	#demand attribute set DEMAND_ID_S propagate_default_value no
	#lot attribute set DEMAND_ID_S propagation_direction upstream
	#lot attribute set DEMAND_ID_S propagate_default_value no
	#lot attribute set DEMAND_ID propagation_direction downstream
	#lot attribute set DEMAND_ID propagate_default_value no
	#supply attribute set DEMAND_ID propagation_direction downstream
	#supply attribute set DEMAND_ID propagate_default_value no
	#
	demand attribute set WIRE_COLOR_S propagation_direction upstream
	demand attribute set WIRE_COLOR_S propagate_default_value no
	lot attribute set WIRE_COLOR_S propagation_direction upstream
	lot attribute set WIRE_COLOR_S propagate_default_value no
	lot attribute set WIRE_COLOR propagation_direction from_method
	lot attribute set WIRE_COLOR propagate_default_value no
	lot attribute set WIRE_COLOR propagation_direction downstream
	lot attribute set WIRE_COLOR propagate_default_value no
	supply attribute set WIRE_COLOR propagation_direction downstream
	supply attribute set WIRE_COLOR propagate_default_value no

	method attribute set WIRE_COLOR propagation_direction to_workorder
	method attribute set WIRE_COLOR propagate_default_value no
	#
	method attribute set PROD_AREA propagation_direction to_workorder
	method attribute set PROD_AREA propagate_default_value no
	method attribute set PROD_AREA propagate_over_nondefault_value no;
	#
	demand attribute set ALLOCATION_S propagation_direction upstream
	demand attribute set ALLOCATION_S propagate_default_value no
	lot attribute set ALLOCATION_S propagation_direction upstream
	lot attribute set ALLOCATION_S propagate_default_value no
	lot attribute set ALLOCATION propagation_direction downstream
	lot attribute set ALLOCATION propagate_default_value no
	supply attribute set ALLOCATION propagation_direction downstream
	supply attribute set ALLOCATION propagate_default_value no
	#
	#demand attribute set CUST_ID propagation_direction upstream
	#demand attribute set CUST_ID propagate_default_value no
	#lot attribute set CUST_ID propagation_direction upstream
	#lot attribute set CUST_ID propagate_default_value no
	#lot attribute set CUSTOMER_ID propagation_direction downstream
	#lot attribute set CUSTOMER_ID propagate_default_value no
	#supply attribute set CUSTOMER_ID propagation_direction downstream
	#supply attribute set CUSTOMER_ID propagate_default_value no
	#
	demand attribute set ASSY_LOC_S propagation_direction upstream
	demand attribute set ASSY_LOC_S propagate_default_value no
	lot attribute set ASSY_LOC_S propagation_direction upstream
	lot attribute set ASSY_LOC_S propagate_default_value no
	lot attribute set ASSY_LOC propagation_direction from_method
	lot attribute set ASSY_LOC propagate_default_value no
	lot attribute set ASSY_LOC propagation_direction downstream
	lot attribute set ASSY_LOC propagate_default_value no
	supply attribute set ASSY_LOC propagation_direction downstream
	supply attribute set ASSY_LOC propagate_default_value no
	#method attribute set ASSY_LOC propagation_direction to_workorder
	#method attribute set ASSY_LOC propagate_default_value no
	#
	demand attribute set FAB_LOC_S propagation_direction upstream
	demand attribute set FAB_LOC_S propagate_default_value no
	lot attribute set FAB_LOC_S propagation_direction upstream
	lot attribute set FAB_LOC_S propagate_default_value no
	lot attribute set FAB_LOC propagation_direction from_method
	lot attribute set FAB_LOC propagate_default_value no
	lot attribute set FAB_LOC propagation_direction downstream
	lot attribute set FAB_LOC propagate_default_value no
	supply attribute set FAB_LOC propagation_direction downstream
	supply attribute set FAB_LOC propagate_default_value no
	#method attribute set FAB_LOC propagation_direction to_workorder
	#method attribute set FAB_LOC propagate_default_value no
	#
	#demand attribute set DM_SPEC_S propagation_direction upstream
	#demand attribute set DM_SPEC_S propagate_default_value no
	#lot attribute set DM_SPEC_S propagation_direction upstream
	#lot attribute set DM_SPEC_S propagate_default_value no
	#lot attribute set DM_SPEC propagation_direction from_method
	#lot attribute set DM_SPEC propagate_default_value no
	#lot attribute set DM_SPEC propagation_direction downstream
	#lot attribute set DM_SPEC propagate_default_value no
	#supply attribute set DM_SPEC propagation_direction downstream
	#supply attribute set DM_SPEC propagate_default_value no
	#method attribute set DM_SPEC propagation_direction to_workorder
	#method attribute set DM_SPEC propagate_default_value no
	#
	echo "...propagate PSI_GROUP";
    method attribute set PSI_GROUP propagation_direction to_workorder;
    method attribute set PSI_GROUP propagate_default_value no;
	method attribute set PSI_GROUP propagate_over_nondefault_value no;
    lot attribute set PSI_GROUP propagation_direction downstream;
    lot attribute set PSI_GROUP propagate_default_value no;
	lot attribute set PSI_GROUP propagate_over_nondefault_value no;
	#
	method attribute set END_ITEM propagation_direction to_workorder
	method attribute set END_ITEM propagate_default_value no
	#
	set fp [open "$path(data)/ADEXA_UDA_SETTINGS.txt" r]
	gets $fp headstring

	while {[gets $fp linestring] > 0} {

      	if {[catch {eval $linestring}]} {
        	echo "SolveUDASetting error - $linestring"
		} else {
			echo setting:$linestring
		}
	}
	close $fp;
	echo "...set_modes completed";
}
#############################################################################
proc unscheduleAndDeleteLots { } {
  set conn [connect get status]
  connect off
  problem update off
  update_gui off

  planner unsched all

  lot delete all_planned
  supply delete all_planned

  problem update on
  update_gui on
  connect $conn
}
#############################################################################
proc BalanceAndSched { } {
   global start_bal end_bal start_sched end_sched
   global path

	problem update off
	update_gui off

	# unscheduleAndDeleteLots
	# already saved in the unsolved case
	#SetPlannerModes
	#set_modes

	# Run Planner Balance and Schedule All - pre and post logging
	set start_bal [misc unix_time]
	planner balance all
	set end_bal [misc unix_time]

	set start_sched [misc unix_time]
	planner sched all;
	set t [expr 7 * 86400];
	problem demand_due set threshold $t;
	set end_sched [misc unix_time]
	echo "...Solve time = [expr ($end_sched - $start_bal) / 60] seconds";

   #Source Vehicle Loading algorithm
  # planner vehicle_loading

#   tk_cube_init_dims_measures_and_views
#   tk_cube_enable_auto_update
#   source tcl/java/tool_delta.tcl;
#   tk_updateSupplyCalculations;
#   delta_scenario_record; # save base line scenario information about demands, supplies, and lots.
}
#############################################################################