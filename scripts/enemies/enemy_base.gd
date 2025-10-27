extends npc

class_name enemy

@onready var label = $Label
@onready var sprite: Sprite2D = $Sprite2D
@onready var texture: AnimatedSprite2D = $AnimatedSprite2D

@export var touching_player = false
@export var cooldown = false

func _ready() -> void:
	super._ready()
	label.hide()
	

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if velocity.x > 0:
		texture.flip_h = true
	elif velocity.x < 0:
		texture.flip_h = false
	if health <= 0:
		queue_free()
	check_attack()

func _on_detection_radius_body_entered(body: Node2D) -> void:
	super._on_detection_radius_body_entered(body)
	if body == player:
		is_hostile = true

func _on_detection_radius_body_exited(body: Node2D) -> void:
	super._on_detection_radius_body_exited(body)
	if body == player:
		is_hostile = false


func _on_damage_radius_body_entered(body: Node2D) -> void:
	if body == player:
		player.hit_sfx()
		body.change_health(-10)
		


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body == player:
		touching_player = true

func check_attack():
	if player.is_attacking == true:
		if touching_player == true:
			if cooldown == false:
				cooldown = true
				player.hit_sfx()
				health = health - 5
				label.text = "HP: " + str(health)
				label.show()
				speed = 0
				await get_tree().create_timer(0.5).timeout
				label.hide()
				speed = 100
				cooldown = false

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body == player:
		touching_player = false
