#source C:/Adexa/demos/fbdemo/SCRIPTS/model_tool.tcl

proc add_wip {} {
	lot add grade-wip;
	lot set com@location "DIE4@ASSY-M2";
	lot set status waiting_after;
	lot set qty 1073;
	lot set wip_qty 1073;
	lot set due [cal horizon get start];
	lot attribute_value set GradeDecomposition "1, 1051;2, 22";
}
#
proc e2a_date {excelDate} {
	set dList [split $excelDate "/"];
	set month [lindex $dList 0]
	if {[string length $month] == "1"} {
		set month 0$month
	}
	set day [lindex $dList 1]
	if {[string length $day] == 1} {
		set day 0$day
	}
	set year [lindex $dList 2]
	return [format "%s/%s/%s" $year $month $day];
}
#
proc e2_date {excelDate} {
	set dList [split $excelDate "/"];
	set month [lindex $dList 0]
	if {[string length $month] == "1"} {
		set month 0$month
	}
	set day [lindex $dList 1]
	if {[string length $day] == 1} {
		set day 0$day
	}
	set year [lindex $dList 2]
	return [format "%s/%s/%s" $year $month $day];
}
proc cons_set_complex_uda {cnstr_id c_grp id_uda_complex id_uda_d} {
	# build constraint target
    if {[catch {constraint_target add $cnstr_id}] == 1} {
        echo "Constraint: $cnstr_id-$c_grp: Constraint already exist."
        return
    }
	constraint_target set property complex_uda
	# build constraint target elem
	constraint_target elem add $c_grp "*"
	constraint_target elem set uda_name "-"
	constraint_target elem set uda_value "-"
	# build constraint 
	echo ">>>>> add constraint: $cnstr_id";
	constraint add $cnstr_id
	constraint set property complex_uda
	# build constraint elem
	constraint target_elem add $cnstr_id
	# build constraint action elem
	constraint action_elem add "-" "-"
	constraint action_elem set action_one $id_uda_complex
	constraint action_elem set action_two ": ;"
	constraint action_elem set action_three $id_uda_d
}
#
proc cons_set_uda_match_ct {cnstr_trg_id consumeGrp cUdaName cUdaValue cOrder} {
	echo "......add ct-elem ct=$cnstr_trg_id,grp=$consumeGrp";
	# build constraint target
    if {[catch {constraint_target add $cnstr_trg_id}] == 1} {
		constraint_target set id $cnstr_trg_id;
	} else {
		constraint_target set property uda_match;
	}
	echo 
	# build constraint target elem
    constraint_target elem add $consumeGrp "*";
    constraint_target elem set uda_name $cUdaName;
    constraint_target elem set uda_value $cUdaValue;
    constraint_target elem set multiple disjunctive;
	if {$cOrder != "-"} {
		constraint_target elem set order $cOrder;
	}
}
#
proc cons_set_uda_match {cnstr_id cnstr_trg_id id_uda_complex id_uda_d id_uda} {
	echo "......add c-t-elem c=$cnstr_id,ct=$cnstr_trg_id";
	# build constraint 
    if {[catch {constraint add $cnstr_id}]} {
		constraint set id $cnstr_id;
    } else {
		constraint set property uda_match;
		# build constraint action elem
		constraint action_elem add "-" "-";
		constraint action_elem set action_one $id_uda_complex;
		constraint action_elem set action_two "($id_uda_d=$id_uda)";
		constraint action_elem set action_three "-";
	}
	# build constraint elem
	constraint target_elem add $cnstr_trg_id;
}
#
proc udaMatchConstraintTemplate {consKey ifPegging ifMethodChoice} {
	echo "......set demand constraint";
	set id_uda $consKey;
    set id_uda_complex [format "%s_S" $consKey];
    set id_uda_d [format "%s_d" $id_uda];
	# build constraint target ---> demand
	# --- complex uda - mto demand
    set cnstr_id [format "%s_dm_c" $id_uda_complex];
	cons_set_complex_uda $cnstr_id demand $id_uda_complex $id_uda_d;
    set cnstr_id [format "%s_lot_c" $id_uda_complex];
	cons_set_complex_uda $cnstr_id workorder $id_uda_complex $id_uda_d;
	#
	if {$ifPegging} {
		echo "......set uda match constraints - demand";
		# --- uda match - demand to lot/supply
		set cnstr_id [format "%s_m_d_c" $id_uda_complex];
		set cnstr_trg_id [format "%s_m_dl_ct" $id_uda_complex];
		cons_set_uda_match_ct $cnstr_trg_id demand - - -;
		cons_set_uda_match_ct $cnstr_trg_id workorder - - -;
		cons_set_uda_match $cnstr_id $cnstr_trg_id $id_uda_complex $id_uda_d $id_uda;
		set cnstr_trg_id [format "%s_m_ds_ct" $id_uda_complex];
		cons_set_uda_match_ct $cnstr_trg_id demand - - -;
		cons_set_uda_match_ct $cnstr_trg_id supply - - -;
		cons_set_uda_match $cnstr_id $cnstr_trg_id $id_uda_complex $id_uda_d $id_uda;
		echo "......set uda match constraints - lot";
		# --- uda match - lot to lot/supply
		set cnstr_id [format "%s_m_l_c" $id_uda_complex];
		set cnstr_trg_id [format "%s_m_ll_ct" $id_uda_complex];
		cons_set_uda_match_ct $cnstr_trg_id workorder - - 1;
		cons_set_uda_match_ct $cnstr_trg_id workorder - - 2;
		cons_set_uda_match $cnstr_id $cnstr_trg_id $id_uda_complex $id_uda_d $id_uda;
		set cnstr_trg_id [format "%s_m_ls_ct" $id_uda_complex];
		cons_set_uda_match_ct $cnstr_trg_id workorder - - -;
		cons_set_uda_match_ct $cnstr_trg_id supply - - -;
		cons_set_uda_match $cnstr_id $cnstr_trg_id $id_uda_complex $id_uda_d $id_uda;
	}
	#
	if {$ifMethodChoice} {
		echo "......set uda match constraints - method";
		# --- uda match - demand/lot ro method
		set cnstr_id [format "%s_m_m_c" $id_uda_complex];
		set cnstr_trg_id [format "%s_m_dm_ct" $id_uda_complex];
		cons_set_uda_match_ct $cnstr_trg_id demand - - -;
		cons_set_uda_match_ct $cnstr_trg_id method - - -;
		cons_set_uda_match $cnstr_id $cnstr_trg_id $id_uda_complex $id_uda_d $id_uda;
		set cnstr_trg_id [format "%s_m_lm_ct" $id_uda_complex];
		cons_set_uda_match_ct $cnstr_trg_id workorder - - -;
		cons_set_uda_match_ct $cnstr_trg_id method - - -;
		cons_set_uda_match $cnstr_id $cnstr_trg_id $id_uda_complex $id_uda_d $id_uda;
		# --- uda match - bom ro method?
	}
	return;
}
#
proc config_constraint {pArea} {
	# consKey, ifPegging, ifMethodChoice
	udaMatchConstraintTemplate "ALLOCATION" 1 0;
	#udaMatchConstraintTemplate "DEMAND_ID" 1 0;
	udaMatchConstraintTemplate "WIRE_COLOR" 1 1; ## DATA_RATE
	#udaMatchConstraintTemplate "CUST_ID" 1 0;
	udaMatchConstraintTemplate "FAB_LOC" 1 1;    ## FACTORY_LOC
	udaMatchConstraintTemplate "ASSY_LOC" 1 1;   ## SUBCON_LOC
	#udaMatchConstraintTemplate "DM_SPEC" 1 0;
}
