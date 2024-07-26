extends CharacterBody2D

const SPEED = 300.0

var target_pos : Vector2

func _ready():
	target_pos = position

func _physics_process(_delta):
	#var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction : Vector2 = Vector2.ZERO

	if target_pos != position:
		direction = position.direction_to(target_pos)

	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()
