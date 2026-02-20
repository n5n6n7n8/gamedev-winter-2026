extends PathFollow2D

@export var speed : float = 0.1
@export var speed_curve : Curve
var tspeed = speed
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	tspeed = speed * speed_curve.sample(progress_ratio)
	progress_ratio += delta * tspeed
	
