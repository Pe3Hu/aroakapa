extends MarginContainer


@onready var health = $VBox/Health

var temple = null


func set_attributes(input_: Dictionary) -> void:
	temple = input_.temple
	
	set_nodes_attributes()


func set_nodes_attributes() -> void:
	var input = {}
	input.core = self
	input.type = "health"
	input.max = 100
	health.set_attributes(input)


func knockout() -> void:
	var shrine = temple.sanctuary.shrines.get_child(0)
	var side = shrine.sides[temple]
	var winner = shrine.get_temple_based_on_side(Global.dict.side.opposite[side])
	temple.sanctuary.winner = winner
	temple.sanctuary.end = true
