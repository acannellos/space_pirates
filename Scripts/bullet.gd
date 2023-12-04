class_name Bullet
extends CharacterBody2D

@export var data: Array[BulletData]
var temp: BulletData

@export var selected_bullet: int

var _speed: float
var _acceleration: float
var _bullet_lifetime: int

@onready var timer = $Timer
@onready var sprite = $Sprite2D
@onready var particles = $particles

func _ready():
	
	temp = data[selected_bullet]
	
	sprite.texture = temp.texture
	
	var shader_material = sprite.material
	if shader_material is ShaderMaterial:
		shader_material.set_shader_parameter("albedo_color", temp.color)

	_speed = temp.speed
	_acceleration = temp.acceleration
	_bullet_lifetime = temp.bullet_lifetime
	
	if particles != null and particles.get_child_count() > 0:

		for i in range(particles.get_child_count()):
			var particle = particles.get_child(i)
			
			if particle is GPUParticles2D:
				if i == temp.selected_trail:
					particle.visible = true
					particle.emitting = true
				else:
					particle.visible = false
					particle.emitting = false
	
	
	timer.connect("timeout", _ded)
	timer.start(_bullet_lifetime)

func _physics_process(delta):
	velocity.y = lerp(velocity.y, -_speed, _acceleration)
	move_and_slide()

func _ded():
#	print("ded")
	queue_free()
