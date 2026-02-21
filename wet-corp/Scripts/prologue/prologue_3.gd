extends "res://Scripts/prologue/prologue.gd"

@export var audio_stream : AudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (audio_stream != null):
		AudioPlayer.play_audio(audio_stream)
	super() #call "_ready" in prologue.gd
