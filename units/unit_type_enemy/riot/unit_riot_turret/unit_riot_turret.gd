extends base_turret
class_name enemy_unit_riot_turret

const projectile = preload("res://units/unit_type_enemy/unit_riot_projectile_enemy/unit_riot_projectile.tscn")

func _ready():
	GROUP = "friendly"
	BULLET = projectile
	FIRE_DELAY = 0.1
