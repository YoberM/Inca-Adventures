extends Menu

var lastbigicon
var lasttitle
var lastdesc

func _on_Close_pressed():
	SceneLoader.clean_scene(self)



func clean_last():
	if lastbigicon != null:
		lastbigicon.visible = false
		lastdesc.visible = false
		lasttitle.visible = false

func _on_Amulet_pressed():
	clean_last()
		
	$Slots/Amulet/bigicon.visible = true
	$Slots/Amulet/desc.visible = true
	$Slots/Amulet/title.visible = true
	
	lastbigicon = $Slots/Amulet/bigicon
	lastdesc = $Slots/Amulet/desc
	lasttitle = $Slots/Amulet/title


func _on_Llama_pressed():
	clean_last()
		
	$Slots/Llama/bigicon.visible = true
	$Slots/Llama/desc.visible = true
	$Slots/Llama/title.visible = true
	
	lastbigicon = $Slots/Llama/bigicon
	lastdesc = $Slots/Llama/desc
	lasttitle = $Slots/Llama/title

