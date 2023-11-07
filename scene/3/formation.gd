extends MarginContainer


@onready var mages = $Mages

var shrine = null
var temple = null


func set_attributes(input_: Dictionary) -> void:
	shrine = input_.shrine
	temple = input_.temple

