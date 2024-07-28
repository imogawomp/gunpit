extends base_projectile
class_name friendly_unit_riot_projectile

func _ready():
	SPEED = 1000
	DAMAGE = 5
	RANGE = 500
	RAND_ANGLE = 0.2
	GROUP = "enemy"
	DIRECTION = DIRECTION.rotated(randf_range(-RAND_ANGLE,RAND_ANGLE))