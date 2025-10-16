extends CharacterBody2D
class_name Player


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label = $Label
@onready var label2 = $Label2
@onready var label3 = $Label3

@export var is_attacking: bool = false
@export var move_speed: float = 200.0
@export var maxHealth : int = 50
@export var health : int = maxHealth
@export var coins : int = 0
@export var inventory : Array[String] = []
@export var can_attack = true



var facing: Vector2 = Vector2.ZERO


func _ready():
	get_tree().change_scene_to_file("res://inventory.tscn")
	label.hide()
	label2.hide()
	label3.hide()
	label2.text = "Inventory"
	print("Player is ready!")
	# TODO: Add detailed character info display (Lesson 1)

func _physics_process(delta):
	label.text = "HP: " + str(health)
	label3.text = "Coins: " + str(coins)
	view_inventory()
	view_coins()
	view_health()
	handle_movement()

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
	print("You died!")
	get_tree().reload_current_scene()
	is_attacking = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit(0)



func get_item(item : String):
	inventory.append(item)
	var list = []
	for thing in inventory:
		list.append("-" + thing)
	label2.text = "Inventory\n" + "\n".join(list)
	label.hide()
	label3.hide()
	label2.show()
	await get_tree().create_timer(1).timeout
	label2.hide()


func remove_item(item: String):
	inventory.erase(item)
	var list = []
	for thing in inventory:
		list.append("-" + thing)
	label2.text = "Inventory\n" + "\n".join(list)

func view_inventory():
	if Input.is_action_just_pressed("Inventory"):
		label2.show()
		label.hide()
		label3.hide()
	if Input.is_action_just_released("Inventory"):
		label2.hide()

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
	
	
	if direction == Vector2.ZERO: 
		pass
	else:
		facing = direction
	
	if Input.is_action_just_pressed("attack"):  #remove the 1 to enable attacking animation
		if can_attack == true:
			is_attacking = true
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
		await animated_sprite.animation_finished
		is_attacking = false
