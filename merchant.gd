extends CharacterBody2D

@onready var player = %Player
@onready var menu = $"../UI/Menu"
@onready var label = $Label
@onready var inv = $"../UI/Inventory"
@onready var secuess = $AudioStreamPlayer2D

func _ready() -> void:
	label.hide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		body.is_attacking = true
		body.can_attack = false
		body.animated_sprite.play("idle_forward")
		label.show()
		await get_tree().create_timer(1).timeout
		label.text = "What would \nyou like to buy?"
		await get_tree().create_timer(1.3).timeout
		label.text = "Hello!"
		label.hide()
		body.can_view_inventory = false
		inv.hide()
		menu.show()
		body.hide()
		#get_tree().change_scene_to_file("res://menu.tscn")
		



func _unbind_player(body):
	body.is_attacking = false
	body.show()
	body.can_attack = true
	body.can_view_inventory = true



func insufficient_funds():
	label.text = "Insufficient\nfunds"
	label.show()
	await get_tree().create_timer(1.3).timeout
	label.text = "Hello!"
	label.hide()
