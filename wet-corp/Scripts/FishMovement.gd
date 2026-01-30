extends CharacterBody2D

@export var fishspeed = 400
var fishvel = Vector2(fishspeed, 0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(fishvel * delta)
	#if collision:
		#print("I collided with ", collision.get_collider().name)
	pass
