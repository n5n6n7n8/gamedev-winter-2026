extends MarginContainer

@onready var label_description = $Payslip_row/Label_description
@onready var label_amount = $Payslip_row/Label_amount

var description : String
var amount : int

func _ready() -> void:
	set_info(description, amount)

# set text labels for description and cash amount
# param description : a description for the "Earnings/Deductions" column
# param amount : an integer for amt of money earned/deducted
func set_info(desc:String, amt:int) -> void:
	label_description.text = desc
	label_amount.text = "$" + str(amt)
