extends CharacterBody2D
class_name base_unit

const SPEED = 300.0
@onready var TARGET_POSITION: Vector2 = self.position

func _physics_process(delta):
	_unit_move_toward_point()
	move_and_slide()

func _unit_move_toward_point():
	var direction = position.direction_to(TARGET_POSITION)
	
	if direction && (self.position.distance_to(TARGET_POSITION) > 5):
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		
