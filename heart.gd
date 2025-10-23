extends Area2D

@onready var player = %Player
@onready var anim = $AnimatedSprite2D
@onready var boss_health = $"../../../UI/Boss_Health"
@onready var boss = $"../../../Final Boss"
@onready var animp = $AnimationPlayer
@onready var main = $"../../.."

@export var on = false

func _ready() -> void:
	hide()
	anim.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		if on == true:
			on = false
			anim.play("break")
			boss_health.take_damage()
			main.shatter_sound()
			await anim.animation_finished
			boss.waiting_for_hit = false
			queue_free()
