extends base_unit
class_name friendly_unit_riot


func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_nav_agent_velocity_computed(safe_velocity:Vector2):
	_on_velocity_computed(safe_velocity)
