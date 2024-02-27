#SCP70618
# -----------------------------------------------------------------------------
#
# Start constraint and sourcing constraint creation convenience functions
# Adds method_starts and workorder_starts/sourcing ratio constraints and permits editing of them.
# Default is to define the constraints at the week level (otherwise one must pass the list of start-end times as a parameter)
#
#
# Usage:
# ------
# tool_generate_starts_constraints { }
#   - see comments in above proc itself for usage instructions.
#   - this procedure should be used instead of the others below 
#
# tool_generate_sourcing_constraints { }
#   - see comments in above proc itself for usage instructions.
#   - this procedure should be used instead of the others below 
#
# Adexa Support
# support@adexa.com
# Last modification: July 5 2017
#
# -----------------------------------------------------------------------------
uplevel \#0 {
# set this to 1 to use wildcards instead of iterating over methods
set global_use_wildcards 0;
}

proc _get_time_level_boundaries { { time_level_id Week} } {
  cube level set id $time_level_id;
  if {! [cube level get is_time]} {
    error "Not time level";
  }
  set periods {};
  foreach member_id [cube level get members] {
    cube level member set id $member_id;
    lappend periods [list [cube level time get period_start] [cube level time get period_end]];
  }
  return $periods;
}

proc _get_time_levels_defined {} {
	set filtered_list {};
	set my_list [cube level get list];
	for { set ix [expr [llength $my_list] - 1] } { $ix >= 0 } { incr ix -1 } {
		set level_id [lindex $my_list $ix];
		cube level set id $level_id;
		if { [cube level get is_time] } {
			lappend filtered_list $level_id;
		}
	}
	return $filtered_list;
}

proc starts_constraints_use_wildcards { answer } {
	global global_use_wildcards;
	if { $answer == "no" } {
		set global_use_wildcards 0;
	} elseif { $answer == "yes" } {
		set global_use_wildcards 1;
	}
}

proc _collect_unique_non_purchase_method_indices { method_alt_id } {
	set ix_list {};
	if { $method_alt_id == "-" } {
		return $ix_list;
	}
	method_alt set id $method_alt_id;
	set elem_number [method_alt elem get number];
	for { set elem_ix 0 } { $elem_ix < $elem_number } { incr elem_ix } {
		method_alt elem set ix $elem_ix;
		method set id [method_alt elem get id];
		set method_ix [method get ix];
		if { ([method get type] == "M" || [method get type] == "T") && [lsearch $ix_list $method_ix] < 0 } {
			lappend ix_list $method_ix;
		}
	}
	return $ix_list;
}

#purpose context querying functions
proc show_purpose_context_purposes {} {
	set purpose_number [purpose_context purpose get number];
	for { set purpose_ix 0 } { $purpose_ix < $purpose_number } { incr purpose_ix } {
		purpose_context purpose set ix $purpose_ix;
		set purpose_id [purpose_context purpose get id];
		echo "-------------------------------------";
		set eval_obj_type [purpose_context $purpose_id get eval_obj_type];
		echo "Purpose: $purpose_id (role # = [purpose_context $purpose_id role get number]   eval_obj_type = $eval_obj_type)";
		
		show_purpose_context_roles $purpose_id;
	}
}

proc show_purpose_context_roles {purpose_id} {
	set role_number [purpose_context $purpose_id role get number];
	for { set role_ix 0 } { $role_ix < $role_number } { incr role_ix } {
		purpose_context $purpose_id role set ix $role_ix;
		set obj_number [purpose_context $purpose_id role obj_type get number];
		echo "  Role: [purpose_context $purpose_id role get id] (obj_type # = $obj_number)";
		for { set obj_ix 0 } { $obj_ix < $obj_number } { incr obj_ix } {
			purpose_context $purpose_id role obj_type set ix $obj_ix;
			set obj_type [purpose_context $purpose_id role obj_type get type];
			set elem_ix [purpose_context $purpose_id role obj_type get elem_ix];
			echo "    Obj_type $obj_ix: obj_type = $obj_type   elem_ix = $elem_ix";
		}
	}
}

proc test_effect {} {
	set lot_number [lot get number];
	set total_count 0;
	for { set lot_ix 0 } { $lot_ix < $lot_number } { incr lot_ix } {
		lot set ix $lot_ix;
		if { [lot get start] < [cal horizon get end] } {
			set count [show_startsconstraints_effecting_workorder [lot get id]];
			set total_count [expr $total_count + $count];
		}
	}
	echo "total effected: $total_count";
}

proc show_startsconstraints_effecting_workorder {workorder_id} {
	if { [catch {lot set id $workorder_id}] == 1 } {
		echo "ERROR: $workorder_id is not a valid lot id. Exiting!";
		return 0;
	}
	set count 0;
	set temporary_context_id "_temptest";
	if { [catch {purpose_context add $temporary_context_id}] == 1 } {
		purpose_context delete $temporary_context_id;
		purpose_context add $temporary_context_id;
	}
	purpose_context set purpose workorder_starts_constraint;
	purpose_context set start_time [lot get start];
	purpose_context set end_time [lot get end];
	purpose_context role_elem add method method [lot get method] -1;
	purpose_context role_elem add product@destination com@location [lot get inv] -1;
	set constraint_number [constraint get number];
	for { set constraint_ix 0 } { $constraint_ix < $constraint_number } { incr constraint_ix } {
		constraint set ix $constraint_ix;
		if { [constraint get property] != "workorder_starts" } {
			continue;
		}
		set result [purpose_context eval is_effected [constraint get id]];
		if { $result == "yes" } {
			echo "constraint: [constraint get id] lot: $workorder_id";
			incr count;
		}
	}
	purpose_context delete $temporary_context_id;
	return $count;
}

proc tool_constraints_error {msg} {
	echo "ERROR: $msg";
}

proc tool_constraints_warning {msg} {
	echo ".. WARNING: $msg";
}

