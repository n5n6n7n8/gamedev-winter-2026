extends Node

signal cargo_health_changed
signal gain_cash
var max_cargo_health : int = 100;
var cargo_health : int = 100 :
	set(value):
		cargo_health = value
		cargo_health_changed.emit()

var cash : int = 0 ;
@onready var timer = $"Game Timer"
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
	"baby_fish" : 5_000
}

var fish_dmg : Dictionary = {
	"red_snapper" : 1,
	"pufferfish" : 5,
	"kissy_fish" : 0,
	"armored_fish" : 10,
	"pregnant_fish" : 8,
	"baby_fish" : 0.5
}

func _ready() -> void:
	self.timer.timeout.connect(end_game_win)
	pass


func add_fish_ct(fish:String):
	if fish_ct.has(fish):
		fish_ct[fish] += 1;
	else:
		push_error("key %s is not found in fish_ct" % fish)

func add_cash(fish:String):
	cash += fish_price[fish]
	gain_cash.emit()


func take_dmg(val:int) -> void:
	self.cargo_health -= val
	print("Cargo health: ", self.cargo_health)
	if cargo_health <= 0:
		print("Game Over")
		SceneTransition.change_scene_to_file("res://scenes/end_scene_fail.tscn")
	return

func take_dmg_by_fish(name: String) -> void:
	take_dmg(fish_dmg[name])
	return
	
func heal(val:int) -> void:
	if(self.cargo_health + val > max_cargo_health):
		self.cargo_health = max_cargo_health
	else:
		self.cargo_health += val
	print("Cargo health: ", self.cargo_health)
	
func reset() -> void:
	fish_ct = {
	"red_snapper" : 0,
	"pufferfish" : 0,
	"kissy_fish" : 0,
	"armored_fish" : 0,
	"pregnant_fish" : 0,
	"baby_fish" : 0
	}
	cash = 0;
	cargo_health = 100;
	return

func end_game_win() -> void:
	SceneTransition.change_scene_to_file("res://scenes/end_scene_win.tscn")
	
func end_game_lose() -> void:
	SceneTransition.change_scene_to_file("res://scenes/end_scene_fail.tscn")
	
func start_game() -> void:
	self.reset()
	SceneTransition.change_scene_to_file("res://scenes/main_scene.tscn")
	self.timer.start()
	
