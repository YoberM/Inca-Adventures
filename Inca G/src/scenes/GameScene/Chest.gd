extends Node2D

export(NodePath) var item

func use_chest():
	$ClosedTexture.visible = false
	$OpenTexture2.visible = true
	$Particles2D.emitting = false
	
func _ready():
	$ClosedTexture.visible = true
	$OpenTexture2.visible = false

func _on_Area2D_body_entered(body):
	if body.is_class("KinematicBody2D"):
		body.connect("interact",self,"use_chest")
	
func _on_Area2D_body_exited(body):
	if body.is_class("KinematicBody2D"):
		body.disconnect("interact",self,"use_chest")
