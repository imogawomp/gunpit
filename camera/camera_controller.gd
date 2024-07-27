extends Camera2D

@export var cam_move_speed: float = 5.0

@export var cam_zoom_speed: float = 0.05

var n_zoom: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction : Vector2 = Input.get_vector("cam_lft", "cam_rght", "cam_up", "cam_dwn")

	if direction:
		position += direction * cam_move_speed

	n_zoom = clampf(n_zoom, 0.5, 1.5)

	zoom = Vector2(n_zoom,n_zoom)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			n_zoom += cam_zoom_speed
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			n_zoom -= cam_zoom_speed

