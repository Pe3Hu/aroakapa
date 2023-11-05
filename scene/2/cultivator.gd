extends MarginContainer


@onready var mana = $VBox/Aspects/Mana
@onready var power = $VBox/Aspects/Power
@onready var aspects = $VBox/Aspects

var temple = null


func set_attributes(input_: Dictionary) -> void:
	temple = input_.temple
	
	
	init_aspects()


func init_aspects() -> void:
	for subtype in Global.arr.aspect:
		var input = {}
		input.cultivator = self
		input.type = "aspect"
		input.subtype = subtype
		input.value = 0
		
		var aspect = get(input.subtype)
		aspect.set_attributes(input)
		#aspect.hide_icons()
