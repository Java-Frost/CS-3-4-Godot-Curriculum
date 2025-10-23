extends Area2D

@onready var player = %Player
@export var alr = false

func _on_body_entered(body):
	if body == player:
		if alr == false:
			alr = true
			$AnimationPlayer.play("disappear")
			player.get_item("gold_key")
			$"..".ding_sound()
		
