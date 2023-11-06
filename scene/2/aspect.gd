extends MarginContainer


@onready var title = $Title
@onready var stack = $Stack

var cultivator = null


func set_attributes(input_: Dictionary) -> void:
	cultivator = input_.cultivator
	
	title.set_attributes(input_)
	title.custom_minimum_size = Vector2(Global.vec.size.aspect)
	
	input_.type = "number"
	input_.subtype = input_.value
	stack.set_attributes(input_)
	stack.custom_minimum_size = Vector2(Global.vec.size.aspect)
	#custom_minimum_size = Vector2(Global.vec.size.aspect)


func hide_icons() -> void:
	title.visible = false
	stack.visible = false


func show_icons() -> void:
	title.visible = true
	stack.visible = true
