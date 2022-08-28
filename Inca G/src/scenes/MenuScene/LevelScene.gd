extends Menu

export(PackedScene) var game

func _ready():
	pass
	

func _on_Chinchaysuyo_pressed():
	if SceneLoader.scene_is_disabled("Main"):
		var sceneLoader: SceneLoader = get_scene_loader()
		sceneLoader.disable_scene(self,"Mapa")
		SceneLoader.destroy_disabled_scene("Main")
		sceneLoader.load_scene(game)
	else:
		SceneLoader.disable_scene(self,"Mapa")
		SceneLoader.clean_tree()
		SceneLoader.load_scene(game)

func _on_Close_pressed():
	SceneLoader.disable_scene(self,"Mapa")
		

func _on_LevelScene_tree_entered():
	$Control/AnimationPlayer.play("Open")
