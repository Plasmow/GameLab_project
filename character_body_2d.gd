extends CharacterBody2D

# Player variables
var speed = 200
var gravity = 500
var jump_force = -300
var velocity = Vector2(0,0)

# Get the AnimatedSprite node
onready var character_sprite = $CharacterSprite

func _physics_process(delta):
	velocity.y += gravity * delta

	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		character_sprite.flip_h = false
		character_sprite.play("Walk")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		character_sprite.flip_h = true
		character_sprite.play("Walk")
	else:
		velocity.x = 0
		character_sprite.stop()  # Stop the animation when not moving

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force

	velocity = move_and_slide(velocity, Vector2.UP)
