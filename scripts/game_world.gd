extends Node2D
class_name GameWorld

# Player reference - our main character
@onready var player = $Player
@onready var music_player = $AudioStreamPlayer2D
@onready var shatter = $shatter
@onready var punch = $punch
@onready var woosh = $woosh
@onready var ding = $ding
@onready var chest = $chest
@onready var door = $door
@onready var warp = $warp
@onready var pot = $potion
@onready var fire = $fire
@onready var music = $"backround music"
@onready var torch = $torch
# Test objects for character methods
@onready var spike = $Spike
@onready var health_potion = $HealthPotion

func _ready():
	music_play()

func start_boss_song():
	music_player.play()
	music.stop()

func shatter_sound():
	shatter.play()

func punch_sound():
	punch.play()

func woosh_sound():
	woosh.play()

func ding_sound():
	ding.play()

func chest_sound():
	chest.play()

func door_sound():
	door.play()

func warp_sound():
	warp.play()

func potion_sound():
	pot.play()

func fire_woosh():
	fire.play()

func music_play():
	music.play()

func torch_sound():
	torch.play()
# TODO: Add game management methods here (Future lessons)
# - spawn_enemy()
# - handle_combat()  
# - check_game_over()
