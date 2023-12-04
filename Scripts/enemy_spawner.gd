extends Node2D

const ENEMY_SCENE_PATH := "res://enemy.tscn"

const ENEMY_SIZE := Vector2(40, 40)
const SPACING := 10

var gridWidth
var gridHeight
var initialPos

func _ready():
	gridWidth = ENEMY_SIZE.x * 11 + SPACING * 10
	gridHeight = ENEMY_SIZE.y * 5 + SPACING * 4
	initialPos = Vector2((get_viewport_rect().size.x - gridWidth) / 2, 100)

	createGrid()

func createGrid():
	for row in range(5):
		for col in range(11):
			var enemy = preload(ENEMY_SCENE_PATH).instantiate()
			enemy.activeSpriteIndex = row
			
			var enemyPos = initialPos + Vector2(col * (ENEMY_SIZE.x + SPACING), row * (ENEMY_SIZE.y + SPACING))
			enemy.position = enemyPos
			
			Global.total_enemies += 1
			Global.enemies_remaining += 1
			add_child(enemy)
