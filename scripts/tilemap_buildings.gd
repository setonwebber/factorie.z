extends TileMapLayer

@onready var player = $"/root/game/player"
@onready var building

var buildingDic = {}
var occupiedTiles = []
var buildingType
var buildingNumber = 0
var buildingSize
var minerSize = 3
var gridSize = Global.GRIDSIZE
var currentTile

signal placedBuilding

func _process(_delta: float) -> void:
	building = player.currentBuilding
	var tile = local_to_map(get_global_mouse_position())
	if Input.is_action_just_released("left_click") and !checkIfTilesOccupied(tile):
		placeBuilding(tile)
		placedBuilding.emit(occupiedTiles)

func placeBuilding(pos):
	buildingNumber =+ 1
	var object = load(building).instantiate()
	object.position = pos * gridSize + Vector2i(gridSize / 2, gridSize / 2)
	object.name = str("miner", buildingNumber)
	add_child(object, true)

func checkIfTilesOccupied(tile):
	var currentTile; var occupiedTilesBuffer = []
	for x in minerSize:
			if x > minerSize / 2:
				x = (x * -1) % minerSize / 2
			for y in minerSize:
				if y > minerSize / 2:
					y =  (y * -1) % minerSize / 2
				currentTile = tile + Vector2i(x, y)
				occupiedTilesBuffer.append(currentTile)
	
	for tileBuf in occupiedTilesBuffer:
		if occupiedTiles.has(tileBuf):
			return true
	
	for tileBuf in occupiedTilesBuffer:
		occupiedTiles.append(tileBuf)
		
	occupiedTilesBuffer.clear()
	return false
