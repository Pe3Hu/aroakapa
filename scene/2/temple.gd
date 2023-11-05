extends MarginContainer


@onready var cultivators = $Cultivators

var mountains = null


func set_attributes(input_: Dictionary) -> void:
	mountains = input_.mountains
	
	init_cultivators()


func init_cultivators() -> void:
	for _i in 1:
		var input = {}
		input.temple = self
	
		var cultivator = Global.scene.cultivator.instantiate()
		cultivators.add_child(cultivator)
		cultivator.set_attributes(input)
