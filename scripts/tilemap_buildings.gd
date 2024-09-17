extends TileMapLayer

var gridSize = Global.GRIDSIZE
@onready var player = $"../player"
@onready var hotbarComponent = $"../player/HotBarComponent"

var buildingDic = {}
var occupiedTiles = []
var hotbarObjects = []

var buildingType
var buildingNumber = 0
var buildingSize
var buildingTier
var buildingPath

var object

signal placedBuilding

func _ready() -> void:
	for x in hotbarComponent.getHotbar():
		if x:
			hotbarObjects.append(load(x))
		else:
			hotbarObjects.append("null")

func _process(_delta: float) -> void:
	getBuildingDetails()
	var tile = local_to_map(get_global_mouse_position())
	if Input.is_action_pressed("left_click") and !Global.HUD_SELECTION_OVERBUILDING and !Global.HUD_SELECTION_BUILDINGOVERLAP:
		print(Global.HUD_SELECTION_BUILDINGOVERLAP)
		placeBuilding(tile)
		placedBuilding.emit(occupiedTiles)
	
	if Input.is_action_pressed("right_click") and Global.HUD_SELECTION_OVERBUILDING and is_instance_valid(Global.HUD_SELECTION_BUILDING):
		Global.HUD_SELECTION_BUILDING.queue_free()

func placeBuilding(pos):
	buildingNumber += 1
	if buildingSize % 2 == 0:
		object.position = pos * gridSize + Vector2i(gridSize, gridSize)
	else:
		object.position = pos * gridSize + Vector2i(gridSize / 2, gridSize / 2)
	object.name = str(buildingType, buildingNumber)
	updateBuildingDetails()
	match Global.HUD_SELECTION_ROTATION:
		"south":
			object.set_rotation_degrees(0)
		"west":
			object.set_rotation_degrees(90)
		"north":
			object.set_rotation_degrees(180)
		"east":	
			object.set_rotation_degrees(270)
	
	buildingDic[str(pos)] = {
		"Type": buildingType,
		"Rotation": Global.HUD_SELECTION_ROTATION,
		"Tier": buildingTier
	}
	add_child(object, true)

func updateBuildingDetails():
	var buildingComponent = object.get_child(0)
	buildingComponent.buildingPlaced = true
	buildingComponent.buildingType = buildingType
	buildingComponent.buildingSize = buildingSize
	buildingComponent.buildingTier = buildingTier

func getBuildingDetails():
	object = hotbarObjects[Global.HUD_HOTBAR_CURRENTID].instantiate()
	var buildingComponent = object.get_child(0)
	buildingType = buildingComponent.buildingType
	buildingSize = buildingComponent.buildingSize
	buildingTier = buildingComponent.buildingTier


func _on_hot_bar_component_updated_hotbar() -> void:
	hotbarObjects.clear()
	for x in hotbarComponent.hotBar:
		if x:
			hotbarObjects.append(load(x))
		else:
			hotbarObjects.append("null")
