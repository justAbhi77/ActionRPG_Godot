extends KinematicBody2D


export (int) var speed = 200

var velocity = Vector2()

onready var animPlayer=$AnimationPlayer
onready var animTree=$AnimationTree
onready var animState=animTree.get("parameters/playback")

func _process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
	if velocity != Vector2.ZERO:
		animTree.set("parameters/Run/blend_position", velocity)
		animTree.set("parameters/Idle/blend_position", velocity)
		animState.travel("Run")
	else:
		animState.travel("Idle")
		
func _physics_process(delta):
	move_and_collide(velocity*delta)
