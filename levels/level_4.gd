extends Node2D


@onready var your_time: Label = $YourTime


func _ready() -> void:
	your_time.text = "Your Time Was: %ss" % snappedf(Globals.timer, 0.1)
