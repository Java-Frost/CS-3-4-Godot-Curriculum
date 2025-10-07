extends Area2D

@onready var player = %Player


func _on_body_entered(body):
	if body == player:
		queue_free()
		player.get_item("Key")
