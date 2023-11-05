extends MarginContainer



@onready var mountains = $HBox/Mountains
@onready var wilderness = $HBox/Wilderness


func _ready() -> void:
	var input = {}
	input.world = self
	mountains.set_attributes(input)
	wilderness.set_attributes(input)
