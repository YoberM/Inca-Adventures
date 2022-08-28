extends Node2D


var sprite_anim_ready: bool = true
var collider_anim_ready: bool = true

func _ready():
	restart_anim()

func restart_anim():
	if sprite_anim_ready and collider_anim_ready:
		$AnimatedSprite.frame = 0
		$AnimatedSprite.play("out")
		$AnimationPlayer.play("default")
		sprite_anim_ready = false
		collider_anim_ready = false


func _on_AnimatedSprite_animation_finished():
	sprite_anim_ready = true
	restart_anim()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "default":
		collider_anim_ready = true
		restart_anim()


func _on_Area2D_body_entered(body):
	if body.is_class("KinematicBody2D"):
		body.take_damage()
