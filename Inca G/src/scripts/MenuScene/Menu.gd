class_name Menu
extends GameScene


var options_map: Array


func map_option(setting: int, display_node: Node) -> void:
	options_map.append({
		'setting' : setting,
		'display_node' : display_node,
	})
