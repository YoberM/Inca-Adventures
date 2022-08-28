extends Camera2D

export(NodePath) var character

func _process(delta):
	position = get_node(character).position
