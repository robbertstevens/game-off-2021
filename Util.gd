extends Node


const GROUP_BUGS = "bugs"


var level_score := 0
var total_score := 0
var max_score := 0
var total_restarts := 0


func object_has_signal(object: Object, signal_name: String) -> bool:
	var list = object.get_signal_list()
	
	for signal_entry in list:
		if signal_entry["name"] == signal_name:
			return true
		
	return false
