extends Label

func _ready():
	GameInfo	.gain_cash.connect(on_gain_cash)
# Called when the node enters the scene tree for the first time.
func on_gain_cash():
	var result = ""
	var num_str = str(GameInfo.cash)
	var count := 0
	for i in range(num_str.length() - 1, -1, -1):
		result = num_str[i] + result
		count += 1
		# Add a comma every three digits, except before the first digit
		if count % 3 == 0 and i != 0:
			result = "," + result
	self.text = "$ " + result
