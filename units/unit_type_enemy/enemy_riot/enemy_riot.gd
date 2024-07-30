extends base_unit
class_name enemy_unit_riot

@export var u_max_health : float = 100

func _ready():
	health = u_max_health
	max_health = u_max_health

func _on_nav_agent_velocity_computed(safe_velocity:Vector2):
	_on_velocity_computed(safe_velocity)
