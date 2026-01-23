extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Shoot")):
		print(has_overlapping_areas())
		print("shot")
		for fish in get_overlapping_areas():
			fish.free()
