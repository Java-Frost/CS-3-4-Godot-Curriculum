extends Control

@onready var coin_label = $Label
@onready var health_label = $Label2
@onready var player = %Player


func _process(delta: float) -> void:
	coin_label.text = "Final Coins: " + str(player.coins)
	health_label.text = "Remaining Health: " + str(player.health)
	
