extends Area2D

@onready var anim = $AnimatedSprite2D
@onready var stuff = $Tilemap/StuffOnTop
@onready var inv = $UI/Inventory
@onready var player = %Player
@onready var label = $Label
@onready var grid = $"../Grid"
@onready var light = $CanvasModulate
@export var drag = false
@export var offset = Vector2.ZERO
@export var offsetsprite = Vector2(0, 0)
var mainparent = null
var mainpos = Vector2.ZERO

func _ready() -> void:
	var p = get_tree().get_current_scene().get_node_or_null("Player")
	if p:
		player = p
	var l = get_tree().get_current_scene().get_node_or_null("CanvasModulate")
	if l:
		light = l
	var i = get_tree().get_current_scene().get_node_or_null("UI/Inventory")
	if i:
		inv = i
	var s = get_tree().get_current_scene().get_node_or_null("Tilemap/StuffOnTop")
	if s:
		stuff = s

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
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			use_item()

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


func use_item():
	if anim.animation == "blue_flask":
		$AnimationPlayer.play("disappear")
		await get_tree().create_timer(0.6).timeout
		light.hide()
		inv.hide()
		$"../../..".warp_sound()
		player.remove_item_silent("blue_flask")
		player.is_attacking = false
		player.can_attack = true
		player.viewing_inv = false
		queue_free()
	elif anim.animation == "red_flask":
		$AnimationPlayer.play("disappear")
		await get_tree().create_timer(0.6).timeout
		player.change_health(20)
		inv.hide()
		$"../../..".potion_sound()
		player.remove_item_silent("red_flask")
		player.is_attacking = false
		player.can_attack = true
		player.viewing_inv = false
		queue_free()
	elif anim.animation == "torch":
		queue_free()
		var torch = load("res://scenes/torch.tscn").instantiate()
		stuff.add_child(torch)
		torch.global_position = player.global_position
		inv.hide()
		player.remove_item_silent("torch")
		player.is_attacking = false
		player.can_attack = true
		player.viewing_inv = false
		queue_free()
		
