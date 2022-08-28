extends Node


var default_scene: PackedScene = load("res://src/scenes/MenuScene/MainMenu.tscn")
var disable_scenes: Dictionary
var game_tree: Node


func _exit_tree():
	for scene in disable_scenes:
		(disable_scenes[scene] as GameScene).queue_free()


func _on_GameTree_ready(game_tree: Node) -> void:
	self.game_tree = game_tree
	load_scene(default_scene)


func restart_tree():
	clean_tree()
	for id in disable_scenes.keys():
		destroy_disabled_scene(id)
	load_scene(default_scene)

# load a packedScene
func load_scene(scene: PackedScene) -> GameScene:
	var scene_instance: GameScene = scene.instance()
	game_tree.add_child(scene_instance)
	return scene_instance


# only remove the scene from the tree and hold the instance with an scene_id
func disable_scene(game_scene: GameScene,scene_id: String) -> int:
	if (not game_scene.is_loaded()):
		return ERR_DOES_NOT_EXIST
	if (disable_scenes.has(scene_id)):
		return ERR_ALREADY_IN_USE
	disable_scenes[scene_id] = game_scene
	game_tree.remove_child(game_scene)
	return OK


# bring back a disabled scene with his scene_id
func re_enable_scene(scene_id: String) -> int:
	if (not disable_scenes.has(scene_id)):
		return ERR_DOES_NOT_EXIST
	
	game_tree.add_child(disable_scenes[scene_id])
	disable_scenes.erase(scene_id)
	return OK


# if scene disabled exists
func scene_is_disabled(scene_id: String) -> bool:
	return disable_scenes.has(scene_id)


func destroy_disabled_scene(scene_id: String) -> void:
	if disable_scenes.has(scene_id):
		disable_scenes[scene_id].queue_free()
		disable_scenes.erase(scene_id)
	

# clean a GameScene from the tree
func clean_scene(game_scene: GameScene) -> void:
	game_tree.remove_child(game_scene)
	game_scene.queue_free()


# clean all GameScene currently running
func clean_tree() -> void:
	for child in game_tree.get_children():
		child.queue_free()
