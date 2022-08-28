extends Menu


export(PackedScene) var test_scene


func _ready() -> void:
	SceneLoader.clean_tree()
	SceneLoader.load_scene(test_scene)
