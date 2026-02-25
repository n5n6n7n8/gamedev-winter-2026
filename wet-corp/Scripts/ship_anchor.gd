extends Control

@onready var ship_sprites = [$"Ship-1", $"Ship-2", $"Ship-3", $"Ship-4", $"Ship-5",$"Ship-6"]
var elapsed = 0;
var y_scale = 15;
var loop_speed = 0.75;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameInfo.cargo_health_changed.connect(update_visible_ship)
	pass # Replace with function body.
	
func _process(delta:float) -> void:
	elapsed += delta
	if elapsed >= 2*PI/loop_speed:
		elapsed = 0
	self.position.y = -y_scale * sin(loop_speed * elapsed)

func update_visible_ship():
	#hide all children
	for child in self.get_children():
		child.visible = false
	
	#get sprite index based on cargo health
	var current_ship_sprite = 5 - ((5 * (GameInfo.cargo_health)) / 100)
	ship_sprites[current_ship_sprite].visible = true
	print("change ship sprite to:", current_ship_sprite)
