extends CharacterBody3D
const MOVEMENT_SPEED = 3.0
const ROTATION_SPEED = 1.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	handle_input(delta)
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()

func handle_input(delta):
	velocity = Vector3(0, 0, 0)
	if Input.is_action_pressed("Forward"):
		velocity = -transform.basis.z * MOVEMENT_SPEED
	elif Input.is_action_pressed("Back"):
		velocity = transform.basis.z * MOVEMENT_SPEED
	if Input.is_action_pressed("Right"):
		rotate_y(-ROTATION_SPEED * delta)
	elif Input.is_action_pressed("Left"):
		rotate_y(ROTATION_SPEED * delta)

