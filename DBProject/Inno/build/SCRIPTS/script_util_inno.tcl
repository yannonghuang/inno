

proc InitializeDBVars {} {
    global path errfp logfile datasrc uname pword load_tables constrained_solve_tables unconstrained_solve_tables fdate ftime
    global path errfp logfile datasrc uname pword load_tables constrained_solve_tables unconstrained_solve_tables fdate ftime
    #set path(main) "c:/Adexa/DEMOS/NON_INTEGRATED/FABLESS/SCP"
	set path(main) "w:";
    set path(data) "$path(main)/DATA"
    set path(error) "$path(main)/LOGS"
    set path(script) "$path(main)/SCRIPTS"
    set path(cases) "$path(main)/CASES"
    set logfile $path(error)/scp_log.txt

    set datasrc adx
    set uname sa
    set pword sunset@919325
    set load_tables _M2U
    set constrained_solve_tables _SOLVED
    set unconstrained_solve_tables _UNC

	set fdate [clock format [clock seconds] -format {%Y%m%d}]
}

proc load_model {} {
      global path datasrc uname pword load_tables fdate
	  InitializeDBVars
      #Connect to database
      uds opendb MS_SQL $datasrc $uname $pword
      uds case_id set $load_tables
      uds validate schema
      uds log_file set_name "$path(error)/uds_load_errors\_$fdate.csv"
      uds errors_allowed set 1000000
      #uds errors_allowed set 0
      uds load
      filepm save $path(cases)/RAW_DATA.data

      #Close database connection
      uds closedb
}

proc save_model {} {
	set uncSCEN_ID "UNC";
	set fName [filepm case_name];
	set fNameComponents [split $fName "_"];
	set MODEL_ID [lindex $fNameComponents 0];
	set SCEN_ID [lindex $fNameComponents 1];
	if {[string equal $SCEN_ID $uncSCEN_ID]} {
		save_model_unconstrained
	} else {
		save_model_constrained
	}
}

proc save_model_constrained {} {
     global path datasrc uname pword constrained_solve_tables fdate
	 #InitializeDBVars
     #Connect to database
     uds opendb MS_SQL $datasrc $uname $pword
	catch {uds case_id set $constrained_solve_tables}
	catch {uds case_id delete}
     uds case_id create $constrained_solve_tables
     uds get_sql_text delete_model execute
     uds case_id set $constrained_solve_tables
     uds validate schema
     catch {uds save all}

     #Close database connection
     uds closedb
}

proc save_model_unconstrained {} {
     global path datasrc uname pword constrained_solve_tables fdate
	  InitializeDBVars
     #Connect to database
     uds opendb MS_SQL $datasrc $uname $pword
     uds case_id set $unconstrained_solve_tables
     uds case_id delete
     uds case_id create $constrained_solve_tables
     uds get_sql_text delete_model execute
     uds case_id set $constrained_solve_tables
     uds validate schema
     catch {uds save all}

     #Close database connection
     uds closedb
}