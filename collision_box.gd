extends Area2D

@onready var player = %Player
@onready var health_bar = $"../../../UI/Boss_Health"
@onready var door2 = $"../Door2"

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		health_bar.show()
		door2.set_is_open(false)
