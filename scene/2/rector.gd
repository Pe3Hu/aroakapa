extends MarginContainer


var temple = null
var fountain = null

func set_attributes(input_: Dictionary) -> void:
	temple = input_.temple
	fountain = temple.fountain


func prepare_distributions() -> Dictionary:
	var distributions = {}
	var kits = prepare_all_kits()
	var kit = get_best_kit(kits)
	
	print("___")
	for cultivator in kit:
		print([cultivator.get_index(), cultivator.get_mana_value(), cultivator.get_power_value()])
	
	return distributions


func prepare_all_kits() -> Array:
	var kits = []
	
	var cultivators = fountain.cultivators.get_children()
	
	#indexs.shuffle()
	#indexs.append(7)
	var constituents = Global.get_all_constituents(cultivators)
	
	for size_ in constituents:
		for constituent in constituents[size_]:
			if check_for_sufficient_mana(constituent):
				kits.append(constituent)
	
	return kits


func check_for_sufficient_mana(cultivators_: Array) -> bool:
	var mana = 0
	
	for cultivator in cultivators_:
		mana += cultivator.get_mana_value()
		
		if mana > fountain.mana:
			return false
	
	return true


func get_best_kit(kits_: Array) -> Array:
	var datas = []
	
	for cultivators_ in kits_:
		var data = {}
		data.cultivators = cultivators_
		data.power = 0
		
		for cultivator in cultivators_: 
			data.power += cultivator.get_power_value()
		
		datas.append(data)
	
	datas.sort_custom(func(a, b): return a.power > b.power)
	var kit = datas.front().cultivators
	return kit
