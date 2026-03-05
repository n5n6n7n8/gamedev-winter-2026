extends Label

func _ready():
	GameInfo	.gain_cash.connect(on_gain_cash)
	on_gain_cash()
# Called when the node enters the scene tree for the first time.
func on_gain_cash():
	var isNeg = (GameInfo.cash < 0)
	var result = ""
	var num_str = str(GameInfo.cash)
	if(isNeg):
		num_str = num_str.substr(1)
	var count := 0
	for i in range(num_str.length() - 1, -1, -1):
		result = num_str[i] + result
		count += 1
		# Add a comma every three digits, except before the first digit
		if count % 3 == 0 and i != 0:
			result = "," + result
	if(isNeg):
		self.text = "$ -" + result
	else:
		self.text = "$ " + result
