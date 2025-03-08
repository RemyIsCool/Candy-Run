class_name Lift
extends StaticBody2D


@export var velocity := Vector2(0, 10)


func _physics_process(delta: float) -> void:
	position += velocity * delta
