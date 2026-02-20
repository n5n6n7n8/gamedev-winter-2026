extends Node

signal cargo_health_changed
var max_cargo_heatlh : int = 100;
var cargo_health : int = 100 :
	set(value):
		cargo_health_changed.emit()
		cargo_health = value
var cash : int = 0;
var fish_ct : Dictionary = {
	"red_snapper" : 0,
	"pufferfish" : 0,
	"kissy_fish" : 0,
	"armored_fish" : 0,
	"pregnant_fish" : 0,
	"baby_fish" : 0
}

var fish_price : Dictionary = {
	"red_snapper" : 10_000,
	"pufferfish" : 50_000,
	"kissy_fish" : 0,
	"armored_fish" : 100_000,
	"pregnant_fish" : 80_000,
	"babyfish" : 5_000
}

var fish_dmg : Dictionary = {
	"red_snapper" : 1,
	"pufferfish" : 5,
	"kissy_fish" : 0,
	"armored_fish" : 10,
	"pregnant_fish" : 8,
	"babyfish" : 0.5
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_fish_ct(fish:String):
	if fish_ct.find_key(fish):
		fish_ct[fish] += 1;
	else:
		push_error("key %s is not found in fish_ct" % fish)

func take_dmg(val:int) -> void:
	self.cargo_health -= val
	print(self.cargo_health)
	if cargo_health <= 0:
		print("Game Over")
		get_tree().change_scene_to_file("res://scenes/end_scene_fail.tscn")
	return
	
func reset() -> void:
	fish_ct = {
		"red_snapper" : 0,
		"pufferfish" : 0,
		"kiss_fish" : 0,
		"armored_fish" : 0,
		};
	cash = 0;
	cargo_health = 100;
	return
