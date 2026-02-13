extends RichTextLabel
#
#var fading = false
#func _ready() -> void:
	#$Timer.wait_time = 4.0
	#$Timer.start()
#
#func _on_timer_timeout() -> void:
	#fading = true
	#
#func _process -> void:
	#if(fading):
		#
var fade_duration = 5.0

func _ready():
   modulate.a = 1
   await get_tree().create_timer(1).timeout
   fade_in()

func fade_in():
   var tween = get_tree().create_tween()
   tween.tween_property(self, "modulate:a", 0, fade_duration)
   tween.play()
   await tween.finished
   tween.kill()

func fade_out():
   var tween = get_tree().create_tween()
   tween.tween_property(self, "modulate:a", 1, fade_duration)
   tween.play()
   await tween.finished
   tween.kill()
