extends Control

@onready var player = %Player
@onready var grid = $Grid
@onready var inv = $"."


func add_item_to_slot(slot_index: int, name: String, ammount: String):
	var item = load("res://item.tscn").instantiate()
	var slot = grid.get_child(slot_index)
	var r = slot.get_global_rect()
	var center = r.position + r.size * 0.5
	inv.add_child(item)
	var rect = inv.get_global_rect()
	var global_vec = center - rect.position
	var parent_scale = Vector2(1, 1)
	parent_scale = inv.get_global_transform().get_scale()
	if parent_scale.x == 0 or parent_scale.y == 0:
		parent_scale = Vector2(1, 1)
	item.position = (global_vec / parent_scale)
	item.set_item(name)
	item.item_ammount(ammount)
