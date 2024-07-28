extends Area2D
class_name base_turret

@onready var ENEMY_POSITION = self.global_position
@onready var TARGET_BODIES: Array = []
@onready var FIRE = false
var BULLET
var GROUP : String
var FIRE_DELAY : float

var TURN_TURRET : bool = false

var OVERHEAT : float = 0
var OVERHEAT_RATE : float = 5
var CAN_FIRE : bool = true

func _process(delta):
	_overheat_test()
	_cool_off()

	if TURN_TURRET:
		look_at(ENEMY_POSITION)
	if CAN_FIRE:
		_fire_projectile()

var overheated : bool = false
func _overheat_test():
	OVERHEAT = clampf(OVERHEAT, 0, 101)
	if OVERHEAT >= 100:
		overheated = true
		CAN_FIRE = false
	if (OVERHEAT <= 0) && overheated:
		overheated = false
		CAN_FIRE = true

var cooling : bool = false
var cool_rate : float = 10
func _cool_off() -> void:
	if !cooling:
		cooling = true
		await get_tree().create_timer(0.5).timeout
		OVERHEAT -= cool_rate
		cooling = false
	else:
		return

func _fire_projectile():
	queue_redraw()
	
	if TARGET_BODIES.is_empty():
		TURN_TURRET = false
		return
	else:
		ENEMY_POSITION = TARGET_BODIES[0].global_position
		TURN_TURRET = true
		for body in TARGET_BODIES:
			
			if body.dead:
				TARGET_BODIES.remove_at(TARGET_BODIES.find(body))
				continue
			
			var curr_body_pos : Vector2 = body.global_position
			if curr_body_pos == ENEMY_POSITION:
				continue
			elif curr_body_pos.distance_to(self.global_position) < ENEMY_POSITION.distance_to(self.global_position):
				ENEMY_POSITION = curr_body_pos

		if FIRE:
			return
		else:
			FIRE = true
			await get_tree().create_timer(FIRE_DELAY).timeout
			
			var unit_projectile = BULLET.instantiate()
			unit_projectile.global_position = self.global_position
			unit_projectile.ENEMY_POS = ENEMY_POSITION
			
			get_tree().get_root().add_child(unit_projectile)
			OVERHEAT += OVERHEAT_RATE
		
		FIRE = false

func _on_body_entered(body: Node2D):
	if !TARGET_BODIES.has(body) && body.is_in_group(GROUP):
		TARGET_BODIES.push_back(body)

	
func _on_body_exited(body: Node2D):
	if TARGET_BODIES.has(body):
		var indx = TARGET_BODIES.find(body)
		TARGET_BODIES.remove_at(indx)

func _draw():
	for body in TARGET_BODIES:
		draw_line(Vector2(0,0), Vector2(self.global_position.distance_to(body.global_position), 0), Color(0,1,0,0.25), 3)
