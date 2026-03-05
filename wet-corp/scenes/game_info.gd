extends Node

signal cargo_health_changed
signal gain_cash
var max_cargo_health : int = 100;
var cargo_health : int = 100 :
	set(value):
		cargo_health = value
		cargo_health_changed.emit()
var cash : int = 25 ;
@onready var timer: Timer = $"Game Timer"
var fish_ct : Dictionary = {
	"red_snapper" : 0,
	"pufferfish" : 0,
	"kissy_fish" : 0,
	"armored_fish" : 0,
	"pregnant_fish" : 0,
	"baby_fish" : 0
}

var fish_price : Dictionary = {
	"red_snapper" : 45,
	"pufferfish" : 75,
	"kissy_fish" : 0,
	"armored_fish" : 100,
	"pregnant_fish" : 1_000,
	"baby_fish" : 15
}

var fish_dmg : Dictionary = {
	"red_snapper" : 10,
	"pufferfish" : 15,
	"kissy_fish" : 1,
	"armored_fish" : 25,
	"pregnant_fish" : 40,
	"baby_fish" : 5
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
	if(fish == "loss"):
		cash -= 5
	else: 
		cash += fish_price[fish]
	gain_cash.emit()


func take_dmg(val:int) -> void:
	self.cargo_health -= val
	print("Cargo health: ", self.cargo_health)
	if cargo_health <= 0:
		print("Game Over")
		SceneTransition.change_scene_to_file("res://scenes/end_scene_fail.tscn")
	return
	
func take_dmg_by_fish(fishname: String) -> void:
	take_dmg(fish_dmg[fishname])
	
	
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
	print("timer stopped")
	timer.stop()
	SceneTransition.change_scene_to_file("res://scenes/end_scene_win.tscn")
	
func end_game_lose() -> void:
	print("timer stopped")
	timer.stop()
	SceneTransition.change_scene_to_file("res://scenes/end_scene_fail.tscn")
	
func start_game() -> void:
	self.reset()
	SceneTransition.change_scene_to_file("res://scenes/main_scene.tscn")
	print("timer started")
	self.timer.start()
	

	
