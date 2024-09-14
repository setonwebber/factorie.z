extends TileMapLayer

var buildingDic = {}
var occupiedTiles = []
var buildingType
var scene_to_instance = preload("res://entities/miner.tscn")
var buildingNumber = 0

func _process(_delta: float) -> void:
	var tile = local_to_map(get_global_mouse_position())
	if Input.is_action_just_released("left_click"):
		# get whatever building is in the hotbar
		buildingType = "miner"
		# get size of building 
		
		if !occupiedTiles.has(tile):
			occupiedTiles.append(tile)
			instance_object(tile)


func instance_object(position):
	buildingNumber =+ 1
	var object = scene_to_instance.instantiate()
	object.position = position * 64
	object.name = str("miner", buildingNumber)
	add_child(object, true)
