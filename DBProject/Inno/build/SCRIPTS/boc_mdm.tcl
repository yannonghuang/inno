#############################################################
#	This Script File Contains the Following Procedures
#
#	Build_BOC										#
#
#############################################################

proc Build_BOC {} {

   global errfp path

   set fp [open "$path(data)/ADEXA_BOC.csv" r]
   gets $fp
   set boclist ""

   while {[gets $fp linestring] > 0} {

		if {$linestring eq {}} {
			continue; #blank line
		}
	set linestring [split $linestring ,]

	set BoCId [lindex $linestring 0]
	set Grade [lindex $linestring 1]
	set Rate [lindex $linestring 2]
	set ComId [lindex $linestring 3]

        if {[lsearch $boclist $BoCId] == -1} {
            lappend boclist $BoCId
            boc add $BoCId
       } else {
           boc set id $BoCId
       }
           if { $Grade != "-" } {
	   	if {$Rate != "-"} {
                   boc elem add $ComId $Grade $Rate
	        }
           }
   }
   close $fp
}
