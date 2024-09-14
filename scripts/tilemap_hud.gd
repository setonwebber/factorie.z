extends TileMapLayer

var tileBuffer = Vector2i(0, 0)

func _process(_delta: float) -> void:
	var tile = local_to_map(get_global_mouse_position())

	if tile != tileBuffer:
		erase_cell(tileBuffer)
		tileBuffer = tile
		set_cell(tile, 0, Vector2i(0,0), 0)
