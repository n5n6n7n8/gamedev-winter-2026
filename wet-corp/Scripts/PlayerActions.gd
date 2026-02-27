extends Area2D
class_name PlayerActions

signal health_changed  # signal for HealthBar

# Health variables
var health := 100
var max_health := 100

#Ammo variables n stuff
const maxBulletCount = 15
var bulletCount = maxBulletCount
var ammoCount = 45

# Optional gameplay variables
@onready var HarpoonFire = $HarpoonFire
@onready var FishDeath = $FishDeath
var currentMoney := 0

@onready var ammotext = $"../UI/MainHud/CanvasLayer/LABEL_ammo"
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
func _process(delta):
	position = get_global_mouse_position()

	if Input.is_action_just_pressed("Shoot") && bulletCount > 0:
		bulletCount -= 1
		_set_ammo_text()
		HarpoonFire.play()
		if has_overlapping_areas():
			FishDeath.play()
			for f in get_overlapping_areas():
				var fish = f.get_parent().get_parent()
				if fish.is_in_group("red_snapper"):
					_add_fish_to_gameinfo("red_snapper")
				elif fish.is_in_group("armored_fish"):
					_add_fish_to_gameinfo("armored_fish")
				elif fish.is_in_group("pufferfish"):
					_add_fish_to_gameinfo("pufferfish")
				elif fish.is_in_group("kissy_fish"):
					_add_fish_to_gameinfo("kissy_fish")
				else:
					print("error finding fish!!!")
				fish.queue_free()

func _input(e:InputEvent) -> void:
	if e is InputEventKey and e.pressed:
		if (e.keycode == KEY_R) && bulletCount == 0:
			bulletCount += 15
			_set_ammo_text()
			print("Reloaded!")
	if Input.is_action_just_pressed("ui_accept"): # spacebar
		trigger_explosion(global_position)
	if e is InputEventKey:
			trigger_explosion(get_global_mouse_position()) # spawns at mouse cursor
			

 #Optional testing: press space to take damage
	if e.is_action_pressed("ui_accept"):  # usually Space
		take_damage(10)

func _set_ammo_text() -> void:
	ammotext.text = "Ammo: " + str(bulletCount) + " / " + str(maxBulletCount)

func _add_fish_to_gameinfo(s:String) -> void:
	GameInfo.add_fish_ct(s)
	GameInfo.add_cash(s)
	print("added ", s, " to fish collection")
@onready var explosion: CPUParticles2D = $"../Explosion"
func trigger_explosion(pos: Vector2):
	explosion.global_position = pos
	explosion.restart()

func _on_body_entered(body):
		get_parent().trigger_explosion(global_position)
		queue_free()
