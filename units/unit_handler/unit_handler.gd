extends Node2D

var selected_units : Array = []

var select_start : Vector2
var select_end : Vector2

@onready var select_area : Area2D = $select_area
@onready var select_shape : CollisionShape2D = $select_area/select_shape

var move_start : Vector2
var move_end : Vector2

func _ready():
	select_area.monitorable = false
	select_area.monitoring = false

func _process(_delta):
	selection_inputs()

func selection_inputs () -> void:
	if Input.is_action_just_pressed("lmb"):
		select_start = get_global_mouse_position()
		print(select_start)

	if Input.is_action_just_released("lmb"):
		select_end = get_global_mouse_position()
		print(select_end)
		adjust_area_get_units()

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

	
	queue_redraw()

func _draw():
	var n_rect : Rect2 = Rect2()
	n_rect.size = select_shape.shape.size
	n_rect.position = select_area.position - (select_shape.shape.size / 2)

	draw_rect(n_rect, Color.RED)

func move_command_inputs () -> void:
	if Input.is_action_just_pressed("rmb"):
		move_start = get_global_mouse_position()
		print(move_start)

	if Input.is_action_just_released("rmb"):
		move_end = get_global_mouse_position()
		print(move_end)
		adjust_area_get_units()

func pass_move_points () -> void:
	if selected_units:
		if move_end.distance_to(move_start) || (selected_units.size() < 2):
			var mid_point : Vector2 = Vector2((move_end.x + move_start.x) / 2, (move_end.y + move_start.y) / 2)

			for unit in selected_units:
				pass
				# unit.TARGET_POSITION = mid_point
		else:
			var slope_vector : Vector2 = Vector2(move_end.x - move_start.x, move_end.y - move_start.y)

			var slope_mult : float = 1 / selected_units.size()

			for idx in selected_units.size():
				pass
				var unit : Node3D = selected_units[idx]

				# unit.TARGET_POSITION = move_start + ((idx * slope_mult) * slope_vector)

