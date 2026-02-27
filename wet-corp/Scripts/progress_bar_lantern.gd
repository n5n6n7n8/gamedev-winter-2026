extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.max_value = GameInfo.timer.wait_time
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.value = GameInfo.timer.get_time_left()
