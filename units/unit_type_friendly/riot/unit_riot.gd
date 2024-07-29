extends base_unit
class_name friendly_unit_riot

@onready var _animated_sprite: AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D
@onready var _texture0 = load("res://Art/skirmisher/sk_happy_idle.png")
@onready var _texture1 = load("res://Art/skirmisher/sk_happy_movin1.png")
@onready var _texture2 = load("res://Art/skirmisher/sk_happy_movin2.png")
@onready var _movement_queued = false;

@onready var PLAYED = false

func _ready():

	self._animated_sprite.sprite_frames.add_frame("default", _texture0, 10, 0)
	self._animated_sprite.rotate(219.9)
	self._animated_sprite.position = Vector2(-45, -5)
	self._animated_sprite.play()
	

func _process(_delta):
	look_at(TARGET_POSITION)
	var vel = velocity
	
	if self.velocity != Vector2(0, 0) && !_movement_queued:
		_movement_queued = true
		self._animated_sprite.sprite_frames.clear_all()
		self._animated_sprite.sprite_frames.add_frame("default", _texture1, 5, 0)
		self._animated_sprite.sprite_frames.add_frame("default", _texture2, 5, 1)
		self._animated_sprite.play()
		
	else:
		_movement_queued = false
		self._animated_sprite.sprite_frames.clear_all()
		self._animated_sprite.sprite_frames.add_frame("default", _texture0, 1, 0)
		self._animated_sprite.play()


func _on_nav_agent_velocity_computed(safe_velocity:Vector2):
	_on_velocity_computed(safe_velocity)
