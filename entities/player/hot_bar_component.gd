extends Node
class_name HotBarComponent

@export var currentHotBarId := 0
signal updatedHotbar
var hotBar = []

func _ready() -> void:
	hotBar.append("res://entities/miners/miner_tier1/miner_tier1.tscn")

func getBuilding():
	if hotBar[currentHotBarId]:
		return hotBar[currentHotBarId]
	else:
		return 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("hotbar_1"):
		currentHotBarId = 0
		updatedHotbar.emit()
	elif event.is_action_pressed("hotbar_2"):
		currentHotBarId = 1
		updatedHotbar.emit()
	elif event.is_action_pressed("hotbar_3"):
		currentHotBarId = 2
		updatedHotbar.emit()
	elif event.is_action_pressed("hotbar_4"):
		currentHotBarId = 3
		updatedHotbar.emit()
	elif event.is_action_pressed("hotbar_5"):
		currentHotBarId = 4
		updatedHotbar.emit()
	elif event.is_action_pressed("hotbar_6"):
		currentHotBarId = 5
		updatedHotbar.emit()
	elif event.is_action_pressed("hotbar_7"):
		currentHotBarId = 6
		updatedHotbar.emit()
	elif event.is_action_pressed("hotbar_8"):
		currentHotBarId = 7
		updatedHotbar.emit()
	elif event.is_action_pressed("hotbar_9"):
		currentHotBarId = 8
		updatedHotbar.emit()
