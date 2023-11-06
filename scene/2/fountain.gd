extends MarginContainer


@onready var cultivators = $Cultivators

var temple = null
var count = 6
var round = null
var mana = null


func set_attributes(input_: Dictionary) -> void:
	temple = input_.temple
	
	set_next_round()


func set_next_round() -> void:
	if round == null:
		round = 1
	else:
		round += 1
	
	mana = Global.dict.fountain.round[round].mana


func expel_all_cultivators() -> void:
	while cultivators.get_child_count() > 0:
		var cultivator = cultivators.get_child(0)
		cultivators.remove_child(cultivator)
		temple.cultivators.add_child(cultivator)


func cultivators_reenrollment() -> void:
	while cultivators.get_child_count() < count:
		var rank = get_random_rank_based_on_current_round()
		var cultivator = get_random_cultivator_based_on_rank(rank)
		temple.cultivators.remove_child(cultivator)
		cultivators.add_child(cultivator)


func get_random_rank_based_on_current_round() -> int:
	var ranks = Global.dict.fountain.round[round].rank
	var rank = Global.get_random_key(ranks)
	return rank


func get_random_cultivator_based_on_rank(rank_: int) -> Variant:
	if rank_ > 0:
		var options = []
		
		for cultivator in temple.cultivators.get_children():
			if cultivator.rank == rank_:
				options.append(cultivator)
		
		var cultivator = null
		
		if !options.is_empty():
			cultivator = options.pick_random()
		else:
			cultivator = get_random_cultivator_based_on_rank(rank_ - 1)
		
		return  cultivator
	
	print("error: unsuitable cultivators")
	return null