# -------------------------------------------------------------------------------------
# Procedure: tool_generate_starts_constraints
# Parameters:
# 	csv_filename - the name of the csv file (including path) to read constraint data from
#   errorCheckOnly - (optional) set to 1 if just want to check the correctness of data w/o creating constraints
#
# Synopsis:
#	Will generate method_starts and corresponding workorder_starts constraints based
#	on the data within a specified csv file. The first line of the csv file should contain
#	the column headers. The remaining lines should contain the data.
#	The column headers of the file should include (in any particular order):
# 		CASE - name of case (currently not used)
# 		LOCATION - identifier of location or "-" (optional)
# 		COMMODITY - identifier of commodity or "-" (optional)
# 		COMLOCATION - identifier of com@location or "-"	 (optional)
# 		METHOD - identifier of method or "-" (optional)
# 		LOCATION_UDA_<NAME> - identifier of location uda to use for constraint where identifier is <NAME>. There can be 0 or more of these. (optional)
# 		COMMODITY_UDA_<NAME> - identifier of commodity uda to use for constraint where identifier is <NAME>. There can be 0 or more of these. (optional)
# 		COMLOCATION_UDA_<NAME> - identifier of com@location uda to use for constraint where identifier is <NAME>. There can 0 or more of these.	(optional)
# 		METHOD_UDA_<NAME> - identifier of method uda to use for constraint where identifier is <NAME>. There can be 0 or more of these. (optional)
# 		CAPACITY - capacity for the starts constraint in units
# 		UOM - time-based unit of measure to use which can be a valid time hierarchy level identifier or a keyword like DAY or WEEK or MONTH which will correspond to the pre-defined time hierarchy level identifiers Day, Week, or Month.
# 		START - start time for this capacity to start being in effect
# 		END - end time for this capacity to stop being in effect
#       BUILDPOLICY - build policy for this time period: early_late (default), early_no_late, no_early_late, no_early_no_late (optional)
#			early_late means try jit period then try early then try late.
#			early_no_late means try jit period then try early only.
#			no_early_late means try jit period then try late only.
#			no_early_no_late means try just the jit period.
#       BUILDEARLYLIMIT - if build policy permits early building then this specifies the maximum number of days early permitted (optional)
#       ENABLED - should the constraint be enabled. Set to 1 for enabled. Set to 0 for disabled. Default is 1. (optional)
#	The constraints will be generated with ids constructed from the UDA values and ids supplied in the columns.
#	They will be concatenations (separated by underscore characters) of:
#	1. location uda values (if supplied) in the order in which they appear from left to right in the csv
#	2. location id (if supplied)
#	3. commodity uda values (if supplied) in the order in which they appear from left to right in the csv
#	4. commodity id (if supplied)
#	5. comlocation uda values (if supplied) in the order in which they appear from left to right in the csv
#	6. comlocation id (if supplied)
#	7. method uda values (if supplied) in the order in which they appear from left to right in the csv
#	8. method id (if supplied)
#   The method_start constraints and constraint_targets will have _ms suffix.
#   The workorder_start constraints and constraint_targets will have _ws suffix.
#   Furthermore, the constraint_targets will have a further suffix of _ct.
#   Error messages and warning messages will be echoed to the console window. Errors will stop the script. Warnings will allow the script to proceed.
#   The cubes are reinitialized after the constraints are added.
#
#   Version 1.4 - July 18 2017
# -------------------------------------------------------------------------------------
# for new UI
proc addStdUDA {record correspondsId relPostfix} {
	global hl1_column_ix;
	global hl2_column_ix;
	global hl3_column_ix;
	global uCom_column_ix;
	global VENDOR_column_ix;
	global CATEGORY_column_ix;
	global RELATION_column_ix;
	global uLoc_column_ix;
	global PLANNER_column_ix;
	global TIME_LEVEL_column_ix;
	#
	#echo ">>>addStdUDA: record=$record";
	constraint attribute_value set HIER_LEVEL_1 [lindex $record $hl1_column_ix];
	constraint attribute_value set HIER_LEVEL_2 [lindex $record $hl2_column_ix];
	constraint attribute_value set HIER_LEVEL_3 [lindex $record $hl3_column_ix];
	constraint attribute_value set COMMODITY [lindex $record $uCom_column_ix];
	constraint attribute_value set VENDOR [lindex $record $VENDOR_column_ix];
	constraint attribute_value set CATEGORY [lindex $record $CATEGORY_column_ix];
	if {[lindex $record $RELATION_column_ix] == "-"} {
		set udaRel -;
	} else {
		set udaRel [format "%s_%s" [lindex $record $RELATION_column_ix] $relPostfix];
	}
	constraint attribute_value set RELATION $udaRel;
	constraint attribute_value set LOCATION [lindex $record $uLoc_column_ix];
	constraint attribute_value set PLANNER [lindex $record $PLANNER_column_ix];
	constraint attribute_value set TIME_LEVEL [lindex $record $TIME_LEVEL_column_ix];
	constraint attribute_value set CORRESPONDS $correspondsId;
}
#
proc tool_generate_starts_constraints_demo { csv_filename {errorCheckOnly 0} } {
	global hl1_column_ix;
	global hl2_column_ix;
	global hl3_column_ix;
	global uCom_column_ix;
	global VENDOR_column_ix;
	global CATEGORY_column_ix;
	global RELATION_column_ix;
	global uLoc_column_ix;
	global PLANNER_column_ix;
	global TIME_LEVEL_column_ix;
	set dontCare "-"; # this is the character to indicate we don't care about the value of the associated column for a record
	
    catch {constraint attribute add_string CORRESPONDS};
	# ensure that the time level is correctly defined
    tk_cube_model_init_no_measure_fill;
	
	set raw_list [core_io_readCSV $csv_filename];
	if { [llength $raw_list] < 2 } {
		tool_constraints_error "insufficient number of lines in csv $csv_filename";
		return 0;
	}
	set raw_schema [lindex $raw_list 0];
	set raw_data [lrange $raw_list 1 [llength $raw_list]];
	set record_number [llength $raw_data];	
	set schema_number [llength $raw_schema];
	
	# 1. process the schema so we know which column is which
	set location_uda_list {};
	set location_uda_list_column_ix {};
	set commodity_uda_list {};
	set commodity_uda_list_column_ix {};
	set comlocation_uda_list {};
	set comlocation_uda_list_column_ix {};	
	set method_uda_list {};
	set method_uda_list_column_ix {};
	set case_column_ix -1;
	set consID_column_ix -1;
	set location_column_ix -1;
	set commodity_column_ix -1;
	set comlocation_column_ix -1;
	set method_column_ix -1;
	set capacity_column_ix -1;
	set uom_column_ix -1;
	set start_column_ix -1;
	set end_column_ix -1;
	set buildpolicy_column_ix -1;
	set buildearlylimit_column_ix -1;
	set buildAhead_column_ix -1;
	set capViolation_column_ix -1;
	set enabled_column_ix -1;
	# for new UI
	set hl1_column_ix -1;
	set hl2_column_ix -1;
	set hl3_column_ix -1;
	set VENDOR_column_ix -1;
	set CATEGORY_column_ix -1;
	set RELATION_column_ix -1;
	set uCom_column_ix -1;
	set uLoc_column_ix -1;
	set PLANNER_column_ix -1;
	set TIME_LEVEL_column_ix -1;
	catch {constraint attribute add_string HIER_LEVEL_1};
	catch {constraint attribute add_string HIER_LEVEL_2};
	catch {constraint attribute add_string HIER_LEVEL_3};
	catch {constraint attribute add_string COMMODITY};
	catch {constraint attribute add_string VENDOR};
	catch {constraint attribute add_string CATEGORY};
	catch {constraint attribute add_string RELATION};
	catch {constraint attribute add_string LOCATION};
	catch {constraint attribute add_string PLANNER};
	catch {constraint attribute add_string TIME_LEVEL};
	for { set schema_ix 0 } { $schema_ix < $schema_number } { incr schema_ix } {
		set schema_column [lindex $raw_schema $schema_ix];
		switch $schema_column {
			CASE {
				set case_column_ix $schema_ix;			
			}
			CONS_ID {
				set consID_column_ix $schema_ix;			
			}
			LOCATION {
				set location_column_ix $schema_ix;		
			}
			COMMODITY {
				set commodity_column_ix $schema_ix;		
			}	
			COMLOCATION {
				set comlocation_column_ix $schema_ix;		
			}			
			METHOD {
				set method_column_ix $schema_ix;		
			}	
			CAPACITY {
				set capacity_column_ix $schema_ix;		
			}	
			UOM {
				set uom_column_ix $schema_ix;		
			}	
			START {
				set start_column_ix $schema_ix;			
			}	
			END {
				set end_column_ix $schema_ix;			
			}	
			BUILDPOLICY {
				set buildpolicy_column_ix $schema_ix;
			}
			BUILDEARLYLIMIT {
				set buildearlylimit_column_ix $schema_ix;
			}
			BUILDAHEAD {
				set buildAhead_column_ix $schema_ix;
			}
			CAPVIOLATION {
				set capViolation_column_ix $schema_ix;
			}
			ENABLED {
				set enabled_column_ix $schema_ix;
			}
			# for new UI
			HIER_LEVEL_1 {
				set hl1_column_ix $schema_ix;
			}
			HIER_LEVEL_2 {
				set hl2_column_ix $schema_ix;
			}
			HIER_LEVEL_3 {
				set hl3_column_ix $schema_ix;
			}
			UDA_COMMODITY {
				set uCom_column_ix $schema_ix;
			}
			UDA_VENDOR {
				set VENDOR_column_ix $schema_ix;
			}
			UDA_CATEGORY {
				set CATEGORY_column_ix $schema_ix;
			}
			RELATION {
				set RELATION_column_ix $schema_ix;
			}
			UDA_LOCATION {
				set uLoc_column_ix $schema_ix;
			}
			PLANNER {
				set PLANNER_column_ix $schema_ix;
			}
			TIME_LEVEL {
				set TIME_LEVEL_column_ix $schema_ix;
			}
			default {
				if { [string first "LOCATION_UDA_" $schema_column] == 0 } {
					set offset_ix [string length "LOCATION_UDA_"];
					set uda_name [string range $schema_column $offset_ix [string length $schema_column]];
					lappend location_uda_list $uda_name;
					lappend location_uda_list_column_ix $schema_ix;
					if { [catch {location attribute get $uda_name base_type}] == 1 } {
						tool_constraints_error "despite $schema_column specified, $uda_name is not a valid UDA for location data object";
						return 0;					
					}
				} elseif { [string first "COMMODITY_UDA_" $schema_column] == 0 } {
					set offset_ix [string length "COMMODITY_UDA_"];
					set uda_name [string range $schema_column $offset_ix [string length $schema_column]];
					lappend commodity_uda_list $uda_name;
					lappend commodity_uda_list_column_ix $schema_ix;	
					if { [catch {com attribute get $uda_name base_type}] == 1 } {
						tool_constraints_error "despite $schema_column specified, $uda_name is not a valid UDA for commodity data object";
						return 0;					
					}	
				} elseif { [string first "COMLOCATION_UDA_" $schema_column] == 0 } {
					set offset_ix [string length "COMLOCATION_UDA_"];
					set uda_name [string range $schema_column $offset_ix [string length $schema_column]];
					lappend comlocation_uda_list $uda_name;
					lappend comlocation_uda_list_column_ix $schema_ix;	
					if { [catch {com@location attribute get $uda_name base_type}] == 1 } {
						tool_constraints_error "despite $schema_column specified, $uda_name is not a valid UDA for com@location data object";
						return 0;					
					}											
				} elseif { [string first "METHOD_UDA_" $schema_column] == 0 } {
					set offset_ix [string length "METHOD_UDA_"];
					set uda_name [string range $schema_column $offset_ix [string length $schema_column]];
					lappend method_uda_list $uda_name;
					lappend method_uda_list_column_ix $schema_ix;	
					if { [catch {method attribute get $uda_name base_type}] == 1 } {
						tool_constraints_error "despite $schema_column specified, $uda_name is not a valid UDA for method data object";
						return 0;					
					}						
				} else {
					tool_constraints_warning "column $schema_column in csv $csv_filename will be ignored";
				}
			}
		}
	}
	if { $case_column_ix < 0 } {
		tool_constraints_error "bad schema in csv $csv_filename - missing CASE column";
		return 0;	
	} elseif { $consID_column_ix < 0 } {
		#tool_constraints_error "bad schema in csv $csv_filename - missing CONS_ID column"; YNH
		#return 0;	YNH
	} elseif { $capacity_column_ix < 0 } {
		tool_constraints_error "bad schema in csv $csv_filename - missing CAPACITY column";
		return 0;	
	} elseif { $uom_column_ix < 0 } {
		tool_constraints_error "bad schema in csv $csv_filename - missing UOM column";
		return 0;	
	} elseif { $start_column_ix < 0 } {
		tool_constraints_error "bad schema in csv $csv_filename - missing START column";
		return 0;		
	} elseif { $end_column_ix < 0 } {
		tool_constraints_error "bad schema in csv $csv_filename - missing END column";
		return 0;	
	}
	if { $buildpolicy_column_ix < 0 } {
		tool_constraints_warning "missing BUILDPOLICY column in csv $csv_filename - will presume early_late policy";
	}	
	if { $buildearlylimit_column_ix < 0 } {
		tool_constraints_warning "missing BUILDEARLYLIMIT column in csv $csv_filename - will presume no early limit";
	}
	if { $enabled_column_ix < 0 } {
		tool_constraints_warning "missing ENABLED column in csv $csv_filename - will presume all are enabled";
	}	
	if { $location_column_ix < 0 } {
		if { [llength $location_uda_list] == 0 } {
			tool_constraints_warning "missing LOCATION and LOCATION UDA columns in csv $csv_filename - will presume all";
		} else {
			tool_constraints_warning "missing LOCATION column in csv $csv_filename - will filter only by UDA";
		}
	}
	if { $commodity_column_ix < 0 } {
		if { [llength $commodity_uda_list] == 0 } {
			tool_constraints_warning "missing COMMODITY and COMMODITY UDA columns in csv $csv_filename - will presume all";
		} else {
			tool_constraints_warning "missing COMMODITY column in csv $csv_filename - will filter only by UDA";
		}	
	} 
	if { $comlocation_column_ix < 0 } {
		if { [llength $comlocation_uda_list] == 0 } {
			tool_constraints_warning "missing COMLOCATION and COMLOCATION UDA columns in csv $csv_filename - will presume all";
		} else {
			tool_constraints_warning "missing COMLOCATION column in csv $csv_filename - will filter only by UDA";
		}	
	} 
	if { $method_column_ix < 0 } {
		if { [llength $method_uda_list] == 0 } {
			tool_constraints_warning "missing METHOD and METHOD UDA columns in csv $csv_filename - will presume all";
		} else {
			tool_constraints_warning "missing METHOD column in csv $csv_filename - will filter only by UDA";
		}	
	}
	if { [llength $location_uda_list] == 0 && [llength $commodity_uda_list] == 0 && [llength $comlocation_uda_list] == 0 && [llength $method_uda_list] == 0 } {
		tool_constraints_warning "you have no UDA in your schema - remember they should be specified as <DATAOBJECT>_UDA_<NAME>; e.g. LOCATION_UDA_MYUDAID. Valid DATAOBJECT values are LOCATION, COMMODITY, COMLOCATION, or METHOD.";
	}
		
	# 2. process the constraint records
	set constraints {};
	set last_record_ix -1;
	set current_constraint {};
	set is_a_new_constraint 1;
	#set homogeneous_enabled_flag -1;
	for { set record_ix 0 } { $record_ix < $record_number } {incr record_ix} {
		set record [lindex $raw_data $record_ix];
		#echo "DEBUG: record";
		echo "DEBUG: record=$record";
		# 2 a) collect the essential attributes of the record
		set case [lindex $record $case_column_ix];
		if { $case != "" } {
			# case should be ignored according to consultant
			#echo "WARNING: record $record_ix has a non-empty case value - skipping it!";
			#continue;
		}		
		set consID [lindex $record $consID_column_ix];
		if { $consID == "NA" || $consID == "" || $consID == $dontCare } {
			# case should be ignored according to consultant
			echo "WARNING: record $record_ix has an invalid CONS_ID";
			continue;
		}		
		set capacity [lindex $record $capacity_column_ix];
		if { $capacity == "NA" || $capacity == "" || $capacity == $dontCare } {
			set capacity 0;
		}
		set uom [lindex $record $uom_column_ix];
		if { $uom != "MONTH" && $uom != "WEEK" && $uom != "DAY" } {
			if { [catch {cube level set id $uom}] || [cube level get is_time] == 0 } {
				tool_constraints_error "record $record_ix has an invalid uom $uom it must be MONTH or WEEK or DAY or a valid time hierarchy level - skipping it!";
				continue;	
			}			
		}
		set start [lindex $record $start_column_ix];
		if { $start <= 0 } {
			tool_constraints_error "record $record_ix has an invalid START it must be 1 or greater - skipping it!";
			continue;			
		}
		set end [lindex $record $end_column_ix];
		if { $end == 0 } {
			tool_constraints_error "record $record_ix has an invalid END it must be 1 or greater or -1 - skipping it!";
			continue;				
		}
		if { $buildpolicy_column_ix >= 0 } {
			set build_policy [lindex $record $buildpolicy_column_ix];
			if { $build_policy == "NA" || $build_policy == "" || $build_policy == $dontCare } {
				set build_policy early_late; #default
			} else {
				if { $build_policy != "early_late" && $build_policy != "early_no_late" && $build_policy != "no_early_late" && $build_policy != "no_early_no_late" } {
					tool_constraints_error "record $record_ix has an invalid build policy $build_policy it must be early_late or early_no_late or no_early_late or no_early_no_late - skipping it!";
					continue;			
				}	
			}			
		} else {
			set build_policy early_late; #default
		}
		set enabled 1;
		if { $enabled_column_ix >= 0 } {
			set enabledWord [string toupper [lindex $record $enabled_column_ix]];
			if { $enabledWord == 1 || $enabledWord == "Y" || $enabledWord == "YES" || $enabledWord == "ON" || $enabledWord == "NA" || $enabledWord == "" || $enabledWord == $dontCare } {
				set enabled 1;
			} elseif { $enabledWord == "REPORT" } {
				set enabled 2;
			} else {
				set enabled 0;
			}
		}
		if { $buildearlylimit_column_ix >= 0 } {
			set build_early_limit [lindex $record $buildearlylimit_column_ix];
			if { $build_early_limit == "NA" || $build_early_limit == "" || $build_early_limit == $dontCare } {
				set build_early_limit -1; #default
			} else {
				if { [string is integer -strict $build_early_limit] == 0 } {
					tool_constraints_error "record $record_ix has an invalid BUILDEARLYLIMIT it must be an integer number - skipping it!";
					continue;				
				}
			}
		} else {
			set build_early_limit -1;
		}	
		if { $buildAhead_column_ix >= 0 } {
			set buildAhead [lindex $record $buildAhead_column_ix];
			if { $buildAhead == "NA" || $buildAhead == "" || $buildAhead == $dontCare } {
				set buildAhead -1; #default
			} else {
				if { [string is integer -strict $buildAhead] == 0 } {
					tool_constraints_error "record $record_ix has an invalid BUILDAHEAD it must be an integer number - skipping it!";
					continue;				
				}
			}
		} else {
			set buildAhead -1;
		}	
		if { $capViolation_column_ix >= 0 } {
			set capViolation [lindex $record $capViolation_column_ix];
			#if { $capViolation == "NA" || $capViolation == "" || $capViolation == $dontCare } {
			#	set capViolation -1; #default
			#} else {
			#	if { [string is integer -strict $capViolation] == 0 } {
			#		tool_constraints_error "record $record_ix has an invalid CAPVIOLATION.";
			#		continue;				
			#	}
			#}
		} else {
			set capViolation "";
		}
		
		# 2 b) check if the record is representing a new constraint or it is a continuation of the previous constraint
		#echo "DEBUG: checking if new constraint";
		set is_a_new_constraint 1;
		# was to check duplicate constraints but no longer applicable with the new UI design
		#if { $last_record_ix >= 0 } {
		#	set last_record [lindex $raw_data $last_record_ix];
		#	# are these for the same constraint? Presume no.
		#	set is_a_new_constraint 0;
		#	if { $case_column_ix >= 0 && !([lindex $last_record $case_column_ix] eq [lindex $record $case_column_ix]) } {
		#		set is_a_new_constraint 1;
		#	} elseif { $location_column_ix >= 0 && !([lindex $last_record $location_column_ix] eq [lindex $record $location_column_ix]) } {
		#		set is_a_new_constraint 1;
		#	} elseif { $commodity_column_ix >= 0 && !([lindex $last_record $commodity_column_ix] eq [lindex $record $commodity_column_ix]) } {
		#		set is_a_new_constraint 1;
		#	} elseif { $comlocation_column_ix >= 0 && !([lindex $last_record $comlocation_column_ix] eq [lindex $record $comlocation_column_ix]) } {
		#		set is_a_new_constraint 1;
		#	} elseif { $method_column_ix >= 0 && !([lindex $last_record $method_column_ix] eq [lindex $record $method_column_ix]) } {
		#		set is_a_new_constraint 1;
		#	} else {
		#		# check the udas
		#		set uda_number [llength $location_uda_list];
		#		for { set uda_ix 0 } { $uda_ix < $uda_number && $is_a_new_constraint == 0 } { incr uda_ix } {
		#			if { !( [lindex $last_record [lindex $location_uda_list_column_ix $uda_ix]] eq [lindex $record [lindex $location_uda_list_column_ix $uda_ix]]) } {
		#				set is_a_new_constraint 1;
		#			}
		#		}
		#		set uda_number [llength $commodity_uda_list];
		#		for { set uda_ix 0 } { $uda_ix < $uda_number && $is_a_new_constraint == 0 } { incr uda_ix } {
		#			if { !( [lindex $last_record [lindex $commodity_uda_list_column_ix $uda_ix]] eq [lindex $record [lindex $commodity_uda_list_column_ix $uda_ix]]) } {
		#				set is_a_new_constraint 1;
		#			}
		#		}
		#		set uda_number [llength $comlocation_uda_list];
		#		for { set uda_ix 0 } { $uda_ix < $uda_number && $is_a_new_constraint == 0 } { incr uda_ix } {
		#			if { !( [lindex $last_record [lindex $comlocation_uda_list_column_ix $uda_ix]] eq [lindex $record [lindex $comlocation_uda_list_column_ix $uda_ix]]) } {
		#				set is_a_new_constraint 1;
		#			}
		#		}	
		#		set uda_number [llength $method_uda_list];
		#		for { set uda_ix 0 } { $uda_ix < $uda_number && $is_a_new_constraint == 0 } { incr uda_ix } {
		#			if { !( [lindex $last_record [lindex $method_uda_list_column_ix $uda_ix]] eq [lindex $record [lindex $method_uda_list_column_ix $uda_ix]]) } {
		#				set is_a_new_constraint 1;
		#			}
		#		}				
		#	}
		#}
		set last_record_ix $record_ix;
		
		echo "DEBUG: is_a_new_constraint=$is_a_new_constraint";
		
		# 2 c) add the constraint or append this record to an existing constraint		
		# add the constraint item
		set constraint_item {};
		lappend constraint_item $start;
		lappend constraint_item $end;	
		lappend constraint_item $capacity;	
		lappend constraint_item $build_policy;
		lappend constraint_item $buildAhead; #build_early_limit
		lappend constraint_item [expr $enabled == 1? 1 : 0]; #$enabled;
		lappend constraint_item $uom;
		lappend constraint_item $capViolation;
		if { $is_a_new_constraint == 1 } {
			if { [llength $current_constraint] > 0 } {
				echo ">>>> append constraint_items to current_constraint=$current_constraint";
				lappend current_constraint $constraint_items;
				#lappend current_constraint $homogeneous_enabled_flag;
				#lappend current_constraint $enabled;
				#lappend current_constraint $consID;
				lappend constraints $current_constraint;		
			}
			# we use the record itself to hold on to the attributes (we will ignore the CAPACITY START END columns since these will be appended in a list)
			set current_constraint $record;
			lappend current_constraint $enabled;
			set constraint_items {};
			echo ">>>> reset to new constraint record:$record";
			# reset flag
			#set homogeneous_enabled_flag -1;
		}	
		lappend constraint_items $constraint_item;
		echo ">>>> append constraint_item=$constraint_item";
		#if { $homogeneous_enabled_flag == -1 } {
		#	# has not been set yet
		#	set homogeneous_enabled_flag $enabled;
		#} else {
		#	if { $homogeneous_enabled_flag != $enabled } {
		#		# heterogeneous values detected
		#		set homogeneous_enabled_flag -2;
		#	}
		#}
	}
	# 2 d) don't forget to finish off the last constraint
	if { [llength $current_constraint] > 0} {
		echo ">>>> append constraint_items to current_constraint=$current_constraint -->last constraint";
		lappend current_constraint $constraint_items;
		#lappend current_constraint $homogeneous_enabled_flag;
		#lappend current_constraint $enabled;
		lappend constraints $current_constraint;	
	}	
	
	# 3. add the UDA on constraints for hierarchy
	# TO BE DETERMINED LATER!!	
	
	# 4. Generate the constraints
	# (now we have a clean set of constraints in a list)
	set constraint_number [llength $constraints];
	set day_time_levels [_get_time_level_boundaries $::tk_time_dim_id];
	set week_time_levels [_get_time_level_boundaries Week]; #WEEK
	set month_time_levels [_get_time_level_boundaries Month]; #MONTH
	set permitted_time_levels [_get_time_levels_defined];
	for { set constraint_ix 0 } { $constraint_ix < $constraint_number } { incr constraint_ix } {
		set current_constraint [lindex $constraints $constraint_ix];
		echo ">>>>> current_constraint=$current_constraint";
		set record [lrange $current_constraint 0 [expr [llength $current_constraint] - 2]];
		set constraint_items [lindex $current_constraint [expr [llength $current_constraint] - 1]];
		#set homogeneous_enabled_flag [lindex $current_constraint [expr [llength $current_constraint] - 2]];
		#set enabled [lindex $current_constraint [expr [llength $current_constraint] - 1]];
		set enabled [lindex $record [expr [llength $record] - 1]]; #converted enabled flag
		#set consID [lindex $current_constraint [expr [llength $current_constraint] - 1]];
		set consID [lindex $current_constraint 1];
	
		# 4 a) get the time_levels to use
		# (we will postpone this since it may be specified per capacity line in the constraint)	
		set time_levels [_get_time_level_boundaries [lindex $record $TIME_LEVEL_column_ix]];

		# 4 b) create the constraint id to use
		# location-commodity-comlocation-method ordering with blanks/dont cares skipped
		#set constraint_id "";
		#set spacer "_";
		#set appending 0;
		#set uda_number [llength $location_uda_list];
		#for { set uda_ix 0 } { $uda_ix < $uda_number } { incr uda_ix } {
		#	set substring_id [lindex $record [lindex $location_uda_list_column_ix $uda_ix]];
		#	if { !($substring_id == "" || $substring_id == $dontCare) } {
		#		if { $appending } {
		#			append constraint_id $spacer;
		#		}
		#		set appending 1;
		#		append constraint_id $substring_id;
		#	}
		#}		
		#if { $location_column_ix >= 0 } {
		#	set substring_id [lindex $record $location_column_ix];
		#	if { !($substring_id == "" || $substring_id == $dontCare) } {
		#		if { $appending } {
		#			append constraint_id $spacer;
		#		}
		#		set appending 1;			
		#		append constraint_id $substring_id;
		#	}
		#}
		#set uda_number [llength $commodity_uda_list];
		#for { set uda_ix 0 } { $uda_ix < $uda_number } { incr uda_ix } {
		#	set substring_id [lindex $record [lindex $commodity_uda_list_column_ix $uda_ix]];
		#	if { !($substring_id == "" || $substring_id == $dontCare) } {
		#		if { $appending } {
		#			append constraint_id $spacer;
		#		}
		#		set appending 1;
		#		append constraint_id $substring_id;
		#	}
		#}			
		#if { $commodity_column_ix >= 0 } {
		#	set substring_id [lindex $record $commodity_column_ix];
		#	if { !($substring_id == "" || $substring_id == $dontCare) } {
		#		if { $appending } {
		#			append constraint_id $spacer;
		#		}
		#		set appending 1;			
		#		append constraint_id $substring_id;
		#	}
		#}	
		#set uda_number [llength $comlocation_uda_list];
		#for { set uda_ix 0 } { $uda_ix < $uda_number } { incr uda_ix } {
		#	set substring_id [lindex $record [lindex $comlocation_uda_list_column_ix $uda_ix]];
		#	if { !($substring_id == "" || $substring_id == $dontCare) } {
		#		if { $appending } {
		#			append constraint_id $spacer;
		#		}
		#		set appending 1;
		#		append constraint_id $substring_id;
		#	}
		#}		
		#if { $comlocation_column_ix >= 0 } {
		#	set substring_id [lindex $record $comlocation_column_ix];
		#	if { !($substring_id == "" || $substring_id == $dontCare) } {
		#		if { $appending } {
		#			append constraint_id $spacer;
		#		}
		#		set appending 1;			
		#		append constraint_id $substring_id;
		#	}
		#}
		#set uda_number [llength $method_uda_list];
		#for { set uda_ix 0 } { $uda_ix < $uda_number } { incr uda_ix } {
		#	set substring_id [lindex $record [lindex $method_uda_list_column_ix $uda_ix]];
		#	if { !($substring_id == "" || $substring_id == $dontCare) } {
		#		if { $appending } {
		#			append constraint_id $spacer;
		#		}
		#		set appending 1;
		#		append constraint_id $substring_id;
		#	}
		#}		
		#if { $method_column_ix >= 0 } {
		#	set substring_id [lindex $record $method_column_ix];
		#	if { !($substring_id == "" || $substring_id == $dontCare) } {
		#		if { $appending } {
		#			append constraint_id $spacer;
		#		}
		#		set appending 1;			
		#		append constraint_id $substring_id;
		#	}
		#}
		set method_starts_id [format "%s_ms" $consID]; #constraint_id
		set method_starts_ct_id [format "%s_ms_ct" $consID]; #constraint_id
		if { [catch {constraint set id $method_starts_id} ] == 0 } {
			tool_constraints_error "a constraint of id $method_starts_id already exists. skipping this!";
			continue;
		}
		if { [catch {constraint_target set id $method_starts_ct_id} ] == 0 } {
			tool_constraints_error "a constraint_target of id $method_starts_ct_id already exists. skipping this!";
			continue;
		}		
		set workorder_starts_id [format "%s_ws" $consID]; #constraint_id
		set workorder_starts_ct_id [format "%s_ws_ct" $consID]; #constraint_id
		if { [catch {constraint set id $method_starts_id} ] == 0 } {
			tool_constraints_error "a constraint of id $workorder_starts_id already exists. skipping this!";
			continue;
		}	
		if { [catch {constraint_target set id $workorder_starts_ct_id} ] == 0 } {
			tool_constraints_error "a constraint_target of id $workorder_starts_ct_id already exists. skipping this!";
			continue;
		}	

		# 4 c) add the "empty" method_starts constraint and target	
		if { $errorCheckOnly == 0 } {
			constraint_target add $method_starts_ct_id;
			constraint_target set property method_starts;
			constraint add $method_starts_id;
			echo ">>>>> DEBUG: adding constraint $method_starts_id";
			constraint set property method_starts;	
			addStdUDA $record $workorder_starts_id "ms";
			#if { $homogeneous_enabled_flag == 0 || $homogeneous_enabled_flag == 1 } {
			#	constraint set enabled $homogeneous_enabled_flag;
			#}
			constraint set enabled $enabled;
			constraint_target add $workorder_starts_ct_id;
			constraint_target set property workorder_starts;
			constraint add $workorder_starts_id;
			constraint set property workorder_starts;	
			addStdUDA $record $method_starts_id "ws";
			#if { $homogeneous_enabled_flag == 0 || $homogeneous_enabled_flag == 1 } {
			#	constraint set enabled $homogeneous_enabled_flag;
			#}
			constraint set enabled $enabled;
		}

		# 4 d) add the elements for the constraint targets
		if { $errorCheckOnly == 0 } {
			set added_comlocation 0;
			set added_method 0;
			set uda_number [llength $location_uda_list];
			for { set uda_ix 0 } { $uda_ix < $uda_number } { incr uda_ix } {
				set uda_name [lindex $location_uda_list $uda_ix];
				set uda_value [lindex $record [lindex $location_uda_list_column_ix $uda_ix]];
				if { !($uda_value == "" || $uda_value == $dontCare) } {
					constraint_target set id $method_starts_ct_id;
					constraint_target elem add location "*";
					constraint_target elem set uda_name $uda_name;
					constraint_target elem set uda_value $uda_value;
					constraint_target elem set multiple conjunctive;
					constraint_target set id $workorder_starts_ct_id;
					constraint_target elem add location "*";
					constraint_target elem set uda_name $uda_name;
					constraint_target elem set uda_value $uda_value;				
					constraint_target elem set multiple conjunctive;
				}
			}		
			if { $location_column_ix >= 0 } {
				set required_id [lindex $record $location_column_ix];
				if { !($required_id == "" || $required_id == $dontCare) } {	
					constraint_target set id $method_starts_ct_id;
					constraint_target elem add location $required_id;
					constraint_target elem set multiple conjunctive;
					constraint_target set id $workorder_starts_ct_id;
					constraint_target elem add location $required_id;
					constraint_target elem set multiple conjunctive;				
				} else {
					constraint_target set id $method_starts_ct_id;
					constraint_target elem add location "*";
					constraint_target elem set multiple conjunctive;
					constraint_target set id $workorder_starts_ct_id;
					constraint_target elem add location "*";
					constraint_target elem set multiple conjunctive;			
				}
			}
			set uda_number [llength $commodity_uda_list];
			for { set uda_ix 0 } { $uda_ix < $uda_number } { incr uda_ix } {
				set uda_name [lindex $commodity_uda_list $uda_ix];
				set uda_value [lindex $record [lindex $commodity_uda_list_column_ix $uda_ix]];
				if { !($uda_value == "" || $uda_value == $dontCare) } {
					constraint_target set id $method_starts_ct_id;
					constraint_target elem add com "*";
					constraint_target elem set uda_name $uda_name;
					constraint_target elem set uda_value $uda_value;
					constraint_target elem set multiple conjunctive;
					constraint_target set id $workorder_starts_ct_id;
					constraint_target elem add com "*";
					constraint_target elem set uda_name $uda_name;
					constraint_target elem set uda_value $uda_value;				
					constraint_target elem set multiple conjunctive;
				}
			}			
			if { $commodity_column_ix >= 0 } {
				set required_id [lindex $record $commodity_column_ix];
				if { !($required_id == "" || $required_id == $dontCare) } {	
					constraint_target set id $method_starts_ct_id;
					constraint_target elem add com $required_id;
					constraint_target elem set multiple conjunctive;
					constraint_target set id $workorder_starts_ct_id;
					constraint_target elem add com $required_id;
					constraint_target elem set multiple conjunctive;				
				} else {
					constraint_target set id $method_starts_ct_id;
					constraint_target elem add com "*";
					constraint_target elem set multiple conjunctive;
					constraint_target set id $workorder_starts_ct_id;
					constraint_target elem add com "*";
					constraint_target elem set multiple conjunctive;			
				}
			}	
			set uda_number [llength $comlocation_uda_list];
			for { set uda_ix 0 } { $uda_ix < $uda_number } { incr uda_ix } {
				set uda_name [lindex $comlocation_uda_list $uda_ix];
				set uda_value [lindex $record [lindex $comlocation_uda_list_column_ix $uda_ix]];
				if { !($uda_value == "" || $uda_value == $dontCare) } {
					constraint_target set id $method_starts_ct_id;
					constraint_target elem add com@location "*";
					constraint_target elem set uda_name $uda_name;
					constraint_target elem set uda_value $uda_value;
					constraint_target elem set multiple conjunctive;
					constraint_target set id $workorder_starts_ct_id;
					constraint_target elem add com@location "*";
					constraint_target elem set uda_name $uda_name;
					constraint_target elem set uda_value $uda_value;				
					constraint_target elem set multiple conjunctive;
					incr added_comlocation;
				}
			}		
			if { $comlocation_column_ix >= 0 } {
				set required_id [lindex $record $comlocation_column_ix];
				if { !($required_id == "" || $required_id == $dontCare) } {	
					constraint_target set id $method_starts_ct_id;
					constraint_target elem add com@location $required_id;
					constraint_target elem set multiple conjunctive;
					constraint_target set id $workorder_starts_ct_id;
					constraint_target elem add com@location $required_id;
					constraint_target elem set multiple conjunctive;	
					incr added_comlocation;
				}			
			} 
			if { $added_comlocation == 0 } {
				constraint_target set id $method_starts_ct_id;
				constraint_target elem add com@location "*";
				constraint_target elem set multiple conjunctive;
				constraint_target set id $workorder_starts_ct_id;
				constraint_target elem add com@location "*";
				constraint_target elem set multiple conjunctive;					
			}		
			set uda_number [llength $method_uda_list];
			for { set uda_ix 0 } { $uda_ix < $uda_number } { incr uda_ix } {
				set uda_name [lindex $method_uda_list $uda_ix];
				set uda_value [lindex $record [lindex $method_uda_list_column_ix $uda_ix]];
				if { !($uda_value == "" || $uda_value == $dontCare) } {
					constraint_target set id $method_starts_ct_id;
					constraint_target elem add method "*";
					constraint_target elem set uda_name $uda_name;
					constraint_target elem set uda_value $uda_value;
					constraint_target elem set multiple conjunctive;
					constraint_target set id $workorder_starts_ct_id;
					constraint_target elem add method "*";
					constraint_target elem set uda_name $uda_name;
					constraint_target elem set uda_value $uda_value;				
					constraint_target elem set multiple conjunctive;
					incr added_method;
				}
			}		
			if { $method_column_ix >= 0 } {
				set required_id [lindex $record $method_column_ix];
				if { !($required_id == "" || $required_id == $dontCare) } {	
					constraint_target set id $method_starts_ct_id;
					constraint_target elem add method $required_id;
					constraint_target elem set multiple conjunctive;
					constraint_target set id $workorder_starts_ct_id;
					constraint_target elem add method $required_id;
					constraint_target elem set multiple conjunctive;
					incr added_method;							
				}
			}
			if { $added_method == 0 } {
				constraint_target set id $method_starts_ct_id;
				constraint_target elem add method "*";
				constraint_target elem set multiple conjunctive;
				constraint_target set id $workorder_starts_ct_id;
				constraint_target elem add method "*";
				constraint_target elem set multiple conjunctive;			
			}
		}

		# 4 e) add the action elements (time-phased capacities) for the constraints
		set capacities $constraint_items;
		set capacity_number [llength $capacities];
		
		for { set capacity_ix 0 } { $capacity_ix < $capacity_number } { incr capacity_ix } {
			set current_capacity [lindex $capacities $capacity_ix];
			set capViolation [lindex $current_capacity 7];
			set uom [lindex $current_capacity 6];
			set enabledChild [lindex $current_capacity 5];
			set buildAhead [lindex $current_capacity 4]; #build_early_limit
			set build_policy [lindex $current_capacity 3];
			if { $buildAhead < 0 } {; #build_early_limit
				set action_three $build_policy;
			} else {
				set action_three [format "%s %s %s" $build_policy $buildAhead $capViolation]; #build_early_limit
			}
			set max_quantity [lindex $current_capacity 2];
			# the start and end of the capacity is expressed in UNIX time (not indicies of the time_levels)
			set raw_start_time [lindex $current_capacity 0];
			set raw_end_time [lindex $current_capacity 1];
			# take a second away to ensure that there is no overlap
			# (actually not necessary)
			#incr raw_end_time -1;
			
			# get the time_levels to use -> changed to use csv input instead
			#if { [lsearch $permitted_time_levels $uom] >= 0 } {
			#	set time_levels [_get_time_level_boundaries $uom];
			#} else {
			#	if { $uom == "WEEK" } {
			#		set time_levels $week_time_levels;
			#	} elseif { $uom == "MONTH" } {
			#		set time_levels $month_time_levels;
			#	} elseif { $uom == "DAY" } {
			#		set time_levels $day_time_levels;
			#	}
			#}				
			set index_number [llength $time_levels];
			set restricted_time_levels {};
			
			for { set ix 0 } { $ix < $index_number } { incr ix } {
				set current_time [lindex $time_levels $ix];
				set lower_current_time [lindex $current_time 0];
				set upper_current_time [lindex $current_time 1];
				# have we gone past the end of our capacity item?
				if { $raw_end_time > 0 && $lower_current_time >= $raw_end_time } {
					break;
				}	
				if { $raw_end_time > 0 && $upper_current_time >= $raw_end_time } {
					set upper_current_time $raw_end_time;
				}
				# have we not reached the start of our capacity item?
				if { $upper_current_time < $raw_start_time } {
					continue;
				}
				if { $lower_current_time < $raw_start_time } {
					set lower_current_time $raw_start_time;
				}
				if { $lower_current_time >= $upper_current_time } {
					# time period was cropped out of existence
					continue;
				}
				set adjusted_current_time [list $lower_current_time $upper_current_time];
				lappend restricted_time_levels $adjusted_current_time;
			}
			if { [llength $restricted_time_levels] <= 0 } {
				tool_constraints_error "this constraint $constraint_ix has an empty capacity list for index $capacity_ix - skipping it!";
				continue;				
			}
			if { $errorCheckOnly == 0 } {
				set time_length [llength $restricted_time_levels];
				for { set time_ix 0 } { $time_ix < $time_length } { incr time_ix } {
					set current_time [lindex $restricted_time_levels $time_ix];
					set time_start [lindex $current_time 0];
					set time_end [lindex $current_time 1];
					constraint set id $method_starts_id;
					constraint action_elem add $time_start $time_end;
					constraint action_elem set action_one $max_quantity;	
					constraint action_elem set action_three $action_three;	
					#if { $homogeneous_enabled_flag < 0 } {
					#	constraint action_elem set enabled $enabled;
					#}
					constraint action_elem set enabled $enabledChild;
					constraint set id $workorder_starts_id;
					constraint action_elem add $time_start $time_end;
					constraint action_elem set action_one $max_quantity;
					constraint action_elem set action_three $action_three;	
					#if { $homogeneous_enabled_flag < 0 } {
					#	constraint action_elem set enabled $enabled;
					#}
					constraint action_elem set enabled $enabledChild;
				}
			}			
		}
		
		# 4 f) reference the constraint_target in the constraint
		if { $errorCheckOnly == 0 } {
			constraint set id $method_starts_id;	
			constraint target_elem add $method_starts_ct_id;
			constraint set id $workorder_starts_id;
			constraint target_elem add $workorder_starts_ct_id;	
		}
    }	

	# 5. refresh the cubes if needed
	if { $errorCheckOnly == 0 } {
		tk_cube_model_init;
	}
	
	return 1;
}


