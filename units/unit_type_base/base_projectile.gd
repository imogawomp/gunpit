extends CharacterBody2D
class_name base_projectile

@onready var DIRECTION: Vector2 = self.global_position.direction_to(ENEMY_POS)
@onready var ENEMY_POS: Vector2
var RAND_ANGLE: float = 0.2
var SPEED : float = 1000
var RANGE : float = 500
var GROUP : String = "enemy"
var DAMAGE : float = 5

var distance : float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = DIRECTION * SPEED
	distance += velocity.length() * delta
	#velocity = velocity.rotated(randf_range(-0.5, 0.5))
	move_and_slide()
	
	if (get_slide_collision_count() > 0):
		var collider = get_slide_collision(0).get_collider()
		if collider.is_in_group(GROUP):
			collider.take_damage(DAMAGE)

		queue_free()
	elif (distance >= RANGE):
		queue_free()
