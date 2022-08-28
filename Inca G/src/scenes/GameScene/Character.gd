extends KinematicBody2D
class_name Personaje
var state = "idle"

var orientation = 1

var anim_end = false

var oneshot_anim = false

var stop_anim = false

export var speed = 10
export var gravity = 500

var velocity: Vector2
var jumping = false

# para usar los cofres
signal interact

#para la vida del jugador
signal take_damage(remain_life)
var can_take_damage: bool  = true
var life = 100

func _ready():
	change_anim()

func change_anim():
	if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		if jumping == false:
			state = "idle"
	if Input.is_action_pressed("ui_left"):
		state = "walk"
		orientation = -1
	if Input.is_action_pressed("ui_right"):
		state = "walk"
		orientation = 1

	if Input.is_action_just_pressed("ui_up"):
		state = "jump"
		
	if state == 'jump' and oneshot_anim == false :
		oneshot_anim  = true
		$pivot/AnimatedSprite.play("jump")
	if state == 'dead':
		oneshot_anim = true
		$pivot/AnimatedSprite.play("dead")
	if state == 'walk' and oneshot_anim == false:
		$pivot.scale  = (Vector2(orientation,1))
		$pivot/AnimatedSprite.play("run")
	if state == 'idle':
		$pivot/AnimatedSprite.play("idle")
	

func _physics_process(delta):
	
	var dir = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	
	velocity.x = dir*speed
	velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("ui_up") and not jumping:
		velocity.y = -50000*delta
		jumping = true
	
	if is_on_floor() and jumping == true and velocity.y > 0.0:
		oneshot_anim = false
		jumping = false
		state = 'idle'
		
	velocity = move_and_slide(velocity,Vector2.UP)
	change_anim()
	
	
	if Input.is_action_just_pressed("interact"):
		emit_signal("interact")

func _on_AnimatedSprite_animation_finished():
	if oneshot_anim and oneshot_anim:
		$pivot/AnimatedSprite.stop()


func take_damage():
	if can_take_damage:
		can_take_damage = false
		life = max(0,life - 20)
		emit_signal("take_damage",life)
		$DamageTimer.start(1)
		print(life)
		if life == 0:
			SceneLoader.restart_tree()

func _on_DamageTimer_timeout():
	can_take_damage = true
