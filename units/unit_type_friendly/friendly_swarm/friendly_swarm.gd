extends base_unit
class_name friendly_unit_swarm

@export var u_max_health : float = 50

func _ready():
	SPEED = 400
	health = u_max_health
	max_health = u_max_health

func _on_nav_agent_velocity_computed(safe_velocity:Vector2):
	_on_velocity_computed(safe_velocity)
