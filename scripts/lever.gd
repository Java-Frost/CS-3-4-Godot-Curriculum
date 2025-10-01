extends Area2D

@onready var door = $"../Door"

func play_animation(reverse: bool = false) -> void:
	var speed: int
	if reverse:
		speed = -1
	else:
		speed = 1
	$AnimatedSprite2D.play("", speed, reverse)




func _on_body_entered(body: Node2D) -> void:
	door.set_is_open(true)
	print("e")
