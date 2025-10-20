extends StaticBody2D

@onready var anim = $head
@onready var player = %Player



func _ready() -> void:
	anim.play("idle")

func _process(delta: float) -> void:
	var face_right = player.global_position.x > global_position.x
	scale.x = abs(scale.x) * (1 if face_right else -1)
	#if player.global_position.x > global_position.x:
		#anim.flip_h = false
	#else:
		#anim.flip_h = true

func die():
	queue_free()


func attack():
	pass
