#############################################################
#	This Script File Contains the Following Procedures
#
#	Build_BOG										#
#
#############################################################

proc Build_BOG {} {

   	global errfp path

   	set fp [open "$path(data)/adx_bog.csv" r]
   	gets $fp
	
	set boglist ""

   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		echo "BOG:$linestring";
		set BoGId [lindex $linestring 0]
		set prodid [lindex $linestring 1]
		set locid [lindex $linestring 2]
		set gradeNum [lindex $linestring 3]
		set Grade [lindex $linestring 4]
		set Rate [lindex $linestring 5]
		# BOG
		if {[lsearch $boglist $BoGId] == -1} {
			lappend boglist $BoGId
			bog add $BoGId
		} else {
			bog set id $BoGId
		}
		if { $Grade != "-" } {
	   		if {$Rate != "-"} {
				bog elem add $Grade $Rate
			}
		}
		# Com Grade
		echo "--->$prodid@$locid";
 		com@location set id "$prodid@$locid";
	   	com@location set grade_number $gradeNum;
		com@location grade set rank $Grade;
	   	com@location grade set ix [expr $Grade - 1];
		#com@location grade set name $GradeName; #use default: GradeNum
  	}
   	close $fp
}
