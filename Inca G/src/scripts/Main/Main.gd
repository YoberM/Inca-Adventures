extends Node


signal tree_ready(game_tree)


func _init():
	SM._apply_settings()


func _ready():
	connect("tree_ready", SceneLoader, "_on_GameTree_ready")
	emit_signal("tree_ready", $GameTree)
