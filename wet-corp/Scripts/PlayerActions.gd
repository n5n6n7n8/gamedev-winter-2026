extends Area2D
class_name Playeractions

signal health_changed

var health := 100
var max_health := 100

@export var isRhythm := false
@onready var HarpoonFire = $HarpoonFire
@onready var FishDeath = $FishDeath

var currentMoney = 0


func take_damage(amount):
	health -= amount
	health = clamp(health, 0, max_health)
	health_changed.emit()

	if health <= 0:
		game_over()


func game_over():
	print("GAME OVER")
	get_tree().reload_current_scene()


func _process(delta):
	if !isRhythm:
		position = get_global_mouse_position()

	if Input.is_action_just_pressed("Shoot"):
		HarpoonFire.play()

		if has_overlapping_areas():
			FishDeath.play()

			for fish in get_overlapping_areas():
				fish.get_parent().queue_free()


	if health <= 0:
		game_over()


#func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("collided")
	#fishInRadius = true
	#pass # Replace with function body.
#
#
#func _on_area_2d_area_exited(area: Area2D) -> void:
	#fishInRadius = false
	#pass # Replace with function body.
