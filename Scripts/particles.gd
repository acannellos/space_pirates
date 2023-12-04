extends Node2D

func _ready():
	Events.connect("enemy_killed", _on_enemy_kill)

func _on_enemy_kill(sel, pos):

	for i in range(get_child_count()):
		var particle = get_child(i)
		
		if particle is GPUParticles2D:
			if i == sel:
				print(sel)
				particle.emitting = true
