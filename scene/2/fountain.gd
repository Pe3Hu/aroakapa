extends MarginContainer


@onready var bg = $BG
@onready var mages = $Mages

var temple = null
var count = 6
var round = null
var mana = null
var side = null


func set_attributes(input_: Dictionary) -> void:
	temple = input_.temple
	
	set_next_round()


func set_side(side_: String) -> void:
	side = side_
	var style = StyleBoxFlat.new()
	bg.set("theme_override_styles/panel", style)
	style.bg_color = Global.color.side[side]


func set_next_round() -> void:
	if round == null:
		round = 1
	else:
		round += 1
	
	mana = Global.dict.fountain.round[round].mana


func expel_all_mages() -> void:
	while mages.get_child_count() > 0:
		var mage = mages.get_child(0)
		mages.remove_child(mage)
		temple.mages.add_child(mage)


func mages_reenrollment() -> void:
	while mages.get_child_count() < count:
		var rank = get_random_rank_based_on_current_round()
		var mage = get_random_mage_based_on_rank(rank)
		temple.mages.remove_child(mage)
		mages.add_child(mage)
	
	sort_based_on_rank()


func get_random_rank_based_on_current_round() -> int:
	var ranks = Global.dict.fountain.round[round].rank
	var rank = Global.get_random_key(ranks)
	return rank


func get_random_mage_based_on_rank(rank_: int) -> Variant:
	if rank_ > 0:
		var options = []
		
		for mage in temple.mages.get_children():
			if mage.rank == rank_:
				options.append(mage)
		
		var mage = null
		
		if !options.is_empty():
			mage = options.pick_random()
		else:
			mage = get_random_mage_based_on_rank(rank_ - 1)
		
		return  mage
	
	print("error: unsuitable mages")
	return null


func sort_based_on_rank() -> void:
	var mages_ = []
	
	while mages.get_child_count() > 0:
		var mage = mages.get_child(0)
		mages.remove_child(mage)
		mages_.append(mage)
	
	mages_.sort_custom(func(a, b): return a.rank < b.rank)
	
	for mage in mages_:
		mages.add_child(mage)
