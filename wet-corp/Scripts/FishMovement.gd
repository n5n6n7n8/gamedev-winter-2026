extends CharacterBody2D

#@onready var parent = get_parent as PathFollow2D
@export var fishspeed = -400
var fishvel = null


func _ready() -> void:
	fishvel = Vector2(fishspeed, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(fishvel * delta)
	#if parent is PathFollow2D:
		#parent.set_progress(parent.get_progress() + 200 * delta)
	#if collision:
		#print("I collided with ", collision.get_collider().name)
