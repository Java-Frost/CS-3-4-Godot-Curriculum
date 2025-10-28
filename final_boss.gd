extends StaticBody2D

@onready var anim = $head
@onready var anims = $AnimationPlayer
@onready var player = %Player
@onready var main = $".."
@onready var timer = $Timer
@onready var ws = $"../UI/Winscreen"

@onready var heart1 =$"../Tilemap/StuffOnTop/heart"
@onready var heart2 =$"../Tilemap/StuffOnTop/heart2"
@onready var heart3 =$"../Tilemap/StuffOnTop/heart3"
@onready var heart4 =$"../Tilemap/StuffOnTop/heart4"
@onready var heart5 =$"../Tilemap/StuffOnTop/heart5"

@export var cant_shoot = false
@export var can_attack = false
@export var coliding = false
@export var current_heart = 1
@export var waiting_for_hit = false
@export var max_offset: float = 20.0

func _ready() -> void:
	anim.play("idle")
	timer.wait_time = 1

func _process(delta: float) -> void:
	if player.global_position.x > global_position.x:
		anim.flip_h = false
	else:
		anim.flip_h = true
	take_damage()

func die():
	cant_shoot = true
	anims.play("die1")
	main.woosh.stop()
	player.fin()

func increase_speed():
	timer.wait_time = timer.wait_time - 0.15
	max_offset = max_offset + 20

func attack():
	if cant_shoot == false:
		main.fire_woosh()
		var ball = load("res://projectile.tscn").instantiate()
		ball.position = position
		main.add_child(ball)

func _on_timer_timeout() -> void:
	if can_attack == true:
		attack()


func _on_colision_body_entered(body: Node2D) -> void:
	if body == player:
		coliding = true


func _on_colision_body_exited(body: Node2D) -> void:
	if body == player:
		coliding = false


func take_damage():
	if coliding == true:
		if player.is_attacking == true:
			player.hit_sfx()
			if waiting_for_hit == false:
				spawn_heart()
				waiting_for_hit = true

func spawn_heart():
	if current_heart == 1:
		heart1.show()
		heart1.on = true
		heart1.animp.play("pop")
	elif current_heart == 2:
		heart2.show()
		heart2.on = true
		heart2.animp.play("pop")
	elif current_heart == 3:
		heart3.show()
		heart3.on = true
		heart3.animp.play("pop")
	elif current_heart == 4:
		heart4.show()
		heart4.on = true
		heart4.animp.play("pop")
	elif current_heart == 5:
		heart5.show()
		heart5.on = true
		heart5.animp.play("pop")
	current_heart = current_heart + 1
