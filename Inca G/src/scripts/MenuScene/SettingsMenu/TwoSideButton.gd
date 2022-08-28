extends HBoxContainer

export(Array) var options
export(int) var step = 1
export(bool) var loop = false
export(int) var idx = 0

export(Color) var color_focus
export(Vector2) var offset_focus
export(Color) var color_pressed
export(Vector2) var offset_pressed
export(Color) var color_normal
export(Vector2) var offset_normal


func _ready():
	if idx >= options.size() or idx < 0:
		idx = 0 


func set_options(string_array: Array) -> void:
	self.options = string_array


func set_index(index: int) -> void:
	self.idx = index
	_update_label()


func reset() -> void:
	idx = 0


func get_text() -> String:
	return $Label.text


func _update_label() -> void:
	if idx >= 0 and idx < options.size():
		$Label.text = options[idx]
	else:
		$Label.text = "-"


func _left():
	if loop:
		idx = wrapi(idx - step, 0, options.size())
	else:
		idx = max(0, idx - step)
	_update_label()


func _right():
	if loop:
		idx = wrapi(idx + step, 0, options.size())
	else:
		idx = min(idx + step, options.size() - 1 )
	_update_label()


func _colorate(color: Color):
	_colorate_left(color)
	_colorate_right(color)
	_colorate_label(color)


func _colorate_left(color: Color):
	$Left.modulate = color


func _colorate_right(color: Color):
	$Right.modulate = color


func _colorate_label(color: Color):
	$Label.modulate = color


func _translate(offset: Vector2):
	_translate_label(offset)
	_translate_left(offset)
	_translate_right(offset)


func _translate_label(offset: Vector2) -> void:
	$Label.rect_position += offset 


func _translate_left(offset: Vector2) -> void:
	$Left.rect_position += offset


func _translate_right(offset: Vector2) -> void:
	$Right.rect_position += offset



func _on_Left_button_down() -> void:
	_left()


func _on_Left_button_up() -> void:
	pass


func _on_Right_button_down() -> void:
	_right()


func _on_Right_button_up() -> void:
	pass


func _on_TwoSideButton_focus_entered() -> void:
	$Left.disabled = false
	$Right.disabled = false
	_colorate(color_focus)



func _on_TwoSideButton_focus_exited() -> void:
	$Left.disabled = true
	$Right.disabled = true
	_colorate(color_normal)


func _on_TwoSideButton_mouse_entered():
	grab_focus()
	$Left.disabled = false
	$Right.disabled = false


func _on_TwoSideButton_mouse_exited():
	release_focus()
	$Left.disabled = true
	$Right.disabled = true

