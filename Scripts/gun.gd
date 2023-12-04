class_name Gun
extends Node2D

var bullet_scene = preload("res://bullet.tscn")

@export var selected_weapon: int = 0

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.keycode:
				KEY_1:
					selected_weapon = 0
					print("selected 1")
				KEY_2:
					selected_weapon = 1
					print("selected 2")
				KEY_3:
					selected_weapon = 2
					print("selected 3")

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.selected_bullet = selected_weapon
	bullet.position = global_position - Vector2(0, 40)
	get_tree().get_root().add_child(bullet)
