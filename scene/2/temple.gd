extends MarginContainer


@onready var cultivators = $HBox/Cultivators
@onready var fountain = $HBox/Fountain
@onready var rector = $HBox/Rector

var mountains = null


func set_attributes(input_: Dictionary) -> void:
	mountains = input_.mountains
	
	init_cultivators()
	
	var input = {}
	input.temple = self
	fountain.set_attributes(input)
	rector.set_attributes(input)


func init_cultivators() -> void:
	for rank in Global.dict.temple.rank:
		var description = Global.dict.temple.rank[rank]
		
		for _i in description.count:
			var input = {}
			input.temple = self
			input.rank = rank
		
			var cultivator = Global.scene.cultivator.instantiate()
			cultivators.add_child(cultivator)
			cultivator.set_attributes(input)

