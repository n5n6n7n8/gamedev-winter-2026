extends Node2D

var rng = RandomNumberGenerator.new()
@onready var regfish = preload("res://prefabs/regfishpath.tscn")
@onready var afish = preload("res://prefabs/armorpath.tscn")
@onready var pfish = preload("res://prefabs/pufffishpath.tscn")
@onready var kfish = preload("res://prefabs/kisspath.tscn")
@export var timeSpeedup = 1.0

enum FishT {
	RED,
	ARMOR,
	KISS,
	PREGNANT,
	PUFFER
}
#wave 1: 18 ammo for 14 fish
#wave 2: 20 ammo for 15 fish
#wave 3: 20 ammo for 18 fish
var typeArr = [FishT.RED, FishT.RED, FishT.RED, FishT.RED, FishT.PUFFER, FishT.RED, FishT.RED, FishT.RED, FishT.RED, FishT.ARMOR, FishT.PUFFER, FishT.PUFFER, FishT.ARMOR, FishT.ARMOR, FishT.RED]
var typeArr2 = [FishT.KISS, FishT.RED, FishT.RED, FishT.RED, FishT.PUFFER, FishT.RED, FishT.RED, FishT.RED, FishT.RED, FishT.ARMOR, FishT.PUFFER, FishT.PUFFER, FishT.ARMOR, FishT.ARMOR, FishT.RED, FishT.PUFFER]
var typeArr3 = [FishT.RED, FishT.RED, FishT.RED, FishT.RED, FishT.PUFFER, FishT.RED, FishT.RED, FishT.RED, FishT.RED, FishT.ARMOR, FishT.PUFFER, FishT.PUFFER, FishT.ARMOR, FishT.ARMOR, FishT.RED, FishT.PUFFER, FishT.RED, FishT.ARMOR, FishT.ARMOR]
#first line: wave 1, second line: wave 2, etc
var timeArr = [2.0, 5.0, 0.5, 5.0, 0.1, 4.0, 0.5, 0.1, 4.0, 5.0, 4.0, 4.0, 1.0, 2.0, 8.0]
var timeArr2 = [2.0, 5.0, 0.5, 5.0, 0.1, 4.0, 0.5, 0.1, 4.0, 5.0, 4.0, 4.0, 1.0, 2.0, 8.0, 2.0]
var timeArr3 = [2.0, 5.0, 0.5, 5.0, 0.1, 4.0, 0.5, 0.1, 4.0, 5.0, 4.0, 4.0, 1.0, 2.0, 8.0, 2.0, 1.0, 1.0, 0.3]
var index = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = 3.0
	$Timer.start()


func _on_timer_timeout() -> void:
	var typeToUse
	var timeToUse
	if(index == 47):
		print("done!!")
		$Timer.stop()
		return
	elif(index >= 29):
		typeToUse = typeArr3[index-29]
		timeToUse = timeArr3[index-29]
		print("wave 3")
	elif(index >= 14):
		typeToUse = typeArr2[index-14]
		timeToUse = timeArr2[index-14]
		print("wave 2")
	else:
		typeToUse = typeArr[index]
		timeToUse = timeArr[index]
		print("wave 1")
	match typeToUse:
		FishT.RED:
			var fishIns = regfish.instantiate()
			#var toScale = rng.randf_range(1.3, 1.6)
			#fishIns.get_node("PathFollow2D/Fish").scale = Vector2(toScale,toScale)
			#fishIns.get_node("PathFollow2D").speed = toScale - 1.0
			fishIns.add_to_group("red_snapper")
			fishIns.get_node("PathFollow2D").fish_name = "red_snapper"
			fishIns.get_node("PathFollow2D").update_after_instantiation()
			add_child(fishIns)
			
		FishT.PUFFER:
			var pIns = pfish.instantiate()
			pIns.add_to_group("pufferfish")
			
			pIns.get_node("PathFollow2D").fish_name = "pufferfish"
			pIns.get_node("PathFollow2D").update_after_instantiation()
			add_child(pIns)
		FishT.ARMOR:
			var aIns = afish.instantiate()
			aIns.add_to_group("armored_fish")
			aIns.get_node("PathFollow2D").fish_name = "armored_fish"
			aIns.get_node("PathFollow2D").update_after_instantiation()
			add_child(aIns)
		FishT.KISS:
			var kIns = kfish.instantiate()
			kIns.add_to_group("kissy_fish")
			
			kIns.get_node("PathFollow2D").fish_name = "kissy_fish"
			kIns.get_node("PathFollow2D").update_after_instantiation()
			add_child(kIns)
		_:
			print("Fish_generator.gd: ENUM DID NOT MATCH")
			
	$Timer.wait_time = timeToUse * timeSpeedup
	index += 1
