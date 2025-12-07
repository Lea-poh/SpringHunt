extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

signal restart

func set_results(score):
	$Control/ScoreLabel.text = "Flowers: " + str(score)

	if score > 5:
		$Control/ResultLabel.text = "YOU WIN! 🏆 Here is your reward!"
		$Control/SecretButton.visible = true
	else:
		$Control/ResultLabel.text = "YOU LOSE 💀"
		$Control/RestartButton.visible = true


func _on_secret_pressed():
	$Control/ResultLabel.visible = false
	$Control/ScoreLabel.visible = false
	$Control/SecretButton.visible = false
	$Control/SecretLabel.visible = true

func _on_restart_pressed():
	restart.emit()
