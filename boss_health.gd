extends Control

@onready var boss = $"../../Final Boss"
@onready var anim = $AnimatedSprite2D
@export var health = 5


func _ready() -> void:
	anim.frame = 5


func take_damage():
	health = health - 1
	anim.frame = health
	check_if_dead()


func check_if_dead():
	if health > 0:
		boss.attack()
	else:
		die()

func die():
	await get_tree().create_timer(0.5).timeout
	queue_free()
	boss.die()
