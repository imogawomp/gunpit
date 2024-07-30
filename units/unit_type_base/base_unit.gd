extends CharacterBody2D
class_name base_unit

var selected : bool = false

var health : float = 100
var max_health : float = 100
var dead : bool = false
var regening : bool = false

var SPEED = 300.0
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

func _process(_delta):
	queue_redraw()

func _physics_process(_delta):
	regen_health()

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

func _draw():
	if selected:
		draw_circle(Vector2.ZERO, 45, Color(0,1,1,0.25))

func take_damage(damage : float) -> void:
	health -= damage

	if health <= 0:
		
		dead = true
		self.hide()

		await get_tree().create_timer(0.2).timeout
		queue_free()

func regen_health() -> void:
	if !regening:
		regening = true
		await get_tree().create_timer(0.5).timeout


		if health < max_health:
			health += 0.5
			health = clampf(health, 0, max_health)
			regening = false
	else:
		return

