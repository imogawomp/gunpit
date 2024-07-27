extends CharacterBody2D
class_name base_unit

const SPEED = 300.0
@onready var TARGET_POSITION: Vector2 = global_position

@onready var nav_agent : NavigationAgent2D = $nav_agent

func _ready():
	nav_agent.velocity_computed.connect(_on_velocity_computed)

	nav_agent.path_desired_distance = 4.0
	nav_agent.target_desired_distance = 4.0

	call_deferred("actor_setup")


func actor_setup():
	await get_tree().physics_frame

	set_movement_target()

func set_movement_target() -> void:
	nav_agent.target_position = TARGET_POSITION

func _physics_process(delta):
	actor_setup()
	if nav_agent.is_navigation_finished():
		return
	
	var current_agent_pos : Vector2 = global_position
	var next_path_pos : Vector2 = nav_agent.get_next_path_position()

	var n_velocity : Vector2 = current_agent_pos.direction_to(next_path_pos) * SPEED

	if nav_agent.avoidance_enabled:
		nav_agent.set_velocity(n_velocity)
	else:
		_on_velocity_computed(n_velocity)
	#_unit_move_toward_point(TARGET_POSITION)
	
func _unit_move_toward_point(target_position):
	var direction = position.direction_to(target_position)
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		
func _on_velocity_computed(safe_velocity : Vector2):
	velocity = safe_velocity
	move_and_slide()