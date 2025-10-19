@tool

extends pickup
class_name HealthPotion
@onready var player = %Player

func use_potion(player: Player):
	"""Alternative method for manual potion use"""
	if player.has_method("change_health"):
		player.change_health(amount)
		$AnimationPlayer.play("disappear")
		return true
	return false

func _on_body_entered(body):
	if body == player:
		$AnimationPlayer.play("disappear")
		player.get_item("red_flask")
