extends Area2D

@onready var anim = $AnimatedSprite2D
@onready var label = $Label
@onready var grid = $"../Grid"
@export var drag = false
@export var offset = Vector2.ZERO
@export var offsetsprite = Vector2(0, 0)
var mainparent = null
var mainpos = Vector2.ZERO

func set_item(item):
	anim.play(item)

func item_ammount(ammount):
	label.text = ammount

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			anim.scale = Vector2(1.4, 1.4)
			drag = true
			mainparent = get_parent()
			mainpos = position
			var saved_gt = get_global_transform()
			get_tree().root.add_child(self)
			set_global_transform(saved_gt)
			offset = get_global_mouse_position() - global_position
			z_index = 10
		else:
			drag = false
			anim.scale = Vector2(1, 1)
			z_index = 0
			var closest_panel = find_closest_panel()
			if closest_panel:
				var panel_center_global = get_panel_global_center(closest_panel)
				mainparent.add_child(self)
				print(panel_center_global)
				var rect = mainparent.get_global_rect()
				var global_vec = panel_center_global - rect.position
				var parent_scale = Vector2(1, 1)
				parent_scale = mainparent.get_global_transform().get_scale()
				if parent_scale.x == 0 or parent_scale.y == 0:
					parent_scale = Vector2(1, 1)
				position = (global_vec / parent_scale) - offsetsprite
			else:
				mainparent.add_child(self)
				position = mainpos

func _process(delta):
	if drag:
		global_position = get_global_mouse_position() - offset

func get_panel_global_center(panel) -> Vector2:
	var r = panel.get_global_rect()
	return r.position + r.size * 0.5

func find_closest_panel():
	var closest_panel = null
	var min_distance = 48
	for panel in grid.get_children():
		if panel.get_child_count() == 0:
			var center = get_panel_global_center(panel)
			var distance = get_global_mouse_position().distance_to(center)
			if distance < min_distance:
				min_distance = distance
				closest_panel = panel
	return closest_panel
