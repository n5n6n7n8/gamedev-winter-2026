extends Node

@onready var vbox_earnings = $VBoxContainer_earnings
@onready var vbox_deductions = $VBoxContainer_deductions
@onready var payslip_row : PackedScene = load("res://scenes/UI/payslip_container.tscn")
var earnings_max_items : int = 5
var earnings_current_items : int = 0
var deductions_max_items : int = 3
var deductions_current_items : int = 0

func _ready() -> void:
	# example of how to instantiate payslip row.
	# might have to create a "resource" / global variable to track num of fish + total earnings
	# then use that "resource" / global to programmically add rows
	add_earnings_row("this is a test", 100)
	add_earnings_row("this is test 2", 100)
	add_deductions_row("this is a deduction test", 5000)
	
	start_approved_timer()
	return


func add_earnings_row(description:String, amount:int) -> void:
	#do nothing if there are too many, to prevent UI from looking weird
	if deductions_current_items > deductions_max_items:
		return
	#create new instance of payslip_container and add it to vbox_earnings
	var container_instance = payslip_row.instantiate()
	container_instance.description = description
	container_instance.amount = amount
	vbox_earnings.add_child(container_instance)
	earnings_current_items += 1
	return
	
func add_deductions_row(description:String, amount:int):
	#do nothing if there are too many, to prevent UI from looking weird
	if deductions_current_items > deductions_max_items:
		return
	#create new instance of container and add it to vbox_deductions
	var container_instance = payslip_row.instantiate()
	container_instance.description = description
	container_instance.amount = amount
	vbox_deductions.add_child(container_instance)
	deductions_current_items += 1
	return
	
# make "approved" show up after 3 seconds
func start_approved_timer() -> void:
	await get_tree().create_timer(5.0).timeout
	var tween = get_tree().create_tween()
	tween.tween_property($TextureRect_approved, "modulate:a", 1.0, 1.5 ) \
			.set_trans(Tween.TRANS_EXPO)
	# can play sound here when "approved" appears
	return

func _on_button_quit_pressed() -> void:
	get_tree().quit()

#replay level
func _on_button_play_pressed() -> void:
	SceneTransition.change_scene_to_file("res://scenes/main_scene.tscn")
