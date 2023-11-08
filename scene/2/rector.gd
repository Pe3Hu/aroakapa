extends MarginContainer


var temple = null
var fountain = null
var mindset = null


func set_attributes(input_: Dictionary) -> void:
	temple = input_.temple
	fountain = temple.fountain
	
	mindset = "sparrow"


func prepare_distributions() -> Dictionary:
	var distributions = {}
	var all_kits = prepare_all_kits()
	var best_kits = get_best_kits(all_kits)
	var kit = best_kits.front()
	var kits_distributions = get_kits_distribution(best_kits)
	apply_distribution(kits_distributions[best_kits.front()])
	
	print("___", best_kits.size())
	for mage in kit:
		print([mage.get_index(), mage.get_mana_value(), mage.get_power_value()])
	
	return distributions


func prepare_all_kits() -> Array:
	var kits = []
	
	var mages = fountain.mages.get_children()
	
	#indexs.shuffle()
	#indexs.append(7)
	var constituents = Global.get_all_constituents(mages)
	
	for size_ in constituents:
		for constituent in constituents[size_]:
			if check_for_sufficient_mana(constituent):
				kits.append(constituent)
	
	return kits


func check_for_sufficient_mana(mages_: Array) -> bool:
	var mana = 0
	
	for mage in mages_:
		mana += mage.get_mana_value()
		
		if mana > fountain.mana:
			return false
	
	return true


func get_best_kits(kits_: Array) -> Array:
	var datas = []
	
	for mages_ in kits_:
		var data = {}
		data.mages = mages_
		data.power = 0
		
		for mage in mages_: 
			data.power += mage.get_power_value()
		
		datas.append(data)
	
	datas.sort_custom(func(a, b): return a.power > b.power)
	var kits = []
	
	for data in datas:
		if data.power == datas.front().power:
			kits.append(data.mages)
	
	return kits


func get_kits_distribution(kits_: Array) -> Dictionary:
	var power = 0
	var kit = kits_.front()
	
	for mage in kit:#kits_.front():
		power += mage.get_power_value()
	
	var distributions = {}
	var parts = Global.dict.mindset.title[mindset].parts
	var powers = {}
	
	distributions[kit] = {}
	var mages = []
	mages.append_array(kit)
	
	#print(power)
	for shrine in temple.sanctuary.shrines.get_children():
		var priority = shrine.priorities[self]
		var part = float(Global.dict.priority.weight[priority]) / parts
		powers[shrine] = floor(part * power)
		distributions[kit][shrine] = {}
		distributions[kit][shrine].power = -powers[shrine]
		distributions[kit][shrine].mages = [] 
		#print(powers[shrine])
		
		for mage in mages:
			if mage.get_power_value() + -powers[shrine] < 0:
				distributions[kit][shrine].power += mage.get_power_value()
				distributions[kit][shrine].mages.append(mage)
				mages.erase(mage)
				break
		
		if distributions[kit][shrine].mages.is_empty():
			var mage = mages.pop_front()
			
			if mage != null:
				distributions[kit][shrine].power += mage.get_power_value()
				distributions[kit][shrine].mages.append(mage)
	
	
	for mage in mages:
		var shrine = null
		
		for shrine_ in distributions[kit]:
			if distributions[kit][shrine_].power < 0:
				shrine = shrine_
				break
			
		
		if shrine != null:
			distributions[kit][shrine].power += mage.get_power_value()
			distributions[kit][shrine].mages.append(mage)
		
	
	
	
	return distributions


func apply_distribution(distribution_: Dictionary) -> void:
	for shrine in distribution_:
		for mage in distribution_[shrine].mages:
			shrine.add_mage(mage)
