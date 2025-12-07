extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.6)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
signal start_game

func _on_button_pressed():
	start_game.emit()
