extends Area2D

@onready var player = %Player


func _on_body_entered(body):
	if body == player:
		$AnimationPlayer.play("disappear")
		player.get_item("gold_key")
		
