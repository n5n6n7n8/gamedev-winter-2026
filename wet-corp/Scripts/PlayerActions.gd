extends Area2D
class_name PlayerActions

signal health_changed  # signal for HealthBar

# Health variables
var health := 100
var max_health := 100

# Optional gameplay variables
@onready var HarpoonFire = $HarpoonFire
@onready var FishDeath = $FishDeath
var currentMoney := 0

# Take damage function
func take_damage(amount):
	health -= amount
	health = clamp(health, 0, max_health)
	health_changed.emit()  # notify HealthBar

	if health <= 0:
		game_over()

# Called when player dies
func game_over():
	print("GAME OVER")
	get_tree().reload_current_scene()

# Example shooting/movement logic
func _process(delta):
	position = get_global_mouse_position()

	if Input.is_action_just_pressed("Shoot"):
		HarpoonFire.play()
		if has_overlapping_areas():
			FishDeath.play()
			for fish in get_overlapping_areas():
				fish.get_parent().queue_free()

# Optional testing: press space to take damage
func _input(event):
	if event.is_action_pressed("ui_accept"):  # usually Space
		take_damage(10)
