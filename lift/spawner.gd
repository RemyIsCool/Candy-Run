extends Marker2D


@export var velocity: Vector2
@export var time: float = 1.0


@onready var timer: Timer = $Timer


func _ready() -> void:
	_on_timer_timeout()
	timer.start(time)


func _on_timer_timeout() -> void:
	var LiftNode: Lift = preload("res://lift/lift.tscn").instantiate()
	LiftNode.velocity = velocity
	add_child(LiftNode)
