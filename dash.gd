extends Control

@export var dashes_left = 4

func  _ready() -> void:
	$AnimatedSprite2D.frame = 4

func dash():
	dashes_left = dashes_left - 1
	if dashes_left <= 0:
		dashes_left = 0
	$AnimatedSprite2D.frame = dashes_left

func recharge():
	dashes_left = dashes_left + 1
	if dashes_left >= 4:
		dashes_left = 4
	$AnimatedSprite2D.frame = dashes_left

func _on_timer_timeout() -> void:
	recharge()
