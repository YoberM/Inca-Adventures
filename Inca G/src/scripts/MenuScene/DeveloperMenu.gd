extends Menu


export(PackedScene) var main_menu
export(PackedScene) var asulcons
export(PackedScene) var miscrits
export(PackedScene) var poroto
export(PackedScene) var paco


func _on_RunGame_pressed():
	var scene_loader: SceneLoader = get_scene_loader()
	scene_loader.clean_tree()
	scene_loader.load_scene(main_menu)


func _on_AsulconS_pressed():
	var scene_loader: SceneLoader = get_scene_loader()
	scene_loader.clean_tree()
	scene_loader.load_scene(asulcons)


func _on_Miscrits_pressed():
	var scene_loader: SceneLoader = get_scene_loader()
	scene_loader.clean_tree()
	scene_loader.load_scene(miscrits)


func _on_Poroto_pressed():
	var scene_loader: SceneLoader = get_scene_loader()
	scene_loader.clean_tree()
	scene_loader.load_scene(poroto)


func _on_Paco_pressed():
	var scene_loader: SceneLoader = get_scene_loader()
	scene_loader.clean_tree()
	scene_loader.load_scene(paco)
