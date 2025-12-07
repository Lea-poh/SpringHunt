extends CharacterBody2D

@export var speed = 250
@onready var anim_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var input = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()
	
	if get_parent().can_move:
		# Move the bee
		velocity = input * speed
		move_and_slide()

		# Play fly animation if moving, rest if not
		if input != Vector2.ZERO:
			if anim_sprite.animation != "fly":
				anim_sprite.play("fly")
			# Flip horizontally based on X movement
			anim_sprite.flip_h = input.x > 0
		else:
			if anim_sprite.animation != "rest":
				anim_sprite.play("rest")
	else:
		velocity = Vector2.ZERO
		move_and_slide()
		if anim_sprite.animation != "rest":
			anim_sprite.play("rest")
