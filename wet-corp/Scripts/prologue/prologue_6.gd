extends "res://Scripts/prologue/prologue.gd"

#overwrite prologue.gd change_scene function to stop audio
func change_scene() -> void:
	AudioPlayer.stop_audio()
	super() #call "change_scene" in prologue.gd
