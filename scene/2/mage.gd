extends MarginContainer


@onready var mana = $VBox/Aspects/Mana
@onready var power = $VBox/Aspects/Power
@onready var aspects = $VBox/Aspects

var temple = null
var rank = null
var sockets = null


func set_attributes(input_: Dictionary) -> void:
	temple = input_.temple
	rank = input_.rank
	
	init_aspects()


func init_aspects() -> void:
	var description = Global.dict.temple.rank[rank]
	
	for subtype in Global.arr.aspect:
		var input = {}
		input.cultivator = self
		input.type = subtype
		input.subtype = "basic"
		input.value = description[subtype]
		
		var aspect = get(input.type)
		aspect.set_attributes(input)
		#aspect.hide_icons()
	
	sockets = description.sockets
	
	if int(sockets * 2) % 2 == 1:
		Global.rng.randomize()
		var shift = Global.rng.randi_range(0, 1) - 0.5
		sockets += shift


func get_mana_value() -> int:
	return mana.stack.get_number()


func get_power_value() -> int:
	return power.stack.get_number()


func update_borders(side_: String) -> void:
	var input = {}
	input.type = "power"
	input.subtype = side_
	power.title.set_attributes(input)
	mana.visible = false
