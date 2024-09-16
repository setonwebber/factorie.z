extends TileMapLayer

var gridSize = Global.GRIDSIZE
@onready var player = $"/root/game/player"

var object
var tileBuffer = Vector2i(0, 0)
var tile

var rotation_updated = false

var buildingSize: int


func _process(_delta: float) -> void:
	rotateBuildings()
	tile = local_to_map(get_global_mouse_position())
	if tile != tileBuffer or rotation_updated:
		rotation_updated = false
		var building = player.currentBuilding
		
		erase_cell(tileBuffer)
		tileBuffer = tile
		set_cell(tile, 0, Vector2i(0,0), 0)
		
		if object:
			object.queue_free()
		previewBuilding(tile, building)

func previewBuilding(pos, building):
	object = load(building).instantiate()
	object.position = pos * gridSize + Vector2i(gridSize / 2, gridSize / 2)
	object.name = "preview"
	object.modulate.a = 0.2
	match Global.HUD_SELECTION_ROTATION:
		"south":
			object.set_rotation_degrees(0)
		"west":
			object.set_rotation_degrees(90)
		"north":
			object.set_rotation_degrees(180)
		"east":	
			object.set_rotation_degrees(270)
	add_child(object, true)

func getBuildingDetails(building):
	object = load(building).instantiate()
	var buildingComponent = object.get_child(0)
	buildingSize = buildingComponent.buildingSize

func rotateBuildings():
	if Input.is_action_pressed("hud_alternativepress"):
		if Input.is_action_just_pressed("hud_rotation"):
			rotation_updated = true
			match Global.HUD_SELECTION_ROTATION:
				"south":
					Global.HUD_SELECTION_ROTATION = "east"
				"west":
					Global.HUD_SELECTION_ROTATION = "south"
				"north":
					Global.HUD_SELECTION_ROTATION = "west"
				"east":	
					Global.HUD_SELECTION_ROTATION = "north"
	else:
		if Input.is_action_just_pressed("hud_rotation"):
			rotation_updated = true
			match Global.HUD_SELECTION_ROTATION:
				"south":
					Global.HUD_SELECTION_ROTATION = "west"
				"west":
					Global.HUD_SELECTION_ROTATION = "north"
				"north":
					Global.HUD_SELECTION_ROTATION = "east"
				"east":	
					Global.HUD_SELECTION_ROTATION = "south"
#func _on_buildings_placed_building(occupiedTiles) -> void:
	#for tile in occupiedTiles:
		#set_cell(tile, 0, Vector2i(0,0), 0)
