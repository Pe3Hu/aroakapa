extends MarginContainer


@onready var shrines = $Shrines

var wilderness = null


func set_attributes(input_: Dictionary) -> void:
	wilderness = input_.wilderness
	
	init_shrines()


func init_shrines() -> void:
	for _i in 1:
		var input = {}
		input.sanctuary = self
	
		var shrine = Global.scene.shrine.instantiate()
		shrines.add_child(shrine)
		shrine.set_attributes(input)
