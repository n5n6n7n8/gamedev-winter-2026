extends Area2D

var fishInRadius = false
@export var isRhythm = false

#var cash = get_node("/root/MainScene/MainHud/RichTextLabel")
var currentMoney = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if(!isRhythm):
		position = get_global_mouse_position()
	if(Input.is_action_just_pressed("Shoot")):
		if(has_overlapping_areas()):
			print("shot")
			for fish in get_overlapping_areas():
				fish.get_parent().free()
	return


#func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("collided")
	#fishInRadius = true
	#pass # Replace with function body.
#
#
#func _on_area_2d_area_exited(area: Area2D) -> void:
	#fishInRadius = false
	#pass # Replace with function body.
