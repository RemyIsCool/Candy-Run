extends CanvasLayer


const WAIT_TIME = 0.2


var fading := false


@onready var black: Polygon2D = $Black


func _ready() -> void:
	black.modulate.a = 0


func fade_around(function: Callable):
	fading = true
	await black.create_tween().tween_property(
		black,
		"modulate:a",
		1,
		WAIT_TIME
	).finished
	function.call()
	await get_tree().create_timer(WAIT_TIME).timeout
	await black.create_tween().tween_property(
		black, "modulate:a", 0, WAIT_TIME
	).finished
	fading = false


func change_scene(scene: String):
	await black.create_tween().tween_property(
		black,
		"modulate:a",
		1,
		WAIT_TIME
	).finished
	get_tree().paused = false
	get_tree().change_scene_to_file(scene)
	await get_tree().create_timer(WAIT_TIME).timeout
	black.create_tween().tween_property(black, "modulate:a", 0, WAIT_TIME)
