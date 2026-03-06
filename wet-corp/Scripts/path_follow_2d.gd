extends PathFollow2D

@export var speed : float = 0.1
@export var speed_curve : Curve
@onready var ArmorHit
var tspeed = speed
var fish_name = "none"
# Called when the node enters the scene tree for the first time.

#only use on armor fish
var fish_health = 0
var kissy = false
var puff = false
var up = false
var toScale = Vector2(0.002,0.002)

func update_after_instantiation():
	if(fish_name == "armored_fish"):
		fish_health = 3
		ArmorHit = $"ArmorHit"
	if(fish_name == "pregnant_fish"):
		fish_health = 7
	if(fish_name == "kissy_fish"):
		kissy = true
	if(fish_name == "pufferfish"):
		puff = true

func take_damage():
	fish_health -= 1
	if(fish_name == "armored_fish"):
		ArmorHit.play()

func should_die() -> bool:
	print("fish health is ", fish_health)
	return fish_health <= 0

func _physics_process(delta: float) -> void:
	tspeed = speed * speed_curve.sample(progress_ratio)
	progress_ratio += delta * tspeed
	if(puff):
		scale += toScale
		if(scale.length()<0.9):
			up = false
	if(progress_ratio>=0.95): #when the fish hits the boat
		self.get_parent().queue_free()
		GameInfo.take_dmg_by_fish(fish_name)
