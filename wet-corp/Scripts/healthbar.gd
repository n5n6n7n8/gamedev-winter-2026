extends ProgressBar

@export var playeractions: Node = null  # broad type + initialized

func _ready():
	if playeractions == null:
		print("PlayerActions node not assigned!")
		return

	playeractions.health_changed.connect(update_bar)
	update_bar()  # initial update

func update_bar():
	value = float(playeractions.health) / playeractions.max_health * 100.0
