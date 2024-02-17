#################################################################
#								#
#	This Script File Contains the Following Procedures	#
#	Import_BOM						#                         
#								#
#################################################################

#############################################################################################
#
# Building Bill of Material
#
##############################################################################################

proc compare {a b} {	
    set aKey [lindex $a 0]
    set bKey [lindex $b 0]
    if {$aKey < $bKey} {
        return -1
    } elseif {$aKey > $bKey} {
        return 1
    } else {
        return 0
    }
}

proc mysearch {lst idx value} {
    set i 0
    foreach sublist $lst {
        if {[string equal [lindex $sublist $idx] $value]} {
            return $i
        }
        incr i
    }
    return -1
}

proc prt {lst} {
    set i 0
    foreach sublist $lst {
		echo "$i: [lindex $sublist 0]"
        incr i
    }
}

proc sub_lappend {listname idx args} {
    upvar 1 $listname l
    set subl [lindex $l $idx]
    lappend subl $args
    lset l $idx $subl	
}


#array set altBomParent {}
proc Import_BOM {} {
	global path;
	global altBom altBomChild;
	global altBomParent;
	
	set fp [open "$path(data)/adx_bom_inno.csv" r]
	gets $fp;
	#set altBomParent {};
	array set altBomParent {};
	set altBomChild {};
	set altBom {};
	
	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,]
		#echo "bom: $linestring";
		set bomId [lindex $linestring 0];
		set loc [lindex $linestring 1];
		set parent [lindex $linestring 2];
		set altgrp [lindex $linestring 3]
		set pref [lindex $linestring 4];
		set elem [lindex $linestring 5];
		set comId [lindex $linestring 6];
		set new_supply [lindex $linestring 7]
		set grade [lindex $linestring 8]	
		set consrate [lindex $linestring 9]
		set batch_size [lindex $linestring 10]
		set effstart [lindex $linestring 11]
		set effend [lindex $linestring 12]
		
		set obsolete [lindex $linestring 13]
		
		if {$altgrp != "-"} {
			#set BomId $bomId; YNH
			set BomId [format "%s_%s" $bomId $altgrp]; 
			
			#set idx [lsearch $altBomParent $parent];
			#set idx [mysearch $altBomParent 0 $parent]
			set rList [array get altBomParent $parent]
			if {[llength $rList] == 0} {
				#lappend $altBomParent {$parent $BomId}
				#lappend altBomParent [list $parent $BomId]
				#array set altBomParent {$parent {$BomId}}
				set altBomParent($parent) [list $BomId]

			} else {
				#lappend [lindex $altBomParent $idx] $BomId;
				#sub_lappend altBomParent $idx $BomId;
				#set t [lappend [lindex $rList 1] $BomId]
				set t [lappend altBomParent($parent) $BomId]				
				#array set altBomParent {$parent $t}
				set altBomParent($parent) $t				
			}
			
			lappend altBomChild $comId;
		} else {
			set BomId $bomId;
		}
		catch {bom add $BomId}
		bom set id $BomId

		if {[catch {bom elem add $comId}] == 0} {
			if {$consrate != "-"} {
				if {[expr $consrate - floor($consrate)] > 0} {
					bom elem set consumption_mode "continuous"
					bom elem set rate $consrate;
				} else {
					bom elem set consumption_mode "discrete";
					bom elem set rate [expr int($consrate)];
				}
			}
			if {$batch_size != "-"} {
				bom set batch_size $batch_size
			}
			if {$grade != "-"} {
				#bom elem set grade $grade
				#echo "...[bom get id] bom adds grade set $grade"
				bom elem set grade 1
				bom elem set grade_set $grade
			}
			
			if {$obsolete != "-"} {
				bom elem set obsolete 1
			}
			
			# TBA: effectivity dates in date1 format
		} else {
			scp_log "BoM $BomId : Element $comId cannot be added to BoM "
		}

	}
	close $fp
	
	#set altBomParent [lsort -command compare $altBomParent]
}

