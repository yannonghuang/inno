proc Create_PerMgrs {} {
    # Creating period managers
    echo "Creating Period Managers"

    set end [cal horizon get end]

   # set one_monday [cast date1 time 1998/06/01]
    set one_mon "2023/12/04 00:00:00"
    set one_monday [cast date3 time $one_mon]


    ### 1. Default -- combination
    cal period_mgr add SCP
    cal period_mgr set default SCP
    #cal period_mgr set id default

    set start [cal horizon get start]
    set daily_num 35
    set weekly_num 21
    set monthly_num 0

    set daily_ix 0
    while {($daily_ix < $daily_num) && ([expr $start + 86400] < $end)} {

        set start [expr $start + 86400]
      #  set start [cast date1 time [cast time date1 [expr $start + 3600]]]

        cal period add $start
        incr daily_ix
    }
    ### This will extend the daily to the first monday
#    while  {[expr ($start-$one_monday)%(7*86400)] != 0
#        && ([expr ($start-$one_monday)%(7*86400)] != 3600)
#        && ([expr $start + 86400] < $end)} {
#        set start [expr $start + 86400]
#        set start [cast date1 time [cast time date1 [expr $start + 3600]]]
#        cal period add $start
#    }
    set weekly_ix 0
    while {($weekly_ix < $weekly_num) && ([expr $start+(7*86400)] < $end)} {
        set start [expr $start + (7*86400)]
        #set start [cast date1 time [cast time date1 [expr $start + 3600]]]
        cal period add $start
        incr weekly_ix
    }
    set monthly_ix 0
    while {($monthly_ix < $monthly_num) && ([expr $start+(28*86400)] < $end)} {
        set start [expr $start + (28*86400)]
        #set start [cast date1 time [cast time date1 [expr $start + 3600]]]
        cal period add $start
        incr monthly_ix
    }
}
proc Create_Inv_PerMgrs {} {
    # Creating period managers
    echo "Creating Com@Location Period Manager"

    set end [cal horizon get end]

   # set one_monday [cast date1 time 1998/06/01]
    set one_mon "2023/12/04 00:00:00"
    set one_monday [cast date3 time $one_mon]


    ### 1. Default -- combination
    cal period_mgr add DAILY_PM

    set start [cal horizon get start]
    set daily_num 250
    set weekly_num 0
    set monthly_num 0

    set daily_ix 0
    while {($daily_ix < $daily_num) && ([expr $start + 86400] < $end)} {

        set start [expr $start + 86400]
      #  set start [cast date1 time [cast time date1 [expr $start + 3600]]]

        cal period add $start
        incr daily_ix
    }
    ### This will extend the daily to the first monday
#    while  {[expr ($start-$one_monday)%(7*86400)] != 0
#        && ([expr ($start-$one_monday)%(7*86400)] != 3600)
#        && ([expr $start + 86400] < $end)} {
#        set start [expr $start + 86400]
#        set start [cast date1 time [cast time date1 [expr $start + 3600]]]
#        cal period add $start
#    }
    set weekly_ix 0
    while {($weekly_ix < $weekly_num) && ([expr $start+(7*86400)] < $end)} {
        set start [expr $start + (7*86400)]
        #set start [cast date1 time [cast time date1 [expr $start + 3600]]]
        cal period add $start
        incr weekly_ix
    }
    set monthly_ix 0
    while {($monthly_ix < $monthly_num) && ([expr $start+(28*86400)] < $end)} {
        set start [expr $start + (28*86400)]
        #set start [cast date1 time [cast time date1 [expr $start + 3600]]]
        cal period add $start
        incr monthly_ix
    }
    
    for {set i 0} {$i < [inv get number]} {incr i} {
        inv set ix $i
        inv set period_mgr DAILY_PM
    }
}
