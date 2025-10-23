extends AnimatableBody2D


func set_is_open(is_open: bool):
	if is_open:
		print("open")
		$AnimatedSprite2D.frame = 0
		$"../../..".door_sound()
		collision_layer = 1
		$LightOccluder2D.visible = false
	else:
		print("closed")
		$AnimatedSprite2D.frame = 1
		$"../../..".door_sound()
		collision_layer = 0
		$LightOccluder2D.visible = true
