extends Marker2D


@export var time: float = 1
@export_enum("Normal", "Small") var type: int = 0
@export_flags_2d_physics var layers: int = 1


@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.start(time)


func _on_timer_timeout() -> void:
	var CandyNode: Candy = preload("res://candy/candy.tscn").instantiate()
	CandyNode.color = randi_range(0, 2)
	CandyNode.type = type
	CandyNode.collision_mask = layers
	CandyNode.spawned = true
	add_child(CandyNode)
