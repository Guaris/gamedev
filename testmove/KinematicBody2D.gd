extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -550
const MAX_JUMPS = 2
const JUMPS = 0

var motion = Vector2()

func _input(event):
	if JUMPS < MAX_JUMPS:
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			JUMPS += 1
	if is_on_floor():
		JUMPS = 0
	if motion.y > 0 and is_on_wall():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			JUMPS += 1
	if is_on_floor():
		JUMPS = 0

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELERATION,MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION,-MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
		friction = true
		motion.x = lerp(motion.x, 0, 0.2)
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			JUMPS += 1
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else: 
			$Sprite.play("Fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
	motion = move_and_slide(motion, UP)
	pass
