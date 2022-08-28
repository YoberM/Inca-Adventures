extends Menu


export(PackedScene) var levelScene
export(PackedScene) var settings


func _ready():
	var level = SceneLoader.load_scene(levelScene)
	SceneLoader.disable_scene(level,"Mapa")


func _on_Play_pressed():
	var scene_loader: SceneLoader = get_scene_loader()
	scene_loader.re_enable_scene("Mapa")

func _on_Options_pressed():
	var scene_loader: SceneLoader = get_scene_loader()
	scene_loader.disable_scene(self,"Main")
	scene_loader.load_scene(settings)

func _on_Exit_pressed():
	get_tree().quit()
