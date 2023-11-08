extends Node


var rng = RandomNumberGenerator.new()
var arr = {}
var num = {}
var vec = {}
var color = {}
var dict = {}
var flag = {}
var node = {}
var scene = {}


func _ready() -> void:
	init_arr()
	init_num()
	init_vec()
	init_color()
	init_dict()
	init_node()
	init_scene()


func init_arr() -> void:
	arr.edge = [1, 2, 3, 4, 5, 6]
	arr.aspect = ["mana", "power"]


func init_num() -> void:
	num.index = {}
	
	num.sanctuary = {}
	num.sanctuary.shrines = 5


func init_dict() -> void:
	init_neighbor()
	init_shrine()
	init_temple()
	init_fountain()
	init_mindset()


func init_neighbor() -> void:
	dict.neighbor = {}
	dict.neighbor.linear3 = [
		Vector3( 0, 0, -1),
		Vector3( 1, 0,  0),
		Vector3( 0, 0,  1),
		Vector3(-1, 0,  0)
	]
	dict.neighbor.linear2 = [
		Vector2( 0,-1),
		Vector2( 1, 0),
		Vector2( 0, 1),
		Vector2(-1, 0)
	]
	dict.neighbor.diagonal = [
		Vector2( 1,-1),
		Vector2( 1, 1),
		Vector2(-1, 1),
		Vector2(-1,-1)
	]
	dict.neighbor.zero = [
		Vector2( 0, 0),
		Vector2( 1, 0),
		Vector2( 1, 1),
		Vector2( 0, 1)
	]
	dict.neighbor.hex = [
		[
			Vector2( 1,-1), 
			Vector2( 1, 0), 
			Vector2( 0, 1), 
			Vector2(-1, 0), 
			Vector2(-1,-1),
			Vector2( 0,-1)
		],
		[
			Vector2( 1, 0),
			Vector2( 1, 1),
			Vector2( 0, 1),
			Vector2(-1, 1),
			Vector2(-1, 0),
			Vector2( 0,-1)
		]
	]


func init_shrine() -> void:
	dict.shrine = {}
	dict.shrine[0] = {}
	dict.shrine[0].title = "inheritor"
	dict.shrine[0].multiplier = 4
	dict.shrine[1] = {}
	dict.shrine[1].title = "interim"
	dict.shrine[1].multiplier = 3
	dict.shrine[2] = {}
	dict.shrine[2].title = "inferior"
	dict.shrine[2].multiplier = 2


func init_temple() -> void:
	dict.temple = {}
	dict.temple.rank = {}
	
	var path = "res://asset/json/aroakapa_temple.json"
	var array = load_data(path)
	
	for temple in array:
		var data = {}
		
		for key in temple:
			if key != "rank":
				data[key] = temple[key]
		
		dict.temple.rank[int(temple.rank)] = data


func init_fountain() -> void:
	dict.fountain = {}
	dict.fountain.round = {}
	
	var path = "res://asset/json/aroakapa_fountain.json"
	var array = load_data(path)
	
	for fountain in array:
		var data = {}
		data.rank = {}
		
		for key in fountain:
			if key != "round" and fountain[key] != 0:
				var words = key.split(" ")
				
				if words.has("rank"):
					data.rank[int(words[1])] = fountain[key] / 5
				else:
					data[key] = fountain[key]
		
		dict.fountain.round[int(fountain.round)] = data


func init_mindset() -> void:
	dict.priority = {}
	dict.priority.weight = {}
	dict.priority.weight["disregard"] = 1
	dict.priority.weight["balance"] = 3
	dict.priority.weight["domination"] = 6
	
	dict.mindset = {}
	dict.mindset.title = {}
	
	var path = "res://asset/json/aroakapa_mindset.json"
	var array = load_data(path)
	
	for mindset in array:
		var data = {}
		data.parts = 0
		data.priorities = {}
		
		for key in mindset:
			if key != "title":
				var words = key.split(" ")
				
				if !data.priorities.has(words[0]):
					data.priorities[words[0]] = {}
				
				data.priorities[words[0]][int(words[1])] = mindset[key]
				data.parts += dict.priority.weight[mindset[key]]
		
		dict.mindset.title[mindset.title] = data
	


func init_node() -> void:
	node.game = get_node("/root/Game")


func init_scene() -> void:
	scene.temple = load("res://scene/2/temple.tscn")
	scene.mage = load("res://scene/2/mage.tscn")
	scene.aspect = load("res://scene/2/aspect.tscn")
	
	scene.sanctuary = load("res://scene/3/sanctuary.tscn")
	scene.shrine = load("res://scene/3/shrine.tscn")
	
	get_all_constituents([1,2,3,4,5])
	pass


