extends Area2D

@onready var player = %Player
@onready var health_bar = $"../../../UI/Boss_Health"
@onready var door2 = $"../Door2"
@onready var main = $"../../.."

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		health_bar.show()
		door2.set_is_open(false)
		main.start_boss_song()
		queue_free()
		player.set_spawn()

func idk_what_to_call_these_anymore():
	health_bar.show()
	door2.set_is_open(false)
	main.start_boss_song()
