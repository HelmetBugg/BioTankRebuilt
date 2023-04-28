extends Area3D

signal exploded

@export var speed = 40
@export var localGravity = Vector3.DOWN * 0.5

var velocity = Vector3.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity += localGravity * delta
	look_at(transform.origin + velocity.normalized(), Vector3.UP)
	transform.origin += velocity * delta


func _on_body_entered(body):
	print("sploded")
	emit_signal("exploded", transform.origin)
	#wqueue_free()
