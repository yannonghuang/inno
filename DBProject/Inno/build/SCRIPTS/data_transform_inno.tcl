#################################################################
#								#
#	This Script File Contains the Following Procedures	#
#	Transform_BOM						#                         
#								#
#################################################################

#############################################################################################
#
# Transform Innolight data file to Adexa tab;es
#
##############################################################################################

proc Transform_BOM {} {
	global path;
	set fp [open "$path(data)/aoc_part1_format2.csv" r]
	gets $fp;
    set l_parts {}
	set count 0
	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {continue}; #blank line		
		set linestring [split $linestring ,]
		#echo "bom: $linestring";
		set site [lindex $linestring 0];
		set part [lindex $linestring 1];
		set p_desc [lindex $linestring 2];
		set alt [lindex $linestring 3]
		set pref [lindex $linestring 4];
		set parent [lindex $linestring 5];
		set child [lindex $linestring 6];
		set revision [lindex $linestring 7]
		set c_desc [lindex $linestring 8]	
		set category [lindex $linestring 9]
		set qty [lindex $linestring 10]
		set unit [lindex $linestring 11]
		set properties [lindex $linestring 12]
		set delivery_time [lindex $linestring 13]
		
		if {$qty eq 0} {continue}; #skip 
		echo ...$qty
		if {[lsearch $l_parts $part] < 0} {
			lappend l_parts $part
			set part_desc($part) $p_desc
		}

		if [catch {set l_parents($part)}] {set l_parents($part) {}}
		if {[lsearch $l_parents($part) $parent] < 0} {
			lappend l_parents($part) $parent
		}
		
		if [catch {set l_parent_child($part.$parent)}] {set l_parent_child($part.$parent) {}}
        lappend l_parent_child($part.$parent) $child
		set child_desc($child) $c_desc
		set use_qty($part.$parent.$child) $qty
		
		incr count; if {$count > 100} {break}
	}
	close $fp
	
	echo $l_parent_child($part.$parent)
	
	foreach part $l_parts {
	  echo $part..$part_desc($part)
	  foreach parent $l_parents($part) {	    
		foreach child $l_parent_child($part.$parent) {
		  echo .$parent..$child..$child_desc($child)..$use_qty($part.$parent.$child)
		}
	  }
	}
}

