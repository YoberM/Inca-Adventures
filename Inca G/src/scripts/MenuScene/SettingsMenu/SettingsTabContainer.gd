extends TabContainer


func _input(event):
	if Input.is_action_just_pressed("ui_focus_next"):
		current_tab =  wrapi(current_tab+1, 0, get_child_count())
