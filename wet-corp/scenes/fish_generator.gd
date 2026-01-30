extends Node2D

var rng = RandomNumberGenerator.new()
@onready var fish = preload("res://prefabs/fish.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()




func _on_timer_timeout() -> void:
	
	#spawn fish
	var fishIns = fish.instantiate()
	add_child(fishIns)
	# reset timer to time in between 1-3 sec
	$Timer.wait_time = rng.randf_range(1.0, 5.0)
	$Timer.start()
