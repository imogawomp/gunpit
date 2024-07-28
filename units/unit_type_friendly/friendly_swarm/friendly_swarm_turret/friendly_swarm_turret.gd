extends base_turret
class_name friendly_unit_swarm_turret

const projectile = preload("res://units/unit_type_friendly/friendly_swarm/friendly_swarm_projectile/friendly_swarm_projectile.tscn")

func _ready():
	BULLET = projectile
	FIRE_DELAY = 0.05
	OVERHEAT_RATE = 2.5
	cool_rate = 7
	GROUP = "enemy"



