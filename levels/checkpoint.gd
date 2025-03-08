extends Area2D


@export var fake := false

@export var checkpoint_number: int = 1


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sound: AudioStreamPlayer = $Sound


func _on_body_entered(body: Node2D) -> void:
	if fake and body is Player:
		animated_sprite_2d.play("slosh")
		sound.play()
		return
	if body is Player and body.has_checkpoint < checkpoint_number:
		body.checkpoint = global_position
		body.has_checkpoint = checkpoint_number
		animated_sprite_2d.play("slosh")
		sound.play()
