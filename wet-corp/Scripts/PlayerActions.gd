extends Area2D

var fishInRadius = false
@onready var HarpoonFire = $HarpoonFire
@onready var FishDeath = $FishDeath
@onready var mainhud = $"../UI/MainHud/Ctrl_harpoon/LABEL_ammo"

#var cash = get_node("/root/MainScene/MainHud/RichTextLabel")
var currentMoney = 0
var ammo = 15
var maxammo = 15
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mainhud.text = "AMMO: " + str(ammo) + "/" + str(maxammo)


func _process(delta: float) -> void:
	position = get_global_mouse_position()
	if(Input.is_action_just_pressed("Shoot") and ammo>0):
		HarpoonFire.play()
		ammo -= 1
		mainhud.text = "AMMO: " + str(ammo) + "/" + str(maxammo)
		if(has_overlapping_areas()): #FISH SHOT
			print("shot")
			FishDeath.play()

			#check health
			for fish in get_overlapping_areas():
				fish.get_parent().free()


#func _on_area_2d_area_entered(area: Area2D) -> void:
	#print("collided")
	#fishInRadius = true
	#pass # Replace with function body.
#
#
#func _on_area_2d_area_exited(area: Area2D) -> void:
	#fishInRadius = false
	#pass # Replace with function body.
