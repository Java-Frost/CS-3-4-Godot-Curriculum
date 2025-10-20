extends CharacterBody2D

@onready var player = %Player

@export var speed = 300


func _physics_process(delta: float) -> void:
	var target = player.position
	var target_direction = position.direction_to(target)
	velocity = speed * target_direction
	move_and_slide()



func _on_projectile_body_entered(body: Node2D) -> void:
	if body == player:
		queue_free()
