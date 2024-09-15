extends TileMapLayer

var buildingDic = {}
var occupiedTiles = []
var buildingType
var scene_to_instance = preload("res://entities/miner.tscn")
var buildingNumber = 0
var buildingSize
var minerSize = 3

func _process(_delta: float) -> void:
	var tile = local_to_map(get_global_mouse_position())
	if Input.is_action_just_released("left_click") and occupiedTiles.has(tile):
		for x in minerSize:
			tile 
			for y in minerSize:
				occupiedTiles.append(tile + x)
		
		occupiedTiles.append(tile)
		placeBuilding(tile)


func placeBuilding(position):
	buildingNumber =+ 1
	var object = scene_to_instance.instantiate()
	object.position = position * 64
	object.name = str("miner", buildingNumber)
	add_child(object, true)
