extends base_projectile
class_name friendly_unit_swarm_projectile

func _ready():
	SPEED = 1000
	DAMAGE = 1
	RANGE = 300
	RAND_ANGLE = 0.1
	GROUP = "enemy"
	DIRECTION = DIRECTION.rotated(randf_range(-RAND_ANGLE,RAND_ANGLE))