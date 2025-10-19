extends Area2D

@onready var label = $Label
@onready var player = %Player
@export var type:String = "chest"
@export var amount:int = 50
@export var opening = false




func _ready() -> void:
	label.hide()




func collect_chest() -> void:
	$AnimatedSprite2D.play()
	await $AnimatedSprite2D.animation_finished
	queue_free()
	player.collect_pickup(type, amount)
	opening = true


func _on_body_entered(body):
	if body == player:
		if opening == false:
			if "gold_key" in body.inventory:
				opening = true
				print("opening!")
				body.remove_item("gold_key")
				collect_chest()
			else:
				label.show()

func _on_body_exited(body: Node2D) -> void:
	if body == player:
		await get_tree().create_timer(0.5).timeout
		label.hide()
