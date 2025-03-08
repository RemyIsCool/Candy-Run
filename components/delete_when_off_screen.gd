extends VisibleOnScreenNotifier2D


const ANIM_SPEED = 0.1


var _has_been_on_screen: bool = false


@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D


func _ready() -> void:
	collision_shape_2d.shape.size = rect.size
	collision_shape_2d.position = rect.position


func _process(_delta: float) -> void:
	if is_on_screen():
		_has_been_on_screen = true
	elif _has_been_on_screen:
		_delete()


func _on_area_2d_area_entered(_area: Area2D) -> void:
	_delete()


func _delete() -> void:
	await owner.create_tween().tween_property(
		owner,
		"modulate:a",
		0,
		ANIM_SPEED
	).finished
	owner.queue_free()
