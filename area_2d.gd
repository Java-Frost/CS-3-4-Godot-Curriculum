extends Area2D

@onready var boss = $"../Final Boss"

func _on_body_entered(body: Node2D) -> void:
	if body == %Player:
		boss.can_attack = true
		queue_free()
