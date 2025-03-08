extends CanvasLayer


@onready var label: Label = $Label


func _process(delta) -> void:
	Globals.timer += delta
	label.text = "Time: %ss" % snappedf(Globals.timer, 0.1)
