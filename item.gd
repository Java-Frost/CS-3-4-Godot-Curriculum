extends Area2D

@onready var anim = $AnimatedSprite2D
@onready var label = $Label
@export var is_dragging = false
@export var offset = Vector2(0, 0)

func set_item(item):
	anim.play(item)

func item_ammount(ammount):
	label.text = ammount
