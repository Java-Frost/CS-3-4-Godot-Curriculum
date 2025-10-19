extends AnimatableBody2D

@onready var player = %Player
@onready var label = $Label

@export var open = false

func _ready() -> void:
	$AnimatedSprite2D.frame = 5
	label.hide()

func set_is_open(is_open: bool):
	if is_open:
		print("open")
		open = true
		$AnimatedSprite2D.frame = 2
		collision_layer = 2
		$LightOccluder2D.visible = false
	else:
		print("closed")
		$AnimatedSprite2D.frame = 5
		collision_layer = 5
		$LightOccluder2D.visible = true


func _on_area_2d_body_entered(body):
	if body == player:
		if "silver_key" in body.inventory:
			print("opening!")
			body.remove_item("silver_key")
			set_is_open(true)
		elif open == false:
			label.show()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		await get_tree().create_timer(0.5).timeout
		label.hide()
