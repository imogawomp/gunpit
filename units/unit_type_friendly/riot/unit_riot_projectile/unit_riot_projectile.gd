extends base_projectile
class_name friendly_unit_riot_projectile

@onready var DIRECTION: Vector2 = self.global_position.direction_to(CURRENT_ENEMY.global_position + RAND_VECTOR)
@onready var RAND_VECTOR: Vector2
@onready var CURRENT_ENEMY: Node2D
@onready var SPEED = 1000


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = DIRECTION * SPEED
	#velocity = velocity.rotated(randf_range(-0.5, 0.5))
	move_and_slide()
	
	if self.global_position.distance_to(CURRENT_ENEMY.global_position) < 50:
		queue_free()
