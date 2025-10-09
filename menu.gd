extends Control

@onready var player = %Player

func _on_button_pressed() -> void:
	player.change_health(20)
	hide()


func _on_button_2_pressed() -> void:
	player.get_item("Key")
	hide()
