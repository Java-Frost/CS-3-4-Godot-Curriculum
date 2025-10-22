extends Area2D

@onready var player = %Player
@onready var anim = $AnimatedSprite2D
@onready var boss_health = $"../../../UI/Boss_Health"
@onready var boss = $"../../../Final Boss"

@export var on = false

func _ready() -> void:
	hide()
	anim.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		if on == true:
			anim.play("break")
			boss_health.take_damage()
			await anim.animation_finished
			boss.waiting_for_hit = false
			queue_free()
