extends MarginContainer


@onready var sanctuaries = $Sanctuaries

var world = null


func set_attributes(input_: Dictionary) -> void:
	world = input_.world
	
	init_sanctuaries()


func init_sanctuaries() -> void:
	for _i in 1:
		var input = {}
		input.wilderness = self
	
		var sanctuary = Global.scene.sanctuary.instantiate()
		sanctuaries.add_child(sanctuary)
		sanctuary.set_attributes(input)
