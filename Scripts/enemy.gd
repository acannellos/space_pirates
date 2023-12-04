extends CharacterBody2D

@export var activeSpriteIndex: int = 0
@export var speed: float = 20.0

var screen_size
var margin = 20
var temp_y
@export var direction: int = 1

var tempo: float

@onready var sprites = $sprites
@onready var particles = $particles

var vertical_movement_started = false
@export var vertical_movement_distance: int = 10

func _ready():
	screen_size = get_viewport_rect().size
	
	Events.connect("enemy_exited", _on_enemy_exit)
	
	if sprites != null and sprites.get_child_count() > 0:

		for i in range(sprites.get_child_count()):
			var sprite = sprites.get_child(i)
			
			if sprite is AnimatedSprite2D:
				if i == activeSpriteIndex:
					sprite.visible = true
					sprite.play("move")
				else:
					sprite.visible = false

func _on_enemy_exit():
	velocity.x = 0
	direction = -direction
	temp_y = position.y
	vertical_movement_started = true

func _physics_process(delta):
	
	if vertical_movement_started:
		if (abs(position.y) - abs(temp_y)) < vertical_movement_distance:
			velocity.x = 0
			#velocity.y = Global.global_speed
			velocity.y = speed
			move_and_slide()
		else:
			velocity.y = 0
			vertical_movement_started = false 
	else:
		#velocity.x = direction * Global.global_speed
		velocity.x = direction * speed
		move_and_slide()

		if position.x < 0 + margin:
			Events.enemy_exited.emit()

		if position.x > screen_size.x - margin:
			Events.enemy_exited.emit()


func _on_area_2d_body_entered(body):
	
	Global.enemies_remaining -= 1
	
	tempo = Global.enemies_remaining / Global.total_enemies
	var math = 1.0 + (1.0 - tempo)
	
	if Global.global_speed * math < Global.global_max_speed:
		Global.global_speed *= math
	else:
		pass
	
	Events.enemy_killed.emit(activeSpriteIndex, global_position)
	
	body.queue_free()
	queue_free()
