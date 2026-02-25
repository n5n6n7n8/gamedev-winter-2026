extends ProgressBar



func _ready():
	self.max_value = GameInfo.max_cargo_health
	GameInfo	.cargo_health_changed.connect(_on_cargo_health_changed)
	
func _on_cargo_health_changed():
	print("cargo health changed")
	self.value = GameInfo.cargo_health

#temp for debug stuff
func _input(e):
	if e is InputEventKey and e.pressed:
		if (e.keycode == KEY_SPACE):
			GameInfo.take_dmg(10)
