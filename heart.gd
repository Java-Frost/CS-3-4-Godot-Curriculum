extends Area2D

@onready var player = %Player
@onready var anim = $AnimatedSprite2D
@onready var boss_health = $"../../../UI/Boss_Health"

func _ready() -> void:
	anim.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		anim.play("break")
		boss_health.take_damage()
		await anim.animation_finished
		queue_free()
