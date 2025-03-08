extends StaticBody2D


const FRAME_COUNT = 3
const FRAME_SIZE = 3


@export_enum("Left", "Middle", "Right") var type: int = 1


var _frame: int = 0


@onready var sprite: Sprite2D = $Sprite


func _on_timer_timeout() -> void:
	_frame = (_frame + 1) % FRAME_COUNT
	sprite.frame = type + _frame * FRAME_SIZE
