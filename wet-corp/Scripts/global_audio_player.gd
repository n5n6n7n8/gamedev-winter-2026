extends Node

@export var audio_stream : AudioStream
@export var play_on_start : bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (audio_stream != null) and play_on_start:
		print("playing audio")
		play_audio(audio_stream)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_audio(audio_stream:AudioStream):
	AudioPlayer.play_audio(audio_stream)
	
func stop_audio() -> void:
	AudioPlayer.stop_audio()
