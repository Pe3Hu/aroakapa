extends MarginContainer


@onready var bg = $BG

var sanctuary = null
var type = null
var multiplier = null


func set_attributes(input_: Dictionary) -> void:
	sanctuary = input_.sanctuary
	
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
