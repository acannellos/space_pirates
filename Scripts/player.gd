extends CharacterBody2D

@export var speed: float = 300.0

@onready var _animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer
@onready var gun = $gun

var is_shooting: bool = false
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	timer.connect("timeout", _on_timeout)

func _on_timeout():
	is_shooting = false

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		is_shooting = true
		timer.start(0.5)
		gun.shoot()

func _physics_process(delta):
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		
		if direction > 0:
			_animated_sprite.flip_h = false
		else:
			_animated_sprite.flip_h = true
			
		_animated_sprite.play("run")
	else:
		_animated_sprite.play("idle")
		velocity.x = move_toward(velocity.x, 0, speed)
		_animated_sprite.stop()

	move_and_slide()
	
	if position.x < 0:
		position.x = screen_size.x
	elif position.x > screen_size.x:
		position.x = 0
	
	if is_shooting:
		_animated_sprite.play("shoot")
