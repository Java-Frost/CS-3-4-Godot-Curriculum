extends CharacterBody2D

@onready var player = $Player

@export var speed = 300
var target
var target_direction
var max_offset: float = 20.0

func _ready() -> void:
	var p = get_tree().get_current_scene().get_node_or_null("Player")
	if p:
		player = p
	target = player.position
	_get_random_target_direction()
	#target_direction = position.direction_to(target)

func _physics_process(delta: float) -> void:
	velocity = speed * target_direction
	move_and_slide()



func _on_projectile_body_entered(body: Node2D) -> void:
	if body == player:
		queue_free()


func _get_random_target_direction() -> Vector2:
	var target_pos = player.position
	var random_y_offset = randf_range(-max_offset, max_offset)
	var new_target_pos = target_pos + Vector2(0, random_y_offset)
	target_direction = position.direction_to(new_target_pos)
	return target_direction
