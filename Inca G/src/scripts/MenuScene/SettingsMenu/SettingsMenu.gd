extends Menu


export(Array,NodePath) var submenu_paths
export(NodePath) var sections_path

var _current_submenu: Node
var _current_section: int


func _on_BackButton_pressed():
	if SceneLoader.scene_is_disabled("Main"):
		SceneLoader.clean_tree()
		SceneLoader.re_enable_scene("Main")
	else:
		SceneLoader.clean_scene(self)
