extends Area2D
class_name PlayerActions

signal health_changed  # signal for HealthBar

# Health variables
var health := 100
var max_health := 100

#Ammo variables n stuff
const maxBulletCount = 15
var canShoot = true
var bulletCount = maxBulletCount
var ammoCount = 45

# Optional gameplay variables
@onready var HarpoonFire = $HarpoonFire
@onready var FishDeath = $FishDeath
var currentMoney := 0

## Take damage function
#func take_damage(amount):
	#health -= amount
	#health = clamp(health, 0, max_health)
	#health_changed.emit()  # notify HealthBar
#
	#if health <= 0:
		#game_over()

# Called when player dies
#func game_over():
	#print("GAME OVER")
	#get_tree().reload_current_scene()

# Example shooting/movement logic
func _process(delta):
	position = get_global_mouse_position()

	if Input.is_action_just_pressed("Shoot") && canShoot && bulletCount > 0:
		#canShoot = false
		bulletCount -= 1
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
			print(bulletCount)

func _reload(): 
	var reloadCount = maxBulletCount - bulletCount
	
	if ammoCount >= reloadCount:
		bulletCount += reloadCount
		ammoCount -= reloadCount
	else:
		bulletCount += ammoCount
		ammoCount = 0

func _add_fish_to_gameinfo(s:String) -> void:
	GameInfo.add_fish_ct(s)
	GameInfo.add_cash(s)
	print("added ", s, " to fish collection")

	

# Optional testing: press space to take damage
#func _input(event):
	#if event.is_action_pressed("ui_accept"):  # usually Space
		#take_damage(10)
