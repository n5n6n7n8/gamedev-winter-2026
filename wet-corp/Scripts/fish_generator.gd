extends Node2D

var rng = RandomNumberGenerator.new()
@onready var regfish = preload("res://prefabs/regfishpath.tscn")
@onready var afish = preload("res://prefabs/armorpath.tscn")
@onready var pfish = preload("res://prefabs/pufffishpath.tscn")
@onready var kfish = preload("res://prefabs/kisspath.tscn")

@export var isRhythm = false

enum FishT {
	SALMON,
	ARMOR,
	KISS,
	PREGNANT,
	PUFFER
}
#wave 1: 15 ammo for 12 fish
var typeArr = [FishT.SALMON, FishT.SALMON, FishT.SALMON, FishT.PUFFER, FishT.SALMON, FishT.ARMOR, FishT.KISS, FishT.SALMON, FishT.SALMON, FishT.PUFFER, FishT.PUFFER, FishT.SALMON]
var timeArr = [1.0, 1.0, 1.0, 0.1, 1.5, 2.0, 1.0, 0.2, 1.0, 0.4, 1.0, 1.0]
var index = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = 3.0
	$Timer.start()


func _on_timer_timeout() -> void:
	if(index == 12):
		return
	match typeArr[index]:
		FishT.SALMON:
			var fishIns = regfish.instantiate()
			var toScale = rng.randf_range(1.3, 1.6)
			fishIns.get_node("PathFollow2D/Fish").scale = Vector2(toScale,toScale)
			fishIns.get_node("PathFollow2D").speed = toScale - 1.0
			add_child(fishIns)
		FishT.PUFFER:
			var pIns = pfish.instantiate()
			add_child(pIns)
		FishT.ARMOR:
			var aIns = afish.instantiate()
			add_child(aIns)
		FishT.KISS:
			var kIns = kfish.instantiate()
			add_child(kIns)
		_:
			print("Fish_generator.gd: ENUM DID NOT MATCH")
			
	$Timer.wait_time = timeArr[index]
	index += 1
	#
	##spawn fish
	#var fishIns = regfish.instantiate()
	#
	#var toScale = rng.randf_range(1.3, 1.6)
	#fishIns.get_node("PathFollow2D/Fish").scale = Vector2(toScale,toScale)
	#fishIns.get_node("PathFollow2D").speed = toScale - 1.0
	#add_child(fishIns)
#
	## reset timer to time in between 1-3 sec
	#$Timer.wait_time = rng.randf_range(1.0, 5.0)
	#$Timer2.wait_time = rng.randf_range(2.0, 6.0)
	#$Timer3.wait_time = rng.randf_range(1.0, 2.0)
	#$Timer4.wait_time = rng.randf_range(1.0, 2.0)
	#$Timer.start()
	#$Timer2.start()
	#$Timer3.start()
	#$Timer4.start()
#
#
#
#func _on_timer_2_timeout() -> void:
	#var pIns = pfish.instantiate()
	#print("puff spawn")
	#add_child(pIns)
	#$Timer2.wait_time = rng.randf_range(2.0, 6.0)
	#$Timer2.start()
#
#
#func _on_timer_3_timeout() -> void:
	#print("armor spawn")
	#var aIns = afish.instantiate()
	#add_child(aIns)
	#$Timer3.wait_time = rng.randf_range(1.0, 2.0)
	#$Timer3.start()
#
#
#func _on_timer_4_timeout() -> void:
	#print("kiss spwan")
	#var kIns = kfish.instantiate()
	#add_child(kIns)
	#$Timer4.wait_time = rng.randf_range(1.0, 2.0)
	#$Timer4.start()
