extends Control

signal type_select(group: String)

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	process_mode = Node.PROCESS_MODE_PAUSABLE
	$swarm.connect("pressed", _on_swarm_pressed)
	$riot.connect("pressed", _on_riot_pressed)
	$skirmisher.connect("pressed", _on_skirmisher_pressed)

func _process(_delta):
	if Input.is_action_pressed("shift") && !Input.is_action_pressed("lmb"):
		if !self.is_visible_in_tree():
			position = get_global_mouse_position()
			self.show()
	elif Input.is_action_just_released("shift") && self.is_visible_in_tree():
		self.hide()

func _on_swarm_pressed() -> void:
	type_select.emit("swarm")

func _on_riot_pressed() -> void:
	type_select.emit("riot")

func _on_skirmisher_pressed() -> void:
	type_select.emit("skirmisher")