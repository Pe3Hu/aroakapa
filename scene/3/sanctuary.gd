extends MarginContainer


@onready var shrines = $VBox/Shrines
@onready var temples = $VBox/Temples

var wilderness = null
var mountains = null


func set_attributes(input_: Dictionary) -> void:
	wilderness = input_.wilderness
	mountains = wilderness.world.mountains
	
	for temple in input_.temples:
		add_temple(temple)
	
	init_shrines()
	phase_0()
	


func init_shrines() -> void:
	for _i in Global.num.sanctuary.shrines:
		var input = {}
		input.sanctuary = self
	
		var shrine = Global.scene.shrine.instantiate()
		shrines.add_child(shrine)
		shrine.set_attributes(input)


func add_temple(temple_: MarginContainer) -> void:
	mountains.temples.remove_child(temple_)
	temples.add_child(temple_)


func phase_0() -> void:
	for temple in temples.get_children():
		temple.fountain.cultivators_reenrollment()
		temple.rector.prepare_distributions()
