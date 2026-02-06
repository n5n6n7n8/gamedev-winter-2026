extends Node2D

var rng = RandomNumberGenerator.new()
@onready var regfish = preload("res://prefabs/regfishpath.tscn")
@onready var afish = preload("res://prefabs/armorpath.tscn")
@onready var pfish = preload("res://prefabs/pufffishpath.tscn")
@onready var kfish = preload("res://prefabs/kisspath.tscn")

@export var isRhythm = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()





func _on_timer_timeout() -> void:
	
	#spawn fish
	var fishIns = regfish.instantiate()
	
	if(!isRhythm):
		var toScale = rng.randf_range(0.65, 1.0)
		fishIns.get_node("PathFollow2D/Fish").scale = Vector2(toScale,toScale)
		fishIns.get_node("PathFollow2D").speed = toScale - 0.4
	add_child(fishIns)

	# reset timer to time in between 1-3 sec
	$Timer.wait_time = rng.randf_range(1.0, 5.0)
	$Timer.start()
	$Timer2.start()
	$Timer4.start()



func _on_timer_2_timeout() -> void:
	var pIns = pfish.instantiate()
	add_child(pIns)
	$Timer2.wait_time = rng.randf_range(2.0, 6.0)
	$Timer2.start()
	$Timer3.start()


func _on_timer_3_timeout() -> void:
	var aIns = afish.instantiate()
	add_child(aIns)
	$Timer3.wait_time = rng.randf_range(5.0, 10.0)
	$Timer3.start()


func _on_timer_4_timeout() -> void:
	var kIns = kfish.instantiate()
	add_child(kIns)
	$Timer4.wait_time = rng.randf_range(5.0, 10.0)
	$Timer4.start()
