extends base_unit
class_name friendly_unit_riot

@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var _turret: friendly_unit_riot_turret = $UnitRiotTurret

@onready var _texture0 = load("res://Art/skirmisher/sk_happy_idle.png")
@onready var _texture1 = load("res://Art/skirmisher/sk_happy_movin1.png")
@onready var _texture2 = load("res://Art/skirmisher/sk_happy_movin2.png")

@onready var _texture3 = load("res://Art/skirmisher/sk_angry_idle.png")
@onready var _texture4 = load("res://Art/skirmisher/sk_angry_movin1.png")
@onready var _texture5 = load("res://Art/skirmisher/sk_angry_movin2.png")

@onready var _movement_queued = false
@onready var _visibility_queued = false

@export var u_max_health : float = 100



func _ready():

	health = u_max_health
	max_health = u_max_health

	_animated_sprite.sprite_frames.add_frame("default", _texture0, 10, 0)
	_animated_sprite.rotate(3.14159)
	_animated_sprite.offset = Vector2(36, 0)
	_animated_sprite.play()
	

func _process(_delta):
	look_at(TARGET_POSITION)
	var vel = velocity
	
	if velocity != Vector2(0, 0) && !_movement_queued:
		_movement_queued = true
		if _turret.ENEMY_VISIBLE && !_visibility_queued:
			_visibility_queued = true
			_animated_sprite.sprite_frames.clear_all()
			_animated_sprite.sprite_frames.add_frame("default", _texture4, 0.6, 0)
			_animated_sprite.sprite_frames.add_frame("default", _texture3, 0.6, 0)
			_animated_sprite.sprite_frames.add_frame("default", _texture5, 0.6, 1)
			_animated_sprite.play()
		
		if !_turret.ENEMY_VISIBLE:
			_visibility_queued = false
			_animated_sprite.sprite_frames.clear_all()
			_animated_sprite.sprite_frames.add_frame("default", _texture1, 0.6, 0)
			_animated_sprite.sprite_frames.add_frame("default", _texture0, 0.6, 0)
			_animated_sprite.sprite_frames.add_frame("default", _texture2, 0.6, 1)
			_animated_sprite.play()
		
	if velocity == Vector2(0, 0):
		_movement_queued = false
		_animated_sprite.sprite_frames.clear_all()
		_animated_sprite.sprite_frames.add_frame("default", _texture0, 1, 0)
		_animated_sprite.play()
		


func _on_nav_agent_velocity_computed(safe_velocity:Vector2):
	_on_velocity_computed(safe_velocity)