# -------------------------------------------------------------------------------------
# Procedure: tool_generate_sourcing_constraints
# Parameters:
# 	csv_filename - the name of the csv file (including path) to read constraint data from
#   errorCheckOnly - (optional) set to 1 if just want to check the correctness of data w/o creating constraints
#
# Synopsis:
#	Will generate sourcing_ratio constraints based
#	on the data within a specified csv file. The first line of the csv file should contain
#	the column headers. The remaining lines should contain the data.
#	The column headers of the file should include (in any particular order):
# 		CASE - name of case (currently not used)
#       ROLE - the role of this line in the definition of sourcing constraints. This can be one of three values: the keyword GLOBAL, the keyword LOCAL or a target identifier.
#       A target identifier is used in defining a group of methods or a "target" for a sourcing ratio constraint.  GLOBAL is a definition of a sourcing ratio 
#       involving one or more targets that should be applied across multiple com@locations. LOCAL is a definition of a sourcing ratio involving one or more targets
#       that should be applied individually at each com@location. 
#       For target 
#
#       Only populate the following columns for ROLE == a target identifier:
# 		LOCATION - identifier of location or "-" (optional)
# 		COMMODITY - identifier of commodity or "-" (optional)
# 		COMLOCATION - identifier of com@location or "-"	 (optional)
# 		METHOD - identifier of method or "-" (optional)
# 		LOCATION_UDA_<NAME> - identifier of location uda to use for constraint where identifier is <NAME>. There can be 0 or more of these. (optional)
# 		COMMODITY_UDA_<NAME> - identifier of commodity uda to use for constraint where identifier is <NAME>. There can be 0 or more of these. (optional)
# 		COMLOCATION_UDA_<NAME> - identifier of com@location uda to use for constraint where identifier is <NAME>. There can 0 or more of these.	(optional)
# 		METHOD_UDA_<NAME> - identifier of method uda to use for constraint where identifier is <NAME>. There can be 0 or more of these. (optional)
#       ENABLED - should the constraint be enabled. Set to 1 for enabled. Set to 0 for disabled. Default is 1. (optional)
#
#       Only populate the following columns for ROLE == GLOBAL or ROLE == LOCAL:
#       RULE_<#> - a rule for this target in this constraint. You can have any number of these columns but identify them numerically; e.g. RULE_1, RULE_2, RULE_3..etc.. 
#       The values for these rules should be of the form of a TARGET you have previously defined in a ROLE, followed by a colon, followed by the symbol ">" or "=", 
#       followed by a number between 0 and 1.
#       For example, IN_HOUSE:>0.70 or EXTERNAL:=0.15 where IN_HOUSE and EXTERNAL are targets.
#       UOM - time-based unit of measure to use which can be a valid time hierarchy level identifier or a keyword like DAY or WEEK or MONTH which will correspond to the pre-defined time hierarchy level identifiers Day, Week, or Month.
# 		START - start time for this ratio
# 		END - end time for this ratio.

