extends base_turret
class_name enemy_unit_riot_turret

@onready var TURRET_POSITION = self.position

func _process(_delta):
	look_at(TURRET_POSITION)
	_fire_projectile()

func _fire_projectile():
	pass

func on_area_entered(body):
	print(body)

