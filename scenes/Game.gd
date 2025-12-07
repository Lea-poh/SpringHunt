extends Node2D

signal game_finished(score)

@onready var timer = $GameTimer
@onready var score_label = $Control/VBoxContainer/FlowerCounter
@onready var timer_label = $Control/VBoxContainer/TimerLabel

var flowers_collected = 0
var total_flowers = 0
var can_move = false

func _ready():
	start_game()

func start_game():
	flowers_collected = 0
	can_move = true

	# ✅ Count all flower instances in the scene
	total_flowers = get_tree().get_nodes_in_group("Flowers").size()

	timer.start()

func _process(delta):
	timer_label.text = "Time: " + str(int(timer.time_left))
	score_label.text = "Flowers: " + str(flowers_collected)

func add_flower():
	flowers_collected += 1

	# ✅ End game when last flower is collected
	if flowers_collected >= total_flowers:
		end_game()

func _on_game_timer_timeout():
	end_game()

func end_game():
	if not can_move:
		return  # prevents double-calling from timer + flower at same time

	can_move = false
	timer.stop()
	game_finished.emit(flowers_collected)
