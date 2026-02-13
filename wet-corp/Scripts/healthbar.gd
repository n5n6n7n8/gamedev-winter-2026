extends ProgressBar

@export var playeractions: Playeractions
@export var my_node : Node

func _ready():
	if playeractions == null:
		print("HealthBar: Playeractions not assigned!")
		return

	playeractions.health_changed.connect(update_bar)
	update_bar()


func update_bar():
	value = float(playeractions.health) / playeractions.max_health * 100.0
