#############################################################
#									#
#	This Script File Contains the Following Procedures	        #
#									#
#	Build_WIP2							#							#
#									#
#############################################################


proc Import_Workorder {} {

   	#  THIS PROCEDURE ADDS THE SAME LOT AS WIP AND AS SUPPLY

   	global errfp path

   	set fp [open "$path(data)/adx_workorder.csv" r]
   	gets $fp

   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]

		set lotid [lindex $linestring 0]
		set partid [lindex $linestring 1]
		set loc [lindex $linestring 2]
		set lot_status [lindex $linestring 3]
		set lotdue [lindex $linestring 4]
		set qty [lindex $linestring 5]
		set Cost [lindex $linestring 6];
		set opOverridetype [lindex $linestring 7];
		set assyLoc [lindex $linestring 8];
		set fabLoc [lindex $linestring 10];
		set wireColor [lindex $linestring 11];
		set alloc [lindex $linestring 12];
		#set BIN1 [lindex $linestring 7]
		#set Qty1BIN2 [lindex $linestring 8]
		#set Qty2BIN3 [lindex $linestring 9]
		#set Qty3 [lindex $linestring 10]
        	
		lot add $lotid
		lot set com@location "$partid\@$loc"
		lot set status $lot_status
		lot set qty $qty;
		catch {lot set wip_qty $qty};
		lot set due [cal horizon get start]
		#catch {lot set due $lot_due}
		if {$Cost != "-"} {
			lot set cost $Cost;
		}
		if {$opOverridetype != "-"} {
			lot attribute_value set OpOverrideType $opOverridetype;
		}
		if {$assyLoc != "-"} {
			lot attribute_value set ASSY_LOC $assyLoc;
		}
		if {$fabLoc != "-"} {
			lot attribute_value set FAB_LOC $fabLoc;
		}
		if {$wireColor != "-"} {
			lot attribute_value set WIRE_COLOR $wireColor;
		}
		if {$alloc != "-"} {
			lot attribute_value set ALLOCATION $alloc;
		}
		#lot attribute_value set GradeDecomposition $BIN1\,\ $Qty1BIN2\,\ $Qty2BIN3\,\ $Qty3
	}
	close $fp
}

