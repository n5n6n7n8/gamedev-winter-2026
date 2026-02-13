extends Node

var skip_enabled : bool = false;
@export var next_scene : PackedScene

func _ready() -> void:
	# create timer so user doesn't accidentally skip by clicking too early
	$Timer.start()
	$Timer.connect("timeout", enable_skip)
	$AnimationPlayer.play("animation")
	
func enable_skip():
	print("skip enabled")
	skip_enabled = true;

func change_scene():
	print("change scene")
	SceneTransition.change_scene_to_file(next_scene.resource_path)

func _input(e:InputEvent) -> void:
	if not skip_enabled:
		return
	
	# handle button presses
	if e is InputEventMouseButton and e.pressed:
		if (e.button_index == MOUSE_BUTTON_LEFT):
			change_scene()
	if e is InputEventKey and e.pressed:
		if (e.keycode == KEY_SPACE):
			change_scene()
