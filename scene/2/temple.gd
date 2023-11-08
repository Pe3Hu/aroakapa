extends MarginContainer


@onready var fountain = $HBox/VBox/Fountain
@onready var core = $HBox/VBox/Core
@onready var mages = $HBox/Mages
@onready var rector = $HBox/Rector

var mountains = null


func set_attributes(input_: Dictionary) -> void:
	mountains = input_.mountains
	
	init_mages()
	
	var input = {}
	input.temple = self
	fountain.set_attributes(input)
	rector.set_attributes(input)
	core.set_attributes(input)


func init_mages() -> void:
	for rank in Global.dict.temple.rank:
		var description = Global.dict.temple.rank[rank]
		
		for _i in description.count:
			var input = {}
			input.temple = self
			input.rank = rank
		
			var mage = Global.scene.mage.instantiate()
			mages.add_child(mage)
			mage.set_attributes(input)

