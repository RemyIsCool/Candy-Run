extends Area2D


var done := false


func _ready() -> void:
	Globals.reset.connect(func(): done = false)


func _on_body_entered(body: Node2D) -> void:
	if not done and body is Player:
		done = true
		body.camera_2d.limit_top = -INF
		body.camera_2d.limit_left = body.camera_2d.global_position.x - 320.0/2.0
		body.camera_2d.limit_right = body.camera_2d.global_position.x + 320.0/2.0
