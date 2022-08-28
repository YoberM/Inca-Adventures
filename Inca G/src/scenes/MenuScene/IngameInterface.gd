extends CanvasLayer

export(PackedScene) var coleccionables
export(PackedScene) var opciones


func _on_Mapa_pressed():
	SceneLoader.re_enable_scene("Mapa")


func _on_Opciones_pressed():
	SceneLoader.load_scene(opciones)


func _on_Coleccionables_pressed():
	SceneLoader.load_scene(coleccionables)


func _on_Character_take_damage(remain_life):
	print("recibido", remain_life)
	$TextureProgress.value = remain_life
