extends Area2D

@onready var anim = $AnimatedSprite2D
@onready var label = $Label
@onready var grid = $"../Grid"
@export var drag = false
@export var offset = Vector2(0, 0)
@export var offsetsprite = Vector2(-10, -10)
var mainparent = null
var mainpos = Vector2.ZERO

func set_item(item):
	anim.play(item)

func item_ammount(ammount):
	label.text = ammount

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				anim.scale = Vector2(1.4, 1.4)
				drag = true
				offset = get_global_mouse_position() - global_position
				mainparent = get_parent()
				mainpos = position
				get_tree().root.add_child(self)
				z_index = 10
			else:
				drag = false
				anim.scale = Vector2(1, 1)
				z_index = 0 

				var closest_panel = find_closest_panel()
				if closest_panel:
					var panel_position = closest_panel.global_position
					mainpos = panel_position
					mainparent.add_child(self)
					position = mainpos - offsetsprite
					
				else:
					mainparent.add_child(self)
					position = mainpos
	
func _process(delta):
	if drag:
		global_position = get_global_mouse_position() - offset

func find_closest_panel():
	var closest_panel = null
	var min_distance = 12
	
	for panel in grid.get_children():
		if panel is Panel:
			if panel.get_child_count() == 0:
				var panel_rect = panel.get_global_rect()
				var distance = get_global_mouse_position().distance_to(panel_rect.get_center())
				if distance < min_distance:
					min_distance = distance
					closest_panel = panel
	return closest_panel
