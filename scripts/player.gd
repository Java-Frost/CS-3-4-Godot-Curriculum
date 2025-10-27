extends CharacterBody2D
class_name Player

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label = $Label
@onready var label2 = $Label2
@onready var label3 = $Label3
@onready var inv = $"../UI/Inventory"
@onready var health_label = $"../UI/Inventory/health"
@onready var coins_label = $"../UI/Inventory/coins"
@onready var main = $".."
@onready var hit = false
@onready var slime = $"../slime"
@onready var key = $"../Area2D"
@onready var coin = $"../Tilemap/StuffOnTop/Coin"
@onready var potion = $"../Tilemap/StuffOnTop/HealthPotion"
@onready var cbox = $"../Tilemap/StuffOnTop/Collision box"
@onready var health_bar = $"../UI/Boss_Health"
@onready var door2 = $"../Tilemap/StuffOnTop/Door2"
@onready var music_player = $"../AudioStreamPlayer2D"
@onready var particle = $GPUParticles2D
@onready var particle2 = $GPUParticles2D2


@export var checkpoint = false
@export var is_attacking: bool = true
@export var can_view_inventory = true
@export var move_speed: float = 200.0
@export var maxHealth : int = 50
@export var health : int = maxHealth
@export var coins : int = 0
@export var inventory : Array[String] = []
@export var can_attack = false
@export var viewing_inv = true
@export var current_slot = -1
@export var is_breaking = false
@export var can_dash = true



var facing: Vector2 = Vector2.ZERO


func _ready():
	particle.emitting = false
	particle2.emitting = false
	position = SpawnPoint.spawn
	if SpawnPoint.spawn != Vector2(0,0):
		slime.queue_free()
		key.queue_free()
		potion.queue_free()
		coin.queue_free()
		health_bar.show()
		music_player.play()
		coins = SpawnPoint.coins
	#get_tree().change_scene_to_file("res://inventory.tscn")
	label.hide()
	label2.hide()
	label3.hide()
	label2.text = "Inventory"
	# TODO: Add detailed character info display (Lesson 1)

func _physics_process(delta):
	label.text = "HP: " + str(health)
	label3.text = "Coins: " + str(coins)
	health_label.text = "HP: " + str(health)
	coins_label.text = "Coins: " + str(coins)
	view_inventory()
	view_coins()
	view_health()
	handle_movement()
	dash()

func handle_movement():
	# Get input direction from arrow keys
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	if !is_attacking:
		handle_sprite(direction)
	attack(direction)

	
	# Normalize diagonal movement to prevent speed boost
	if direction.length() > 0:
		direction = direction.normalized()
		
	var speed = move_speed
	# Apply movement using Godot's built-in physics
	if is_attacking == true:
		speed = 0
		
	velocity = direction * speed
	move_and_slide()

# BAD QUICK CODE MAYBE CHANGE
func handle_sprite(direction: Vector2) -> void:
	var prefix: String = "walk"
	if direction == Vector2.ZERO:
		prefix = "idle"
	else:
		facing = direction
	if facing.y > 0:
		animated_sprite.play(prefix + "_forward")
	elif facing.y < 0:
		animated_sprite.play(prefix + "_backward")
	elif facing.x < 0:
		animated_sprite.play(prefix + "_side")
		animated_sprite.flip_h = true
	elif facing.x > 0:
		animated_sprite.play(prefix + "_side")
		animated_sprite.flip_h = false

func collect_pickup(_type : String, _amount : int):
	if _type == "coin":
		coins += _amount
		label.hide()
		label2.hide()
		label3.show()
		await get_tree().create_timer(0.5).timeout
		label3.hide()
	elif _type == "health_potion":
		change_health(_amount)
	elif _type == "chest":
		coins += _amount
		label.hide()
		label2.hide()
		label3.show()
		await get_tree().create_timer(0.5).timeout
		label3.hide()
		

# TODO: Add character methods here (Lesson 2)

# - level_up()
# - attack()

func change_health(_amount): 
	health += _amount
	if health > maxHealth:
		health = maxHealth
	if health < 1:
		is_attacking = true
		health = 0
		
	label2.hide()
	label3.hide()
	label.show()
	await get_tree().create_timer(0.5).timeout
	label.hide()
		
	if health < 1:
		die()
		pass
	
func die():
	if checkpoint == false:
		print("You died!")
		get_tree().reload_current_scene()
		is_attacking = false
	else:
		SpawnPoint.spawn = Vector2(-462.0, -544.3321)
		SpawnPoint.coins = coins
		is_attacking = false
		get_tree().reload_current_scene()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit(0)


func get_item(item : String):
	inventory.append(item)
	var next_slot = -1
	for thing in inventory:
		next_slot = next_slot + 1
	current_slot = next_slot
	inv.add_item_to_slot(next_slot, item)


func remove_item(item: String):
	inventory.erase(item)
	inv.remove_item_from_slot(item)


func remove_item_silent(item: String):
	inventory.erase(item)

func view_inventory():
	if Input.is_action_just_pressed("Inventory"):
		if can_view_inventory == true:
			if viewing_inv == false:
				animated_sprite.play("idle_forward")
				#get_tree().paused = true
				inv.show()
				is_attacking = true
				can_attack = false
				viewing_inv = true
			elif viewing_inv == true:
				inv.hide()
				#get_tree().paused = false
				is_attacking = false
				can_attack = true
				viewing_inv = false

func view_health():
	if Input.is_action_just_pressed("Health"):
		label.show()
		label2.hide()
		label3.hide()
	if Input.is_action_just_released("Health"):
		label.hide()


func view_coins():
	if Input.is_action_just_pressed("Coins"):
		label3.show()
		label.hide()
		label2.hide()
	if Input.is_action_just_released("Coins"):
		label3.hide()


func attack(direction: Vector2):
	if direction != Vector2.ZERO:
		facing = direction
	if Input.is_action_just_pressed("attack"):
		if can_attack == true:
			is_attacking = true
			is_breaking = true
			if facing.y > 0:
				animated_sprite.play("slash_down")
			elif facing.y < 0:
				animated_sprite.play("slash_up")
			elif facing.x < 0:
				animated_sprite.play("slash_left")
				animated_sprite.flip_h = false
			elif facing.x > 0:
				animated_sprite.play("slash_right")
				animated_sprite.flip_h = false
			if hit == false:
				main.woosh_sound()
		await animated_sprite.animation_finished
		is_attacking = false
		is_breaking = false


func hit_sfx():
	main.punch_sound()


func set_spawn():
	checkpoint = true


func dash():
	if Input.is_action_just_pressed("dodge"):
		if can_dash == true:
			if $"../UI/dash indicator".dashes_left > 0:
				$"../UI/dash indicator".dash()
				main.woosh_sound()
				move_speed = 600
				particle.emitting = true
				particle2.emitting = true
				can_dash = false
				await get_tree().create_timer(0.3).timeout
				move_speed = 200
				await get_tree().create_timer(0.2).timeout
				particle.emitting = false
				particle2.emitting = false
				can_dash = true
		
