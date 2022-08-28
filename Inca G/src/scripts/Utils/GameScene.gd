class_name GameScene
extends Node


# TODO: Remove (deprecated)
func get_scene_loader() -> Node:
	return get_tree().root.get_node("SceneLoader")


func is_loaded() -> bool:
	return (get_parent() == _get_tree_node()
			&& get_parent() != null)


func _get_tree_node() -> Node:
	return get_tree().root.get_node("Main/GameTree")
