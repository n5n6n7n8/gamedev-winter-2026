extends Node2D

var rng = RandomNumberGenerator.new()
@onready var regfish = preload("res://prefabs/regfishpath.tscn")
@onready var afish = preload("res://prefabs/armorpath.tscn")
@onready var pfish = preload("res://prefabs/pufffishpath.tscn")
@onready var kfish = preload("res://prefabs/kisspath.tscn")
@onready var prfish = preload("res://prefabs/pregpath.tscn")
@onready var bfish = preload("res://prefabs/babypath.tscn")
@onready var flashText = $"../UI/MainHud/CanvasLayer/TuturialLabel"
@export var timeSpeedup = 1.0
@onready var PufferSpawn = $PufferSpawn

enum FishT {
	RED,
	ARMOR,
	KISS,
	PREGNANT,
	PUFFER,
	BABY
}
#wave 1: 18 ammo for 16 fish
#wave 2: 20 ammo for 15 fish
#wave 3: 20 ammo for 18 fish
var typeArr = [FishT.RED, FishT.RED, FishT.RED, FishT.RED, FishT.RED, FishT.PUFFER, FishT.RED, FishT.RED, FishT.RED, FishT.ARMOR, FishT.RED, FishT.PUFFER, FishT.RED, FishT.ARMOR, FishT.PUFFER, FishT.RED, FishT.RED]
var typeArr2 = [FishT.KISS, FishT.RED, FishT.PUFFER, FishT.RED, FishT.ARMOR, FishT.RED, FishT.ARMOR, FishT.PUFFER, FishT.RED, FishT.PUFFER, FishT.PUFFER, FishT.RED, FishT.RED, FishT.ARMOR, FishT.PUFFER, FishT.RED, FishT.RED, FishT.PUFFER, FishT.KISS, FishT.PUFFER, FishT.ARMOR, FishT.RED, FishT.PUFFER, FishT.RED, FishT.RED, FishT.RED]
var typeArr3 = [FishT.PREGNANT, FishT.BABY, FishT.BABY, FishT.BABY, FishT.BABY, FishT.BABY, FishT.BABY, FishT.BABY, FishT.RED, FishT.RED, FishT.RED, FishT.RED, FishT.RED, FishT.PUFFER, FishT.RED, FishT.PUFFER, FishT.PUFFER, FishT.ARMOR, FishT.KISS, FishT.RED, FishT.RED, FishT.ARMOR, FishT.PUFFER, FishT.RED, FishT.PUFFER, FishT.RED, FishT.RED, FishT.RED, FishT.RED]
#first line: 16
# --------RED--RED -RED -RED  RED -PUF -RED - RED -RED ARM -RED - PUF -RED -ARM- PUF- RED
var timeArr = [4.0, 3.0, 0.4, 4.0, 5.0, 0.9, 2.0, 5.0, 3.0, 1.0, 1.0, 4.0, 0.5, 3.0, 3.0, 2.0, 1.0]
#second line: 22 (38)
#  -------------KIS -RED -PUF -RED -ARM -RED -ARM -PUF -PUF -RED -ARM -RED -PUF -RED -RED -RED -PUF -PUF -KIS -PUF -ARM -RED -PUF -RED -RED -RED
var timeArr2 = [2.0, 1.0, 0.5, 1.0, 0.6, 1.3, 1.5, 0.5, 0.1, 1.0, 1.0, 0.5, 2.0, 1.0, 4.0, 0.5, 1.0, 1.0, 0.3, 0.6, 2.0, 3.0, 0.5, 5.0, 3.0, 5.0]
#third line:  19 (57)
#-=-------------PRE -BAB -BAB -BAB -BAB -BAB -BAB -BAB -RED -RED -RED -RED -PUF -RED -PUF -PUF -ARM  -KIS -RED -RED -ARM -PUF -RED -PUF -ARM -RED -RED -RED
var timeArr3 = [2.0, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 1.2, 3.0, 1.5, 2.0, 2.0, 0.7, 1.0, 0.9, 2.1, 2.0, 1.5, 2.0, 1.0, 2.2, 2.0, 3.0, 1.0, 1.3, 4.0, 2.0, 2.5, 1.3]
var index = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = 5.0 #INITIAL TIME
	$Timer.start()


