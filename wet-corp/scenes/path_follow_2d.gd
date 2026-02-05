extends PathFollow2D

@export var speed : float = 0.1
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	progress_ratio += delta * speed
