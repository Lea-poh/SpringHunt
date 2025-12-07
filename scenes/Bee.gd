extends CharacterBody2D

@export var speed = 400
@onready var anim_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var input := Vector2.ZERO

	# ✅ Keyboard input
	input.x = Input.get_axis("ui_left", "ui_right")
	input.y = Input.get_axis("ui_up", "ui_down")

	# ✅ Virtual Joystick input (overrides keyboard if used)
	var joystick = get_tree().get_first_node_in_group("VirtualJoystick")
	if joystick and joystick.joystick_vector != Vector2.ZERO:
		input = joystick.joystick_vector

	input = input.normalized()

	if get_parent().can_move:
		# ✅ Smooth movement (your original logic preserved)
		var desired_velocity = input * speed
		velocity = 0.05 * (desired_velocity - velocity) + velocity
		move_and_slide()

		# ✅ Animation control
		if input != Vector2.ZERO:
			if anim_sprite.animation != "fly":
				anim_sprite.play("fly")
			
			# ✅ Flip based on movement direction
			anim_sprite.flip_h = input.x > 0
		else:
			if anim_sprite.animation != "rest":
				anim_sprite.play("rest")
	else:
		velocity = Vector2.ZERO
		move_and_slide()
		if anim_sprite.animation != "rest":
			anim_sprite.play("rest")
