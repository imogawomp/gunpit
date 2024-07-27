extends base_turret
class_name friendly_unit_riot_turret

@onready var TURRET_POSITION = self.position

func _process(delta):
	look_at(TURRET_POSITION)
	_fire_projectile()

func _fire_projectile():
	pass
