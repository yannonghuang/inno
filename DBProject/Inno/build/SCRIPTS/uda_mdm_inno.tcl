proc Build_UDA {} {
	global errfp model path
	#
   	set fp [open "$path(data)/adx_uda_inno.csv" r]
   	gets $fp
	#
   	while {[gets $fp linestring] > 0} {
		if {$linestring eq {}} {
			continue; #blank line
		}
		set linestring [split $linestring ,];
		set Group [lindex $linestring 0];
		set Name [lindex $linestring 1];
		set Type [lindex $linestring 2];

		if {$Group == "BOM_0"} {
			if {$Type == "String"} {
				catch {bom attribute add_string $Name};
			}
		}
		if {$Group == "CONSTRAINT_0"} {
			if {$Type == "String"} {
				catch {constraint attribute add_string $Name};
			}
		}
		if {$Group == "CUSTOMER_0"} {
			if {$Type == "String"} {
				catch {customer attribute add_string $Name};
			}
		}
		if {$Group == "DEMANDS_0"} {
			if {$Type == "String"} {
				catch {demand attribute add_string $Name};
			}
		}
		if {$model(solver) == "scp" && $Group == "LOCATION_0"} {
			if {$Type == "String"} {
				catch {location attribute add_string $Name};
			}
		}
		if {$Group == "METHOD_0"} {
			if {$Type == "String"} {
				catch {method attribute add_string $Name};
			} elseif {$Type == "Cost"} { 
				catch {};method attribute add_cost $Name;
				method attribute set $Name max 1000000000;
			} elseif {$Type == "Integer"} { 
				catch {method attribute add_integer $Name};
				method attribute set $Name max 1000000000;
			}
		}
		if {$Group == "PRODLOC_0"} {
			if {$Type == "String"} {
				catch {com@location attribute add_string $Name};
			}
			if {$Type == "Integer"} {
				catch {com@location attribute add_integer $Name};
				com@location attribute set $Name max 9999999999
			}
			if {$Type == "Number"} {
				catch {com@location attribute add_float $Name};
				com@location attribute set $Name max 9999999999
			}
			if {$Type == "Cost"} {
				catch {com@location attribute add_cost $Name};
				com@location attribute set $Name max 1000000000;
			}			
		}
		if {$Group == "PRODUCT_0"} {
			if {$Type == "String"} {
				catch {com attribute add_string $Name};
			}
			if {$Type == "Integer"} {
				catch {com attribute add_integer $Name};
				com attribute set $Name max 9999999999
			}
		}
		if {$Group == "RESOURCE_0"} {
			if {$Type == "String"} {
				catch {res attribute add_string $Name};
			}
		}
		if {$Group == "SUPPLY_0"} {
			if {$Type == "String"} {
				catch {supply attribute add_string $Name};
			} elseif {$Type == "Cost"} { 
				catch {supply attribute add_cost $Name};
				supply attribute set $Name max 1000000000;
			}
		}
		if {$Group == "VENDOR_0"} {
			if {$Type == "String"} {
				catch {vendor attribute add_string $Name};
			}
		}
		if {$Group == "WIP_0"} {
			if {$Type == "String"} {
				catch {lot attribute add_string $Name};
			} elseif {$Type == "Cost"} { 
				catch {lot attribute add_cost $Name};
				lot attribute set $Name max 1000000000;
			}
		}

		if {$Group == "No"} {
			com attribute set END_ITEM max 1
			res attribute add_string root_cause_count
			res attribute add_string first_late_demand	
			supply attribute add_string HIER_LEVEL_1
			supply attribute add_string HIER_LEVEL_2
			supply attribute add_string HIER_LEVEL_3
			supply attribute add_string root_cause_count
			supply attribute add_string first_late_demand
			lot attribute add_string UDA_CAPACITY_GROUP	
			lot attribute add_string root_cause_count
			lot attribute add_string first_late_demand
		}
	}
  	close $fp
}