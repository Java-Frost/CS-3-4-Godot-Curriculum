extends npc

class_name enemy

@onready var sprite: Sprite2D = $Sprite2D




func _ready() -> void:
	super._ready()
	pass
	

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	pass


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
		body.change_health(-1)
