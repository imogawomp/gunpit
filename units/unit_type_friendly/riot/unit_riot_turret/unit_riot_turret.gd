extends base_turret
class_name friendly_unit_riot_turret

const friendly_unit_riot = preload("res://units/unit_type_friendly/riot/unit_riot_projectile/unit_riot_projectile.tscn")

@onready var TURRET_POSITION = self.position
@onready var TARGET_BODIES: Array = []


func _process(delta):
	look_at(TURRET_POSITION)
	_fire_projectile()

func _fire_projectile():
	queue_redraw()
	for body in TARGET_BODIES:
		#var unit_projectile = friendly_unit_riot.instantiate()
		pass

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
