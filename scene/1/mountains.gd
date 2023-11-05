extends MarginContainer


@onready var temples = $Temples

var world = null


func set_attributes(input_: Dictionary) -> void:
	world = input_.world
	
	init_temples()


func init_temples() -> void:
	for _i in 1:
		var input = {}
		input.mountains = self
	
		var temple = Global.scene.temple.instantiate()
		temples.add_child(temple)
		temple.set_attributes(input)
