extends base_turret
class_name friendly_unit_riot_turret

const friendly_unit_riot = preload("res://units/unit_type_friendly/riot/unit_riot_projectile/unit_riot_projectile.tscn")

@onready var TURRET_POSITION = self.position
@onready var TARGET_BODIES: Array = []
@onready var FIRE = false

func _process(delta):
	look_at(TURRET_POSITION)
	_fire_projectile()

func _fire_projectile():
	queue_redraw()
	for body in TARGET_BODIES:
		if FIRE:
			return
		else:
			FIRE = true
			await get_tree().create_timer(0.1).timeout
			
			var unit_projectile = friendly_unit_riot.instantiate()
			unit_projectile.global_position = self.global_position
			unit_projectile.CURRENT_ENEMY = body
			unit_projectile.RAND_VECTOR = Vector2(randf_range(-40, 40), randf_range(-40, 40))
			
			get_tree().get_root().add_child(unit_projectile)
		
		FIRE = false

func _on_body_shape_entered(rid_body: RID, body: Node2D, idx: int, loc_idx: int):
	if !TARGET_BODIES.has(body) && body.is_in_group("enemy"):
		TARGET_BODIES.push_back(body)

	
func _on_body_shape_exited(rid_body: RID, body: Node2D, idx: int, loc_idx: int):
	if TARGET_BODIES.has(body):
		var indx = TARGET_BODIES.find(body)
		TARGET_BODIES.remove_at(indx)

func _draw():
	for body in TARGET_BODIES:
		draw_line(Vector2(0,0), Vector2(self.global_position.distance_to(body.global_position), 0), Color(0,1,0,0.25), 3)

			
	#var f_unit_riot = friendly_unit_riot.instantiate()
	#f_unit_riot.global_position = Vector2(tempx, tempy)
	#
	#self.add_child(f_unit_riot)
