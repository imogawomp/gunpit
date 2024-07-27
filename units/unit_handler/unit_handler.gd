@tool
extends Node2D

var selected_units : Array = []

var select_start : Vector2
var select_end : Vector2

@onready var select_area : Area2D = $select_area
@onready var select_shape : CollisionShape2D = $select_area/select_shape

func _ready():
	select_area.monitorable = false
	select_area.monitoring = false

func _process(_delta):
	if Input.is_action_just_pressed("lmb"):
		select_start = get_global_mouse_position()
		print(select_start)

	if Input.is_action_just_released("lmb"):
		select_end = get_global_mouse_position()
		print(select_end)
		adjust_area_get_units()

func adjust_area_get_units () -> void:
	var shape_rect := RectangleShape2D.new()
	shape_rect.size = abs(select_start - select_end)
	select_shape.shape = shape_rect

	select_area.global_position = (select_start + select_end / 2)
	select_area.monitoring = true

	var units_in_area := select_area.get_overlapping_bodies()


	if Input.is_action_pressed("ctrl"):
		pass
	else:
		selected_units.resize(0)
		selected_units.append_array(units_in_area)
	
	print(select_area.get_overlapping_bodies())
	select_area.monitoring = false

	
	queue_redraw()

func _draw():
	var n_rect : Rect2 = Rect2()
	n_rect.size = select_shape.shape.size
	n_rect.position = select_area.position

	draw_rect(n_rect, Color.RED)
