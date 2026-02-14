extends Node

var skip_enabled : bool = false;
@export var next_scene : PackedScene
@export var skip_timer_length : float = 1.0;

func _ready() -> void:
	# create timer so user doesn't accidentally skip by clicking too early
	var timer = get_tree().create_timer(skip_timer_length)
	timer.connect("timeout", enable_skip)

	#progressbar tween to show skip progress
	var tween = get_tree().create_tween()
	tween.tween_property($TextureProgressBar, "value", 100, skip_timer_length)
	
	#play animation
	$AnimationPlayer.play("animation")
	await $AnimationPlayer.animation_finished
	enable_skip() #enable skip if animation finishes before timer
	
	
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
