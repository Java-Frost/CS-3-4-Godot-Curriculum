extends Control

@onready var player = %Player
@onready var merch = $"../../Merchant"
@onready var item1 = $"Display_model # 1"
@onready var item2 = $"Display_model # 2"
@onready var item: String = "null"

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if rng.randi_range(0, 1) == 0:
		item2.animation = "blue_flask"
		item = "blue_flask"
	else:
		item2.animation = "silver_key"
		item = "silver_key"


func _on_button_pressed() -> void:
	if player.coins >= 10:
		player.get_item("red_flask")
		player.coins = player.coins - 10
		hide()
		merch._unbind_player(player)
	else:
		hide()
		merch._unbind_player(player)
		merch.insufficient_funds()


func _on_button_2_pressed() -> void:
	if player.coins >= 50:
		if item == "silver_key":
			player.get_item("silver_key")
		if item == "blue_flask":
			player.get_item("blue_flask")
		player.coins = player.coins - 50
		hide()
		merch._unbind_player(player)
	else:
		hide()
		merch._unbind_player(player)
		merch.insufficient_funds()
