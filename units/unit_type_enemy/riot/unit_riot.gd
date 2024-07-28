extends base_unit
class_name enemy_unit_riot

func _on_nav_agent_velocity_computed(safe_velocity:Vector2):
	_on_velocity_computed(safe_velocity)
