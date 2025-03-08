extends Area2D


@export_file("*.tscn") var next_scene: String


@onready var sprite: AnimatedSprite2D = $Sprite
@onready var win: AudioStreamPlayer = $Win


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		win.play()
		sprite.play("open")
		await sprite.animation_finished
		SceneManager.change_scene(next_scene)
