extends CanvasLayer

@onready var loop = $loop

var tempo: float = 0.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):
	tempo = Global.enemies_remaining / Global.total_enemies
	var math = 1.0 + (1.0 - tempo)

	loop.pitch_scale = math

func _unhandled_input(event: InputEvent):
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
