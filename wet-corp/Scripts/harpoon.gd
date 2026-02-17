extends Sprite2D

var move_scale:float  = 0.25

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#get mouse pos
	var mouse_pos = get_global_mouse_position()
	self.position = mouse_pos * move_scale
	pass