func _on_timer_timeout() -> void:
	var typeToUse
	var timeToUse
	var toScale = randf_range(-0.1,0.35)
	if(index == 71):
		$Timer.stop()
		return
	elif(index >= 42):
		typeToUse = typeArr3[index-42]
		timeToUse = timeArr3[index-42]
	elif(index >= 16):
		typeToUse = typeArr2[index-16]
		timeToUse = timeArr2[index-16]
	else:
		typeToUse = typeArr[index]
		timeToUse = timeArr[index]
	if(index==1):
		flashText.show_text("Wave 1")
	if(index==16):
		flashText.show_text("Wave 2")
	if(index==42):
		flashText.show_text("Wave 3")
	match typeToUse:
		FishT.RED:  #ON RED SNAPPER SPAWN
			var fishIns = regfish.instantiate()
			#var toScale = rng.randf_range(1.3, 1.6)
			#fishIns.get_node("PathFollow2D/Fish").scale = Vector2(toScale,toScale)
			if(index>=39):
				fishIns.get_node("PathFollow2D").speed = 0.75
			else:
				fishIns.get_node("PathFollow2D").speed += randf_range(-0.05,0.20)
			fishIns.add_to_group("red_snapper")

			fishIns.get_node("PathFollow2D").scale += Vector2(toScale,toScale)
			fishIns.get_node("PathFollow2D").fish_name = "red_snapper"
			fishIns.get_node("PathFollow2D").update_after_instantiation()
			fishIns.position += Vector2(randi_range(-150, 150), randi_range(-100, 200))
			add_child(fishIns)
			
		FishT.PUFFER:#ON PUFFER SPAWN
			var pIns = pfish.instantiate()
			if(index>=39):
				pIns.get_node("PathFollow2D").speed = 0.8
			pIns.add_to_group("pufferfish")
			pIns.get_node("PathFollow2D").scale += Vector2(toScale,toScale)
			pIns.get_node("PathFollow2D").fish_name = "pufferfish"
			pIns.get_node("PathFollow2D").update_after_instantiation()
			pIns.position += Vector2(randi_range(-250, 250), randi_range(-20, 20))
			add_child(pIns)
			PufferSpawn.play()
		FishT.ARMOR:#ON ARMOR SPAWN
			var aIns = afish.instantiate()
			if(index>=39):
				aIns.get_node("PathFollow2D").speed = 0.5
			aIns.add_to_group("armored_fish")
			aIns.get_node("PathFollow2D").scale += Vector2(toScale,toScale)
			aIns.get_node("PathFollow2D").fish_name = "armored_fish"
			aIns.get_node("PathFollow2D").update_after_instantiation()
			aIns.position += Vector2(randi_range(-155, 155), randi_range(-100, 100))
			add_child(aIns)
		FishT.KISS: #ON KISSY SPAWN
			var kIns = kfish.instantiate()
			if(index>=39):
				kIns.get_node("PathFollow2D").speed = 0.9
			kIns.add_to_group("kissy_fish")
			kIns.get_node("PathFollow2D").fish_name = "kissy_fish"
			kIns.get_node("PathFollow2D").update_after_instantiation()
			add_child(kIns)
		FishT.PREGNANT:
			var prIns = prfish.instantiate()
			prIns.add_to_group("pregnant_fish")
			prIns.get_node("PathFollow2D").fish_name = "pregnant_fish"
			prIns.get_node("PathFollow2D").update_after_instantiation()
			add_child(prIns)
		FishT.BABY:
			var bIns = bfish.instantiate()
			bIns.add_to_group("baby_fish")
			bIns.get_node("PathFollow2D").fish_name = "baby_fish"
			bIns.get_node("PathFollow2D").update_after_instantiation()
			bIns.position += Vector2(randi_range(-250, 250), 0)
			add_child(bIns)
		_:
			print("Fish_generator.gd: ENUM DID NOT MATCH")
			
	$Timer.wait_time = timeToUse * timeSpeedup
	index += 1
