extends Area2D

@onready var label = $Label
@onready var player = %Player
@export var type:String = "chest"
@export var amount:int = 50




func _ready() -> void:
	label.hide()




func collect_chest() -> void:
	$AnimatedSprite2D.play()
	await $AnimatedSprite2D.animation_finished
	queue_free()
	player.collect_pickup(type, amount)


func _on_body_entered(body):
	if body == player:
		if "Key" in body.inventory:
			print("opening!")
			body.remove_item("Key")
			collect_chest()
		else:
			label.show()

func _on_body_exited(body: Node2D) -> void:
	if body == player:
		await get_tree().create_timer(0.5).timeout
		label.hide()
