extends base_turret
class_name friendly_unit_riot_turret

const friendly_unit_riot = preload("res://units/unit_type_friendly/riot/unit_riot_projectile/unit_riot_projectile.tscn")

@onready var TURRET_POSITION = self.position
@onready var TARGET_BODIES: Array = []

func _process(delta):
	look_at(TURRET_POSITION)
	_fire_projectile()

func _fire_projectile():
	for body in TARGET_BODIES:
		print(body)

func _on_body_shape_entered(body):
	if !TARGET_BODIES.has(body):
		TARGET_BODIES.push_back(body)
	
func _on_body_shape_exited(body):
	if TARGET_BODIES.has(body):
		var indx = TARGET_BODIES.find(body)
		TARGET_BODIES.remove_at(indx)
	
	#while :
		#var tempx = global_position.x + randf_range(0, 500)
		#var tempy = global_position.y + randf_range(0, 500)
		#
		#if friendly_posx_array && friendly_posy_array:
			#for x in friendly_posx_array.size():
				#while (tempx >= friendly_posx_array[x] + 100 && tempx < friendly_posx_array[x] + 100):
					#tempx = global_position.x + randf_range(0, 250);
				#while (tempy >= friendly_posy_array[x] + 100 && tempy < friendly_posy_array[x] + 100):
					#tempy = global_position.y + randf_range(0, 250);
				#
		#var f_unit_riot = friendly_unit_riot.instantiate()
		#f_unit_riot.global_position = Vector2(tempx, tempy)
		#
		#friendly_posx_array.push_back(tempx)
		#friendly_posy_array.push_back(tempy)
		#
		#self.add_child(f_unit_riot)
