extends base_turret
class_name friendly_unit_riot_turret

const friendly_unit_riot = preload("res://units/unit_type_friendly/friendly_riot/friendly_riot_projectile/friendly_riot_projectile.tscn")

func _ready():
	BULLET = friendly_unit_riot
	FIRE_DELAY = 0.1
	GROUP = "enemy"



