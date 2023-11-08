extends MarginContainer


@onready var bg = $BG
@onready var left = $HBox/Left
@onready var right = $HBox/Right
@onready var equilibrium = $HBox/Equilibrium

var sanctuary = null
var type = null
var multiplier = null
var priorities = {}
var sides = {}


func set_attributes(input_: Dictionary) -> void:
	sanctuary = input_.sanctuary
	
	var input = {}
	input.shrine = self
	input.type = "equilibrium"
	input.subtype = "equal"
	input.value = 0
	equilibrium.set_attributes(input)
	set_type()


func set_type() -> void:
	var index = get_index()
	var order = abs(Global.num.sanctuary.shrines / 2  - index)
	type = Global.dict.shrine[order].title
	multiplier = Global.dict.shrine[order].multiplier
	
	var style = StyleBoxFlat.new()
	bg.set("theme_override_styles/panel", style)
	style.bg_color = Global.color.shrine[type]
	custom_minimum_size = Global.vec.size.shrine


func add_formation(temple_: MarginContainer) -> void:
	if sides.keys().is_empty():
		sides[temple_] = "left"
	else:
		sides[temple_] = "right"
	
	var formation = get(sides[temple_])
	var input = {}
	input.shrine = self
	input.temple = temple_
	formation.set_attributes(input)
	equilibrium.powers[sides[temple_]] = 0


func add_mage(mage_: MarginContainer) -> void:
	var side = sides[mage_.temple]
	var formation = get(side)
	mage_.temple.fountain.mages.remove_child(mage_)
	formation.mages.add_child(mage_)
	equilibrium.change_temple_power(mage_.temple, mage_.get_power_value())
	mage_.update_borders(side)
