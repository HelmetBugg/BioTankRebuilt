extends RigidBody3D

const MOVEMENT_SPEED = 4500
const ROTATION_SPEED = 1.0
const JUMP_VELOCITY = 4.5
var slew_acceleration: float = 1
var max_slew: float = 100
var bullet = preload("res://scene_directory/bullet.tscn")

func _physics_process(delta):
	handle_input(delta)

func handle_input(delta):
	if Input.is_action_pressed("Forward"):
		self.apply_central_force(self.get_global_transform().basis.z.normalized() * -MOVEMENT_SPEED)
	elif Input.is_action_pressed("Back"):
		self.apply_central_force(self.get_global_transform().basis.z.normalized() * MOVEMENT_SPEED)
	if Input.is_action_pressed("Left"):
		self.angular_velocity.y = min(self.angular_velocity.y + slew_acceleration, max_slew)
	elif Input.is_action_pressed("Right"):
		self.angular_velocity.y = max(self.angular_velocity.y - slew_acceleration, -max_slew)

	if Input.is_action_just_pressed("Shoot"):
		var b = bullet.instantiate()
		owner.add_child(b)
		b.transform = $Base/top/Barrel.global_transform
		b.velocity = -b.transform.basis.z * b.speed