#	The constraints will be generated with ids constructed from the target identifiers 
#   you wish to use in the constraint. These ids will be collected from the RULE<#> column values.
#	They will be concatenations (separated by underscore characters).
#   The sourcing_ratio constraints and constraint_targets will have _sr suffix (sr = (S)ourcing (R)atio).
#   Furthermore, the constraint_targets will have a further suffix of _ct.
#   Error messages and warning messages will be echoed to the console window. Errors will stop the script. Warnings will allow the script to proceed.
#   The cubes are reinitialized after the constraints are added.
#
#   Version 1.3 - July 18 2017
# -------------------------------------------------------------------------------------
proc tool_generate_sourcing_constraints { csv_filename {errorCheckOnly 0} } {
	
	set dontCare "-"; # this is the character to indicate we don't care about the value of the associated column for a record
	
    # ensure that the time level is correctly defined
    tk_cube_model_init_no_measure_fill;
	
	set raw_list [core_io_readCSV $csv_filename];
	if { [llength $raw_list] < 2 } {
		tool_constraints_error "insufficient number of lines in csv $csv_filename";
		return 0;
	}
	set raw_schema [lindex $raw_list 0];
	set raw_data [lrange $raw_list 1 [llength $raw_list]];
	set record_number [llength $raw_data];	
	set schema_number [llength $raw_schema];
	
	# 1. process the schema so we know which column is which
	#echo "1. process the schema so we know which column is which";
	set case_column_ix -1;
	set role_column_ix -1;	
	# for TARGET roles only	
	set location_uda_list {};
	set location_uda_list_column_ix {};
	set commodity_uda_list {};
	set commodity_uda_list_column_ix {};
	set comlocation_uda_list {};
	set comlocation_uda_list_column_ix {};	
	set method_uda_list {};
	set method_uda_list_column_ix {};
	set location_column_ix -1;
	set commodity_column_ix -1;
	set comlocation_column_ix -1;
	set method_column_ix -1;
	set enabled_column_ix -1;
	# for GLOBAL or LOCAL rows
	set rule_list {};
	set rule_list_column_ix {};
	set uom_column_ix -1;
	set start_column_ix -1;
	set end_column_ix -1;
	
	for { set schema_ix 0 } { $schema_ix < $schema_number } { incr schema_ix } {
		set schema_column [lindex $raw_schema $schema_ix];
		switch $schema_column {
			CASE {
				set case_column_ix $schema_ix;			
			}
			ROLE {
				set role_column_ix $schema_ix;			
			}			
			LOCATION {
				set location_column_ix $schema_ix;		
			}
			COMMODITY {
				set commodity_column_ix $schema_ix;		
			}	
			COMLOCATION {
				set comlocation_column_ix $schema_ix;		
			}			
			METHOD {
				set method_column_ix $schema_ix;		
			}
			ENABLED {
				set enabled_column_ix $schema_ix;
			}
			UOM {
				set uom_column_ix $schema_ix;		
			}			
			START {
				set start_column_ix $schema_ix;			
			}	
			END {
				set end_column_ix $schema_ix;			
			}				
			default {
				if { [string first "LOCATION_UDA_" $schema_column] == 0 } {
					set offset_ix [string length "LOCATION_UDA_"];
					set uda_name [string range $schema_column $offset_ix [string length $schema_column]];
					lappend location_uda_list $uda_name;
					lappend location_uda_list_column_ix $schema_ix;
					if { [catch {location attribute get $uda_name base_type}] == 1 } {
						tool_constraints_error "despite $schema_column specified, $uda_name is not a valid UDA for location data object";
						return 0;					
					}
				} elseif { [string first "COMMODITY_UDA_" $schema_column] == 0 } {
					set offset_ix [string length "COMMODITY_UDA_"];
					set uda_name [string range $schema_column $offset_ix [string length $schema_column]];
					lappend commodity_uda_list $uda_name;
					lappend commodity_uda_list_column_ix $schema_ix;	
					if { [catch {com attribute get $uda_name base_type}] == 1 } {
						tool_constraints_error "despite $schema_column specified, $uda_name is not a valid UDA for commodity data object";
						return 0;					
					}	
				} elseif { [string first "COMLOCATION_UDA_" $schema_column] == 0 } {
					set offset_ix [string length "COMLOCATION_UDA_"];
					set uda_name [string range $schema_column $offset_ix [string length $schema_column]];
					lappend comlocation_uda_list $uda_name;
					lappend comlocation_uda_list_column_ix $schema_ix;	
					if { [catch {com@location attribute get $uda_name base_type}] == 1 } {
						tool_constraints_error "despite $schema_column specified, $uda_name is not a valid UDA for com@location data object";
						return 0;					
					}											
				} elseif { [string first "METHOD_UDA_" $schema_column] == 0 } {
					set offset_ix [string length "METHOD_UDA_"];
					set uda_name [string range $schema_column $offset_ix [string length $schema_column]];
					lappend method_uda_list $uda_name;
					lappend method_uda_list_column_ix $schema_ix;	
					if { [catch {method attribute get $uda_name base_type}] == 1 } {
						tool_constraints_error "despite $schema_column specified, $uda_name is not a valid UDA for method data object";
						return 0;					
					}	
				} elseif { [string first "RULE_" $schema_column] == 0 } {
					set offset_ix [string length "RULE_"];
					set rule_name [string range $schema_column $offset_ix [string length $schema_column]];
					lappend rule_list $rule_name;
					lappend rule_list_column_ix $schema_ix;							
				} else {
					tool_constraints_warning "column $schema_column in csv $csv_filename will be ignored";
				}
			}
		}
	}
	if { $case_column_ix < 0 } {
		tool_constraints_error "bad schema in csv $csv_filename - missing CASE column";
		return 0;	
	} elseif { $role_column_ix < 0 } {
		tool_constraints_error "bad schema in csv $csv_filename - missing ROLE column";
		return 0;	
	} elseif { [llength $rule_list] == 0 } {
		tool_constraints_error "bad schema in csv $csv_filename - missing RULE_# column(s)";
		return 0;	
	} elseif { $uom_column_ix < 0 } {
		tool_constraints_error "bad schema in csv $csv_filename - missing UOM column";
		return 0;		
	} elseif { $start_column_ix < 0 } {
		tool_constraints_error "bad schema in csv $csv_filename - missing START column";
		return 0;		
	} elseif { $end_column_ix < 0 } {
		tool_constraints_error "bad schema in csv $csv_filename - missing END column";
		return 0;	
	}
	if { $enabled_column_ix < 0 } {
		tool_constraints_warning "missing ENABLED column in csv $csv_filename - will presume all are enabled";
	}	
	if { $location_column_ix < 0 } {
		if { [llength $location_uda_list] == 0 } {
			tool_constraints_warning "missing LOCATION and LOCATION UDA columns in csv $csv_filename - will presume all";
		} else {
			tool_constraints_warning "missing LOCATION column in csv $csv_filename - will filter only by UDA";
		}
	}
	if { $commodity_column_ix < 0 } {
		if { [llength $commodity_uda_list] == 0 } {
			tool_constraints_warning "missing COMMODITY and COMMODITY UDA columns in csv $csv_filename - will presume all";
		} else {
			tool_constraints_warning "missing COMMODITY column in csv $csv_filename - will filter only by UDA";
		}	
	} 
	if { $comlocation_column_ix < 0 } {
		if { [llength $comlocation_uda_list] == 0 } {
			tool_constraints_warning "missing COMLOCATION and COMLOCATION UDA columns in csv $csv_filename - will presume all";
		} else {
			tool_constraints_warning "missing COMLOCATION column in csv $csv_filename - will filter only by UDA";
		}	
	} 
	if { $method_column_ix < 0 } {
		if { [llength $method_uda_list] == 0 } {
			tool_constraints_warning "missing METHOD and METHOD UDA columns in csv $csv_filename - will presume all";
		} else {
			tool_constraints_warning "missing METHOD column in csv $csv_filename - will filter only by UDA";
		}	
	}
	if { [llength $location_uda_list] == 0 && [llength $commodity_uda_list] == 0 && [llength $comlocation_uda_list] == 0 && [llength $method_uda_list] == 0 } {
		tool_constraints_warning "you have no UDA in your schema - remember they should be specified as <DATAOBJECT>_UDA_<NAME>; e.g. LOCATION_UDA_MYUDAID. Valid DATAOBJECT values are LOCATION, COMMODITY, COMLOCATION, or METHOD.";
	}
	set rule_number [llength $rule_list];
	
	# 2. process the target records (first pass of all csv records)
	#echo "2. process the target records (first pass of all csv records)";
	set defined_targets {};
	set defined_constraint_target_ids {};
	for { set record_ix 0 } { $record_ix < $record_number } {incr record_ix} {
		set record [lindex $raw_data $record_ix];
		
		# 2 a) collect the essential attributes of the record
		#echo "2 a) collect the essential attributes of the record $record_ix";
		set case [lindex $record $case_column_ix];
		if { $case != "" } {
			# case should be ignored according to consultant
			#echo "WARNING: record $record_ix has a non-empty case value - skipping it!";
			#continue;
		}		
		set role [lindex $record $role_column_ix];
		if { $role eq "GLOBAL" || $role eq "LOCAL" } {
			# we will deal with the actual sourcing ratio constraints in the next pass
			continue;
		}
		if { $role eq "-" || $role eq "" } {
			tool_constraints_error "record $record_ix has a blank ROLE when it needs to be GLOBAL, LOCAL or an alphanumeric target id - skipping it!";
			continue;		
		}
		if { [lsearch $defined_targets $role] >= 0 } {
			tool_constraints_error "record $record_ix has an invalid ROLE it attempts to redefine an existing target id - skipping it!";
			continue;
		}	

		# 2 b) create the constraint_target id to use
		#echo "2 b) create the constraint_target id to use $record_ix";
		# location-commodity-comlocation-method ordering with blanks/dont cares skipped
		set constraint_id "";
		set spacer "_";
		set appending 0;
		set uda_number [llength $location_uda_list];
		for { set uda_ix 0 } { $uda_ix < $uda_number } { incr uda_ix } {
			set substring_id [lindex $record [lindex $location_uda_list_column_ix $uda_ix]];
			if { !($substring_id == "" || $substring_id == $dontCare) } {
				if { $appending } {
					append constraint_id $spacer;
				}
				set appending 1;
				append constraint_id $substring_id;
			}
		}		
		if { $location_column_ix >= 0 } {
			set substring_id [lindex $record $location_column_ix];
			if { !($substring_id == "" || $substring_id == $dontCare) } {
				if { $appending } {
					append constraint_id $spacer;
				}
				set appending 1;			
				append constraint_id $substring_id;
			}
		}
		set uda_number [llength $commodity_uda_list];
		for { set uda_ix 0 } { $uda_ix < $uda_number } { incr uda_ix } {
			set substring_id [lindex $record [lindex $commodity_uda_list_column_ix $uda_ix]];
			if { !($substring_id == "" || $substring_id == $dontCare) } {
				if { $appending } {
					append constraint_id $spacer;
				}
				set appending 1;
				append constraint_id $substring_id;
			}
		}			
		if { $commodity_column_ix >= 0 } {
			set substring_id [lindex $record $commodity_column_ix];
			if { !($substring_id == "" || $substring_id == $dontCare) } {
				if { $appending } {
					append constraint_id $spacer;
				}
				set appending 1;			
				append constraint_id $substring_id;
			}
		}	
		set uda_number [llength $comlocation_uda_list];
		for { set uda_ix 0 } { $uda_ix < $uda_number } { incr uda_ix } {
			set substring_id [lindex $record [lindex $comlocation_uda_list_column_ix $uda_ix]];
			if { !($substring_id == "" || $substring_id == $dontCare) } {
				if { $appending } {
					append constraint_id $spacer;
				}
				set appending 1;
				append constraint_id $substring_id;
			}
		}		
		if { $comlocation_column_ix >= 0 } {
			set substring_id [lindex $record $comlocation_column_ix];
			if { !($substring_id == "" || $substring_id == $dontCare) } {
				if { $appending } {
					append constraint_id $spacer;
				}
				set appending 1;			
				append constraint_id $substring_id;
			}
		}
		set uda_number [llength $method_uda_list];
		for { set uda_ix 0 } { $uda_ix < $uda_number } { incr uda_ix } {
			set substring_id [lindex $record [lindex $method_uda_list_column_ix $uda_ix]];
			if { !($substring_id == "" || $substring_id == $dontCare) } {
				if { $appending } {
					append constraint_id $spacer;
				}
				set appending 1;
				append constraint_id $substring_id;
			}
		}		
		if { $method_column_ix >= 0 } {
			set substring_id [lindex $record $method_column_ix];
			if { !($substring_id == "" || $substring_id == $dontCare) } {
				if { $appending } {
					append constraint_id $spacer;
				}
				set appending 1;			
				append constraint_id $substring_id;
			}
		}	
		set sourcing_ratio_ct_id [format "%s_sr_ct" $constraint_id];
		if { [catch {constraint_target set id $sourcing_ratio_ct_id} ] == 0 } {
			tool_constraints_error "a constraint_target of id $sourcing_ratio_ct_id already exists. skipping this!";
			continue;
		}		

		# 2 c) add the "empty" sourcing_ratio constraint_target	
		#echo "2 c) add the empty sourcing_ratio constraint_target $record_ix";
		if { $errorCheckOnly == 0 } {
			constraint_target add $sourcing_ratio_ct_id;
			constraint_target set property sourcing_ratio;
		}
		lappend defined_targets $role;
		lappend defined_constraint_target_ids $sourcing_ratio_ct_id;		

		# 2 d) add the elements for the constraint targets
		#echo "2 d) add the elements for the constraint targets $record_ix";
		if { $errorCheckOnly == 0 } {
			set added_comlocation 0;
			set added_method 0;
			set uda_number [llength $location_uda_list];
			for { set uda_ix 0 } { $uda_ix < $uda_number } { incr uda_ix } {
				set uda_name [lindex $location_uda_list $uda_ix];
				set uda_value [lindex $record [lindex $location_uda_list_column_ix $uda_ix]];
				if { !($uda_value == "" || $uda_value == $dontCare) } {
					constraint_target set id $sourcing_ratio_ct_id;
					constraint_target elem add location "*";
					constraint_target elem set uda_name $uda_name;
					constraint_target elem set uda_value $uda_value;
					constraint_target elem set multiple conjunctive;
				}
			}		
			if { $location_column_ix >= 0 } {
				set required_id [lindex $record $location_column_ix];
				if { !($required_id == "" || $required_id == $dontCare) } {	
					constraint_target set id $sourcing_ratio_ct_id;
					constraint_target elem add location $required_id;
					constraint_target elem set multiple conjunctive;			
				} else {
					constraint_target set id $sourcing_ratio_ct_id;
					constraint_target elem add location "*";
					constraint_target elem set multiple conjunctive;			
				}
			}
			set uda_number [llength $commodity_uda_list];
			for { set uda_ix 0 } { $uda_ix < $uda_number } { incr uda_ix } {
				set uda_name [lindex $commodity_uda_list $uda_ix];
				set uda_value [lindex $record [lindex $commodity_uda_list_column_ix $uda_ix]];
				if { !($uda_value == "" || $uda_value == $dontCare) } {
					constraint_target set id $sourcing_ratio_ct_id;
					constraint_target elem add com "*";
					constraint_target elem set uda_name $uda_name;
					constraint_target elem set uda_value $uda_value;
					constraint_target elem set multiple conjunctive;
				}
			}			
			if { $commodity_column_ix >= 0 } {
				set required_id [lindex $record $commodity_column_ix];
				if { !($required_id == "" || $required_id == $dontCare) } {	
					constraint_target set id $sourcing_ratio_ct_id;
					constraint_target elem add com $required_id;
					constraint_target elem set multiple conjunctive;				
				} else {
					constraint_target set id $sourcing_ratio_ct_id;
					constraint_target elem add com "*";
					constraint_target elem set multiple conjunctive;			
				}
			}	
			set uda_number [llength $comlocation_uda_list];
			for { set uda_ix 0 } { $uda_ix < $uda_number } { incr uda_ix } {
				set uda_name [lindex $comlocation_uda_list $uda_ix];
				set uda_value [lindex $record [lindex $comlocation_uda_list_column_ix $uda_ix]];
				if { !($uda_value == "" || $uda_value == $dontCare) } {
					constraint_target set id $sourcing_ratio_ct_id;
					constraint_target elem add com@location "*";
					constraint_target elem set uda_name $uda_name;
					constraint_target elem set uda_value $uda_value;
					constraint_target elem set multiple conjunctive;
					incr added_comlocation;
				}
			}		
			if { $comlocation_column_ix >= 0 } {
				set required_id [lindex $record $comlocation_column_ix];
				if { !($required_id == "" || $required_id == $dontCare) } {	
					constraint_target set id $sourcing_ratio_ct_id;
					constraint_target elem add com@location $required_id;
					constraint_target elem set multiple conjunctive;	
					incr added_comlocation;
				}			
			} 
			if { $added_comlocation == 0 } {
				constraint_target set id $sourcing_ratio_ct_id;
				constraint_target elem add com@location "*";
				constraint_target elem set multiple conjunctive;				
			}		
			set uda_number [llength $method_uda_list];
			for { set uda_ix 0 } { $uda_ix < $uda_number } { incr uda_ix } {
				set uda_name [lindex $method_uda_list $uda_ix];
				set uda_value [lindex $record [lindex $method_uda_list_column_ix $uda_ix]];
				if { !($uda_value == "" || $uda_value == $dontCare) } {
					constraint_target set id $sourcing_ratio_ct_id;
					constraint_target elem add method "*";
					constraint_target elem set uda_name $uda_name;
					constraint_target elem set uda_value $uda_value;
					constraint_target elem set multiple conjunctive;
					incr added_method;
				}
			}		
			if { $method_column_ix >= 0 } {
				set required_id [lindex $record $method_column_ix];
				if { !($required_id == "" || $required_id == $dontCare) } {	
					constraint_target set id $sourcing_ratio_ct_id;
					constraint_target elem add method $required_id;
					constraint_target elem set multiple conjunctive;
					incr added_method;							
				}
			}
			if { $added_method == 0 } {
				constraint_target set id $sourcing_ratio_ct_id;
				constraint_target elem add method "*";
				constraint_target elem set multiple conjunctive;		
			}
		}
	}
	

	# 3. process the constraint records (second pass)
	set constraints {};
	set last_record_ix -1;
	set is_a_new_constraint 1;	
	set last_constraint_id "";
	set current_constraint_id "";
	set current_constraint {};
	
	for { set record_ix 0 } { $record_ix < $record_number } {incr record_ix} {
		set record [lindex $raw_data $record_ix];
		
		# 3 a) collect the essential attributes of the record
		#echo "3 a) collect the essential attributes of the record $record_ix";
		set case [lindex $record $case_column_ix];
		if { $case != "" } {
			# case should be ignored according to consultant
			#echo "WARNING: record $record_ix has a non-empty case value - skipping it!";
			#continue;
		}		
		set role [lindex $record $role_column_ix];
		if { !($role == "GLOBAL" || $role == "LOCAL") } {
			# we are only dealing with actual sourcing ratio constraints in this pass
			continue;
		}
		set start [lindex $record $start_column_ix];
		if { $start <= 0 } {
			tool_constraints_error "record $record_ix has an invalid START it must be 1 or greater - skipping it!";
			continue;			
		}
		set end [lindex $record $end_column_ix];
		if { $end == 0 } {
			tool_constraints_error "record $record_ix has an invalid END it must be 1 or greater or -1 - skipping it!";
			continue;				
		}	
		set enabled 1;
		if { $enabled_column_ix >= 0 } {
			set enabled [string toupper [lindex $record $enabled_column_ix]];
			if { $enabled == 1 || $enabled == "Y" || $enabled == "YES" || $enabled == "ON" || $enabled == "NA" || $enabled == "" || $enabled == $dontCare } {
				set enabled 1;
			} else {
				set enabled 0;
			}
		}			
		
		# 3 b) check if the record is representing a new constraint or it is a continuation of the previous constraint	
		# and also check that we have valid targets referenced.
		set current_constraint_id "";
		set substring_count 0;
		set error_found 0;
		set referenced_targets {};
		for { set rule_ix 0 } { $rule_ix < $rule_number && $error_found == 0 } { incr rule_ix } {
			set column_ix [lindex $rule_list_column_ix $rule_ix];
			set current_record_rule [lindex $record $column_ix];
			if { [string first ":" $current_record_rule] < 0 } {
				tool_constraints_error "record $record_ix has an invalid rule (missing colon) - skipping it!";
				set error_found 1;
				continue;				
			} elseif { [string first ">" $current_record_rule] < 0 && [string first "=" $current_record_rule] < 0 } {
				tool_constraints_error "record $record_ix has an invalid rule (missing > or =) - skipping it!";
				set error_found 1;
				continue;				
			}
			set pieces [split $current_record_rule :];
			if { [llength $pieces] <= 1 } {
				tool_constraints_error "record $record_ix has an invalid rule (missing colon?) - skipping it!";
				set error_found 1;
				continue;			
			}
			set current_target [lindex $pieces 0];
			if { !($current_target eq "-" || $current_target eq "") } {
				if { [lsearch $defined_targets $current_target] < 0 } {
					tool_constraints_error "record $record_ix references a target in a rule that has not been defined yet- skipping it!";
					set error_found 1;
					continue;						
				}
				lappend referenced_targets $current_target;
				if { $substring_count > 0 } {
					append current_constraint_id "_";
				}
				append current_constraint_id $current_target;
				incr substring_count;
			}
		}
		if { $error_found } {
			continue;
		}
		if { $substring_count == 0 } {
			tool_constraints_error "record $record_ix has no specified rules - skipping it!";
			continue;			
		}
		append current_constraint_id "_sr_c";
		# generate a unique current_constraint_id (there may be more than one by the given name)
		set root_id $current_constraint_id;
		set root_count 1;
		while { [catch {constraint set id $current_constraint_id}] == 0 } {
			set current_constraint_id [format "%s%d" $root_id $root_count];
			incr root_count;
		}
		set is_a_new_constraint 1;
		if { $last_record_ix >= 0 } {
			set last_record [lindex $raw_data $last_record_ix];
			# are these for the same constraint? Presume no.
			set is_a_new_constraint 0;
			if { $case_column_ix >= 0 && !([lindex $last_record $case_column_ix] eq [lindex $record $case_column_ix]) } {
				set is_a_new_constraint 1;
			} 
			# check the targets specified for the rules in use
			if { !($last_constraint_id eq $current_constraint_id) } {
				set is_a_new_constraint 1;
			}
		}
		set last_record_ix $record_ix;
		set last_constraint_id $current_constraint_id;	
		
		# 3 c) add the constraint or append this record to an existing constraint	
		#echo "3 c) add the constraint or append this record to an existing constraint $record_ix $rule_ix";
		# add the constraint item
		set constraint_item $record;	
		if { $is_a_new_constraint == 1 } {
			# finish off any existing constraint
			if { [llength $current_constraint] > 0 } {
				lappend current_constraint $constraint_items;
				lappend constraints $current_constraint;		
			}
			# we use the record itself to hold on to the attributes (we will ignore the CAPACITY START END columns since these will be appended in a list)
			set current_constraint $current_constraint_id;
			lappend current_constraint $referenced_targets;
			set constraint_items {};
		}	
		lappend constraint_items $constraint_item;			
	}
	# 3 d) don't forget to finish off the last constraint
	#echo "3 d) don't forget to finish off the last constraintt $record_ix";
	if { $is_a_new_constraint && [llength $current_constraint] > 0} {
		lappend current_constraint $constraint_items;
		lappend constraints $current_constraint;	
	}		
	
	
	# 4. Generate the constraints
	#echo "4. Generate the constraints";
	# (now we have a clean set of constraints in a list where each item in the list contains:
	#    1. the constraint_id to use
	#    2. the list of referenced targets
	#    3. the original record(s) for the constraint action elems)
	set constraint_number [llength $constraints];
	set day_time_levels [_get_time_level_boundaries $::tk_time_dim_id];
	set week_time_levels [_get_time_level_boundaries Week];
	set month_time_levels [_get_time_level_boundaries Month];
	set permitted_time_levels [_get_time_levels_defined];
	for { set constraint_ix 0 } { $constraint_ix < $constraint_number } { incr constraint_ix } {
		set current_constraint [lindex $constraints $constraint_ix];
		set current_constraint_id [lindex $current_constraint 0];
		set referenced_targets [lindex $current_constraint 1];
		# constraint_items will be a list of all of the csv records for this particular constraint
		set constraint_items [lindex $current_constraint 2];

		# 4 a) add the "empty" sourcing_ratio constraint	
		if { $errorCheckOnly == 0 } {
			constraint add $current_constraint_id;
			constraint set property sourcing_ratio;	
		}

		# 4 b) add the action elements (time-phased ratios) for the constraints
		set ratios $constraint_items;
		set ratio_number [llength $ratios];
		for { set ratio_ix 0 } { $ratio_ix < $ratio_number } { incr ratio_ix } {
			set record [lindex $ratios $ratio_ix];
			# get the time_levels to use
			set uom [lindex $record $uom_column_ix];
			if { [lsearch $permitted_time_levels $uom] >= 0 } {
				set time_levels [_get_time_level_boundaries $uom];
			} else {
				if { $uom == "WEEK" } {
					set time_levels $week_time_levels;
				} elseif { $uom == "MONTH" } {
					set time_levels $month_time_levels;
				} elseif { $uom == "DAY" } {
					set time_levels $day_time_levels;
				}
			}						

			# the start and end of the capacity is expressed in UNIX time (not indicies of the time_levels)
			set raw_start_time [lindex $current_capacity 0];
			set raw_end_time [lindex $current_capacity 1];
			# take a second away to ensure that there is no overlap
			# (actually not necessary)
			#incr raw_end_time -1;
			set index_number [llength $time_levels];
			set restricted_time_levels {};
			for { set ix 0 } { $ix < $index_number } { incr ix } {
				set current_time [lindex $time_levels $ix];
				set lower_current_time [lindex $current_time 0];
				set upper_current_time [lindex $current_time 1];
				# have we gone past the end of our capacity item?
				if { $raw_end_time > 0 && $lower_current_time >= $raw_end_time } {
					break;
				}	
				if { $raw_end_time > 0 && $upper_current_time >= $raw_end_time } {
					set upper_current_time $raw_end_time;
				}
				# have we not reached the start of our capacity item?
				if { $upper_current_time < $raw_start_time } {
					continue;
				}
				if { $lower_current_time < $raw_start_time } {
					set lower_current_time $raw_start_time;
				}
				if { $lower_current_time >= $upper_current_time } {
					# time period was cropped out of existence
					continue;
				}
				set adjusted_current_time [list $lower_current_time $upper_current_time];
				lappend restricted_time_levels $adjusted_current_time;
			}			
			if { [llength $restricted_time_levels] <= 0 } {
				tool_constraints_error "this constraint $constraint_ix has an empty capacity list for index $ratio_ix - skipping it!";
				continue;				
			}
			
			# calculate action_two
			set action_one "";
			for { set rule_ix 0 } { $rule_ix < $rule_number } { incr rule_ix } {
				set column_ix [lindex $rule_list_column_ix $rule_ix];
				set rule [string trim [lindex $record $column_ix]];
				if { $rule eq "-" || $rule eq "" } {
					continue;
				}
				set equality_ix [string first "=" $rule];
				if { $equality_ix >= 0 } {
					set rule [string replace $equality_ix $equality_ix $rule];
				}
				# replace the unnecessary equality symbol and trim left and right
				set rule [format "(%s)" $rule];
				append action_one $rule;
			}
			# action_two is blank
			set action_two "-";
			# calculate action_three
			set role [lindex $record $role_column_ix];
			if { $role eq "GLOBAL" } {
				set action_three "always global";
			} else {
				set action_three "always local";
			}
			
			if { $errorCheckOnly == 0 } {
				set time_length [llength $restricted_time_levels];
				for { set time_ix 0 } { $time_ix < $time_length } { incr time_ix } {
					set current_time [lindex $restricted_time_levels $time_ix];
					set time_start [lindex $current_time 0];
					set time_end [lindex $current_time 1];
					constraint set id $current_constraint_id;
					constraint action_elem add $time_start $time_end;
					constraint action_elem set action_one $action_one;
					constraint action_elem set action_two $action_two;
					constraint action_elem set action_three $action_three;
						
				}
			}	
		}	

		# 4 c) reference the constraint_target(s) in the constraint		
		set referenced_target_number [llength $referenced_targets];
		for { set referenced_target_ix 0 } { $referenced_target_ix < $referenced_target_number } { incr referenced_target_ix } {
			set referenced_target [lindex $referenced_targets $referenced_target_ix];
			set ct_ix [lsearch $defined_targets $referenced_target];
			if { $ct_ix < 0 } {
				tool_constraints_error "this constraint could not find a target called $referenced_target - skipping it!";
				continue;					
			}
			if { $errorCheckOnly == 0 } {
				set corresponding_ct_id [lindex $defined_constraint_target_ids $ct_ix];
				constraint set id $current_constraint_id;	
				constraint target_elem add $corresponding_ct_id;
				constraint target_elem set context_name $referenced_target;
			}
		}		
    }	

	# 5. refresh the cubes if needed
	#echo "5. refresh the cubes if needed";
	if { $errorCheckOnly == 0 } {
		tk_cube_model_init;
	}
	
	return 1;
}

