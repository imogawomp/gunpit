extends Node2D

var selected_units : Array = []

var select_start : Vector2
var select_end : Vector2

const friendly_unit_riot = preload("res://units/unit_type_friendly/riot/unit_riot.tscn")

@onready var select_area : Area2D = $select_area
@onready var select_shape : CollisionShape2D = $select_area/select_shape


var move_start : Vector2
var move_end : Vector2

var select_drag_test : bool = false
var move_drag_test : bool = false

func _ready():
	select_area.monitorable = false
	select_area.monitoring = false
	_place_units()

func _process(_delta):
	selection_inputs()
	move_command_inputs()

func _place_units():
	
	var friendly_posx_array: Array;
	var friendly_posy_array: Array;
	
	for i in range(0, 3):
		var tempx = global_position.x + randf_range(0, 500)
		var tempy = global_position.y + randf_range(0, 500)
		
		if friendly_posx_array && friendly_posy_array:
			for x in friendly_posx_array.size():
				while (tempx >= friendly_posx_array[x] + 100 && tempx < friendly_posx_array[x] + 100):
					tempx = global_position.x + randf_range(0, 250);
				while (tempy >= friendly_posy_array[x] + 100 && tempy < friendly_posy_array[x] + 100):
					tempy = global_position.y + randf_range(0, 250);
				
		var f_unit_riot = friendly_unit_riot.instantiate()
		f_unit_riot.global_position = Vector2(tempx, tempy)
		
		friendly_posx_array.push_back(tempx)
		friendly_posy_array.push_back(tempy)
		
		self.add_child(f_unit_riot)

func selection_inputs () -> void:
	if Input.is_action_just_pressed("lmb"):
		select_start = get_global_mouse_position()
		select_drag_test = true
		print(select_start)

	if select_drag_test:
		select_end = get_global_mouse_position()
		queue_redraw()

	if Input.is_action_just_released("lmb"):
		select_drag_test = false
		select_end = get_global_mouse_position()
		print(select_end)
		adjust_area_get_units()
		queue_redraw()

func adjust_area_get_units () -> void:
	var shape_rect := RectangleShape2D.new()
	var size : Vector2 = abs(select_start - select_end)
	shape_rect.size = size
	select_shape.shape = shape_rect

	var a_pos : Vector2 = Vector2((select_start.x + select_end.x) / 2, (select_start.y + select_end.y) / 2)
	select_area.global_position = a_pos
	select_area.monitoring = true

	var units_in_area : Array = []
	
	if get_child_count() > 1:
		for chld in range(1, get_child_count()):
			var pos : Vector2 = get_child(chld).position
			if (pos.x > (a_pos.x - (size.x/2))) && (pos.x < (a_pos.x + (size.x/2))):
				if (pos.y > (a_pos.y - (size.y/2))) && (pos.y < (a_pos.y + (size.y/2))):
					units_in_area.append(get_child(chld))

	if Input.is_action_pressed("ctrl"):
		for unit in units_in_area:
			if !selected_units.has(unit):
				selected_units.append_array(units_in_area)
	else:
		selected_units.resize(0)
		selected_units.append_array(units_in_area)
	
	print(selected_units)
	select_area.monitoring = false

func _draw():
	if select_drag_test:
		var n_rect : Rect2 = Rect2()
		n_rect.size = (abs(select_start - select_end))
		n_rect.position = ((select_start + select_end) / 2) - (n_rect.size / 2)

		draw_rect(n_rect, Color(1,0,0,0.25))
	if move_drag_test:
		draw_line(move_start, move_end, Color(0,1,0,0.25), 3)

func move_command_inputs () -> void:
	if Input.is_action_just_pressed("rmb"):
		move_start = get_global_mouse_position()
		
		move_drag_test = true

		print(move_start)

	if move_drag_test:
		move_end = get_global_mouse_position()
		queue_redraw()

	if Input.is_action_just_released("rmb"):
		move_drag_test = false
		move_end = get_global_mouse_position()
		print(move_end)
		pass_move_points()
		queue_redraw()

func pass_move_points () -> void:
	if selected_units:
		if (move_end.distance_to(move_start) < 10) || (selected_units.size() < 2):
			var mid_point : Vector2 = Vector2((move_end.x + move_start.x) / 2, (move_end.y + move_start.y) / 2)

			for unit in selected_units:
				unit.TARGET_POSITION = mid_point
				print("move mid")
		else:
			var slope_vector : Vector2 = Vector2(move_end.x - move_start.x, move_end.y - move_start.y)

			var slope_mult : float = 1 / float(selected_units.size() - 1)
			
			var unused_units : Array = []
			unused_units.append_array(selected_units)
			for idx in selected_units.size():
				
				var unit_idx = 0

				var targ_pos : Vector2 = move_start + ((idx * slope_mult) * slope_vector)

				for uidx in unused_units.size():
					if uidx == unit_idx:
						continue
					if unused_units[unit_idx].position.distance_to(targ_pos) > unused_units[uidx].position.distance_to(targ_pos):
						unit_idx = uidx
				var unit = unused_units[unit_idx]
				unused_units.remove_at(unit_idx)

				unit.TARGET_POSITION = targ_pos
				print("move pt")

