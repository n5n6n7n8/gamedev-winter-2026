extends Node

@onready var audio_player = $AudioStreamPlayer2D;

func play_audio(audio_file:AudioStream):
	audio_player.stream = audio_file
	audio_player.play()

func stop_audio():
	if audio_player.playing:
		audio_player.stop()