func init_vec():
	vec.size = {}
	vec.size.letter = Vector2(20, 20)
	vec.size.icon = Vector2(48, 48)
	vec.size.number = Vector2(5, 32)
	
	vec.size.aspect = Vector2(32, 32)
	vec.size.shrine = Vector2(100, 100)
	vec.size.bar = Vector2(120, 12)
	
	init_window_size()


func init_window_size():
	vec.size.window = {}
	vec.size.window.width = ProjectSettings.get_setting("display/window/size/viewport_width")
	vec.size.window.height = ProjectSettings.get_setting("display/window/size/viewport_height")
	vec.size.window.center = Vector2(vec.size.window.width/2, vec.size.window.height/2)


func init_color():
	var h = 360.0
	color.indicator = {}
	color.indicator.health = {}
	color.indicator.health.fill = Color.from_hsv(0, 1, 0.9)
	color.indicator.health.background = Color.from_hsv(0, 0.25, 0.9)
	color.indicator.endurance = {}
	color.indicator.endurance.fill = Color.from_hsv(0.33, 1, 0.9)
	color.indicator.endurance.background = Color.from_hsv(0.33, 0.25, 0.9)
	color.indicator.barrier = {}
	color.indicator.barrier.fill = Color.from_hsv(0.5, 1, 0.9)
	color.indicator.barrier.background = Color.from_hsv(0.5, 0.25, 0.9)
	
	color.shrine = {}
	color.shrine.inferior = Color.from_hsv(180 / h, 0.9, 0.7)
	color.shrine.interim = Color.from_hsv(210 / h, 0.8, 0.8)
	color.shrine.inheritor = Color.from_hsv(240 / h, 0.7, 0.9)
	
	color.side = {}
	color.side.left = Color.from_hsv(110 / h, 0.6, 0.9)
	color.side.right = Color.from_hsv(290 / h, 0.6, 0.9)
	


func save(path_: String, data_: String):
	var path = path_ + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(data_)


func load_data(path_: String):
	var file = FileAccess.open(path_, FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var parse_err = json_object.parse(text)
	return json_object.get_data()


func get_random_key(dict_: Dictionary):
	if dict_.keys().size() == 0:
		print("!bug! empty array in get_random_key func")
		return null
	
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	rng.randomize()
	var index_r = rng.randf_range(0, 1)
	var index = 0
	
	for key in dict_.keys():
		var weight = float(dict_[key])
		index += weight/total
		
		if index > index_r:
			return key
	
	print("!bug! index_r error in get_random_key func")
	return null


func get_all_substitutions(array_: Array) -> Array:
	var result = [[]]
	
	for _i in array_.size():
		var slot_options = array_[_i]
		var next = []
		
		for arr_ in result:
			for option in slot_options:
				var pair = []
				pair.append_array(arr_)
				pair.append(option)
				next.append(pair)
		
		result = next
		
		for _j in range(result.size()-1,-1,-1):
			if result[_j].size() < _i+1:
				result.erase(result[_j])
	
	return result


func get_all_permutations(array_: Array) -> Array:
	var result = []
	permutation(result, array_, 0)
	return result


func permutation(result_: Array, array_: Array, l_: int) -> void:
	if l_ >= array_.size():
		var array = []
		array.append_array(array_)
		result_.append(array)
		return
	
	permutation(result_, array_, l_+1)
	
	for _i in range(l_+1,array_.size(),1):
		swap(array_, l_, _i)
		permutation(result_, array_, l_+1)
		swap(array_, l_, _i)


func swap(array_: Array, i_: int, j_: int) -> void:
	var temp = array_[i_]
	array_[i_] = array_[j_]
	array_[j_] = temp


func get_all_constituents(array_: Array) -> Dictionary:
	var constituents = {}
	constituents[0] = []
	constituents[1] = []
	
	for child in array_:
		constituents[0].append(child)
		constituents[1].append([child])
	
	for _i in array_.size()-2:
		set_constituents_based_on_size(constituents, _i+2)
	
	constituents[array_.size()] = [constituents[0]]
	constituents.erase(0)
	return constituents


func set_constituents_based_on_size(constituents_: Dictionary, size_: int) -> void:
	var parents = constituents_[size_-1]
	var indexs = []
	constituents_[size_] = []
	
	for parent in parents:
		for child in constituents_[0]:
			if !parent.has(child):
				var constituent = []
				constituent.append_array(parent)
				constituent.append(child)
				constituent.sort_custom(func(a, b): return constituents_[0].find(a) < constituents_[0].find(b))
				
				if !constituents_[size_].has(constituent):
					constituents_[size_].append(constituent)
