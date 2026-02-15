extends Control

var amplitude_x:int = 20
var amplitude_y:int = 20
var amplitude_rot: int = 1
var offset = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	offset += delta
	if offset >= 2*PI:
		offset = 0
	self.position.x = amplitude_x * sin(offset)
	self.position.y = amplitude_y * sin(offset + 0.2)
	self.rotation_degrees = amplitude_rot * cos(offset)
	
