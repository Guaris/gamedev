extends CanvasLayer
signal start_game

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "Dodge the\nCreeps!"
	$MessageLabel.show()
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("stat_game")
func _on_MessageTimer_timeout():
	$MessageLabel.hide()