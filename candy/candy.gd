class_name Candy
extends RigidBody2D


@export_enum("Normal", "Small") var type: int = 0
@export_enum("Red", "Green", "Blue") var color: int = 0


var spawned := false


@onready var sprite: Sprite2D = $Sprite
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	if not spawned:
		$DeleteWhenOffScreen.queue_free()
	if type == 0:
		sprite.frame = color
	else:
		sprite.texture = [
			preload("res://candy/small_red.png"),
			preload("res://candy/small_green.png"),
			preload("res://candy/small_blue.png")
		][color]
		sprite.hframes = 1
		collision_shape_2d.shape = CircleShape2D.new()
		collision_shape_2d.shape.radius = 2.5
		sprite.z_index = -1


func _on_area_2d_body_entered(body: Node2D) -> void:
	if type == 0 and body is Player:
		body.die()
