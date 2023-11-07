extends MarginContainer


@onready var title = $Title
@onready var stack = $Stack

var shrine = null
var powers = {}


func set_attributes(input_: Dictionary) -> void:
	shrine = input_.shrine
	
	title.set_attributes(input_)
	title.custom_minimum_size = Vector2(Global.vec.size.aspect)
	
	input_.type = "number"
	input_.subtype = input_.value
	stack.set_attributes(input_)
	stack.custom_minimum_size = Vector2(Global.vec.size.aspect)
	#custom_minimum_size = Vector2(Global.vec.size.aspect)


func change_temple_power(temple_: MarginContainer, power_: int) -> void:
	var side = shrine.sides[temple_]
	
	#if !powers.has(side):
	#	powers[side] = 0
	
	powers[side] += power_
	update_equilibrium()


func update_equilibrium() -> void:
	var input = {}
	input.type = "equilibrium"
	
	if powers.left == powers.right:
		input.subtype = "equal"
	
	if powers.left > powers.right:
		input.subtype = "left"
	else:
		input.subtype = "right"
	
	title.set_attributes(input)
	
	input.type = "number"
	input.subtype = abs(powers.left - powers.right)
	stack.set_attributes(input)
