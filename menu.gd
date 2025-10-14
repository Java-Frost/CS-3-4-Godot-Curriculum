extends Control

@onready var player = %Player
@onready var merch = $"../../Merchant"


func _on_button_pressed() -> void:
	if player.coins >= 10:
		player.change_health(20)
		player.coins = player.coins - 10
		hide()
		merch._unbind_player(player)
	else:
		hide()
		merch._unbind_player(player)
		merch.insufficient_funds()


func _on_button_2_pressed() -> void:
	if player.coins >= 50:
		player.get_item("Key")
		player.coins = player.coins - 50
		hide()
		merch._unbind_player(player)
	else:
		hide()
		merch._unbind_player(player)
		merch.insufficient_funds()
