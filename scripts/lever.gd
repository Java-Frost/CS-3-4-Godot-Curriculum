extends Area2D

@onready var door = $"../Door"
@onready var player = %Player
@export var open : bool = false






func play_animation(reverse: bool = false) -> void:
	var speed: int
	if reverse:
		speed = -1
	else:
		speed = 1
	$AnimatedSprite2D.play("", speed, reverse)




func _on_body_entered(body: Node2D) -> void:
	if body == player:
		if open == false:
			door.set_is_open(false)
			open = true
			play_animation(true)
		elif open == true:
			door.set_is_open(true)
			open = false
			play_animation(false)
