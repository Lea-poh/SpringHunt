extends Node

@onready var game_scene = preload("res://scenes/Game.tscn")
@onready var start_scene = preload("res://scenes/StartScreen.tscn")
@onready var end_scene = preload("res://scenes/Endsceen.tscn")

var current_scene

func _on_resize():
	get_viewport().size = get_window().size

func _ready():
	get_tree().root.size_changed.connect(_on_resize)
	show_start()

func show_start():
	clear_scene()
	current_scene = start_scene.instantiate()
	add_child(current_scene)
	current_scene.start_game.connect(start_game)

func start_game():
	clear_scene()
	current_scene = game_scene.instantiate()
	add_child(current_scene)
	current_scene.game_finished.connect(show_end)

func show_end(score):
	clear_scene()
	current_scene = end_scene.instantiate()
	add_child(current_scene)
	current_scene.set_results(score)
	current_scene.restart.connect(show_start)

func clear_scene():
	if current_scene:
		current_scene.queue_free()
