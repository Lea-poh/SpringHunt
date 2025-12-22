extends Node2D

@onready var sprite = $Area2D/Sprite2D

var flower_textures = [
	preload("res://assets/flowers/Asset 1.png"),
	preload("res://assets/flowers/Asset 2.png"),
	preload("res://assets/flowers/Asset 3.png"),
	preload("res://assets/flowers/Asset 4.png"),
	preload("res://assets/flowers/Asset 5.png"),
	preload("res://assets/flowers/Asset 6.png")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = flower_textures.pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_area_2d_body_entered(body):
	if body.name == "Bee":
		$AudioStreamPlayer.play()
		# ✅ Find the Game node safely
		var game = get_tree().get_first_node_in_group("Game")
		if game:
			game.add_flower()

		await $AudioStreamPlayer.finished
		queue_free()
