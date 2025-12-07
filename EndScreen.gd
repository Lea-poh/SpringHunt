extends Node2D

@onready var texrect = $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.6)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

signal restart

func set_results(score):
	if score > 5:
		texrect.texture = load("res://assets/you_win_changed.png")
		$Control/RestartButton.visible = false
		$Control/SecretButton.visible = true
	else:
		texrect.texture = load("res://assets/you_lose.png")
		$Control/RestartButton.visible = true
		$Control/SecretButton.visible = false


func _on_secret_pressed():
	$Control/ScoreLabel.visible = false
	$Control/SecretButton.visible = false
	texrect.texture = load("res://assets/secret.png")
	$Control/RestartButton.visible = true

func _on_restart_pressed():
	restart.emit()
