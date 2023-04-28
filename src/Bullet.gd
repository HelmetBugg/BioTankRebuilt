extends Area3D
signal exploded
@export var speed = 40
@export var damage = 1
@export var localGravity = Vector3.DOWN * 0.5
var type = "physical or.. whatever."
var velocity = Vector3.ZERO

func _process(delta):
	velocity += localGravity * delta
	look_at(transform.origin + velocity.normalized(), Vector3.UP)
	transform.origin += velocity * delta

func _on_body_entered(body):
	emit_signal("exploded", transform.origin)
	if body.type == "enemy":
		body.hit(damage, type)
	queue_free()
