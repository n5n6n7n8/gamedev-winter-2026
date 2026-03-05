extends Area2D
class_name PlayerActions

signal health_changed  # signal for HealthBar

# Health variables
var health := 100
var max_health := 100

#Ammo variables n stuff
const maxBulletCount = 20
var bulletCount = maxBulletCount

# Optional gameplay variables
@onready var HarpoonFire = $HarpoonFire
@onready var FishDeath = $FishDeath
@onready var ArmorDeath = $ArmorDeath
@onready var KissyDeath = $KissyDeath
@onready var PufferDeath = $PufferDeath
@onready var ReloadSound = $ReloadSound
var currentMoney := 0

@onready var ammotext = $"../UI/MainHud/CanvasLayer/LABEL_ammo"
@onready var ammoWarning = $"../UI/MainHud/CanvasLayer/AmmoLabel"
func _ready() -> void:
	_set_ammo_text()

# Take damage function
func take_damage(amount):
	health -= amount
	health = clamp(health, 0, max_health)
	health_changed.emit()  # notify HealthBar

	if health <= 0:
		print("GAME OVER")

 #Called when player dies (there's already a game over function in game_info)
#func game_over():
	#
	#get_tree().reload_current_scene()

# Example shooting/movement logic
func _process(_delta):
	position = get_global_mouse_position()

func _input(e:InputEvent) -> void:
	if e.is_action_pressed("Shoot") && bulletCount > 0:
		bulletCount -= 1
		if(bulletCount == 0):
			ammoWarning.show_text("Press R to Reload")
		_set_ammo_text()
		HarpoonFire.play()
		if has_overlapping_areas():
			trigger_explosion(get_global_mouse_position())
			
			for f in get_overlapping_areas():
				var fi = f.get_parent()
				var fish = f.get_parent().get_parent()
				
				fi.take_damage()
				if(fi.should_die()):
					
					if fish.is_in_group("red_snapper"): # on red snapper shot
						_add_fish_to_gameinfo("red_snapper")
						FishDeath.play()
					elif fish.is_in_group("armored_fish"):  # on armored shot
						_add_fish_to_gameinfo("armored_fish")
						ArmorDeath.play()
					elif fish.is_in_group("pufferfish"):  # on puffer shot
						_add_fish_to_gameinfo("pufferfish")
						get_node("../FishGenerator/PufferSpawn").stop()
						PufferDeath.play()
					elif fish.is_in_group("kissy_fish"):  # on kissy shot
						GameInfo.heal(15)
						_add_fish_to_gameinfo("kissy_fish")
						KissyDeath.play()
					else:
						print("error finding fish!!!")
						return
					fish.queue_free()
		else: #If the harpoon doesn't shoot anything, minus 5 dollars for equipment misuse
			GameInfo.add_cash("loss")
	elif e.is_action_pressed("Reload"):
		bulletCount = 20
		_set_ammo_text()
		print("Reloaded!")
		ReloadSound.play()
	#if Input.is_action_just_pressed("Shoot"): # spacebar
		#trigger_explosion(global_position)
	#if e is InputEventKey:
			#trigger_explosion(get_global_mouse_position()) # spawns at mouse cursor
			

 #Optional testing: press space to take damage
	#if e.is_action_pressed("ui_accept"):  # usually Space
		#take_damage(10)

func _set_ammo_text() -> void:
	ammotext.text = "Ammo: " + str(bulletCount) + " / " + str(maxBulletCount)

func _add_fish_to_gameinfo(s:String) -> void:
	GameInfo.add_fish_ct(s)
	GameInfo.add_cash(s)
	#print("added ", s, " to fish collection")
@onready var explosion: CPUParticles2D = $"../Explosion"
func trigger_explosion(pos: Vector2):
	explosion.global_position = pos
	explosion.restart()

#func _on_body_entered(body):
		#get_parent().trigger_explosion(global_position)
		#queue_free()
