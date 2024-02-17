proc Import_Safety_Stock {} {
   	global errfp path

   	set fp [open "$path(data)/adx_safety_stock.csv" r]
   	gets $fp
   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		set Prod [lindex $linestring 0]
		set Loc [lindex $linestring 1]
		set SS_start [lindex $linestring 2]
		set SS_End [lindex $linestring 3]
		set Qty [lindex $linestring 4]

        if {$SS_start == "-"} {
          		set SS_start [cal horizon get start]
        } else {  
        	echo "Safety start $SS_start"
			set SS_start [cast date1 time $SS_start]
		} 
        if {$SS_End == "-"} {
        	set SS_End [cal horizon get end]
        } else {
			set SS_End [cast date1 time $SS_End]
		}
        inv set id $Prod\@$Loc
		com@location safety add $SS_start $SS_End 1 $Qty 999 1
   	}
   	close $fp;
}