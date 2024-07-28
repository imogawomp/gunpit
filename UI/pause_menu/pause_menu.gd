extends Control

func _ready():
	self.hide()
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = false
	$resume.connect("pressed", _on_resume_pressed)

func _input(event):
	if event.is_action_pressed("esc"):
		if self.is_visible_in_tree():
			self.hide()
			get_tree().paused = false
		else:
			self.show()
			get_tree().paused = true
		
func _on_resume_pressed():
	if self.is_visible_in_tree():
			self.hide()
			get_tree().paused = false