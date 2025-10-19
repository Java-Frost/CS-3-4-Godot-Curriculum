extends Node2D

@onready var player = %Player

@export var colideing = false


func _ready() -> void:
	var p = get_tree().get_current_scene().get_node_or_null("Player")
	if p:
		player = p


func _process(delta: float) -> void:
	if player.is_breaking == true:
		if colideing == true:
			player.get_item("torch")
			queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		colideing = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		colideing = false
