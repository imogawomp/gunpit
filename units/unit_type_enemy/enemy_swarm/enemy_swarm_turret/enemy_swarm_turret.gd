extends base_turret
class_name enemy_unit_swarm_turret

const projectile = preload("res://units/unit_type_enemy/enemy_swarm/enemy_swarm_projectile/enemy_swarm_projectile.tscn")

func _ready():
	BULLET = projectile
	FIRE_DELAY = 0.05
	OVERHEAT_RATE = 2.5
	cool_rate = 7
	GROUP = "friendly"



