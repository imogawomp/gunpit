extends CharacterBody2D
class_name base_unit

const SPEED = 300.0
var TARGET_POSITION: Vector2

func _physics_process(delta):
	_unit_move_toward_point(TARGET_POSITION)
	move_and_slide()

func _unit_move_toward_point(target_position):
	var direction = position.direction_to(target_position)
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		
