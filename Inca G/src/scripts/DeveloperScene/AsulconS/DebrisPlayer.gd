extends Node2D


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		$DebrisBody2D.collapse()
	if Input.is_action_just_pressed("ui_cancel"):
		$DebrisBody2D.reset()
	if Input.is_action_just_pressed("ui_left"):
		$DebrisBody2D.random_color = true
	if Input.is_action_just_pressed("ui_right"):
		$DebrisBody2D.random_color = false
