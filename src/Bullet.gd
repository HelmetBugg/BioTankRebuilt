extends Area3D
signal exploded
var exploding = false;
@export var speed = 40
@export var damage = 1
@export var localGravity = Vector3.DOWN * 0.5

@onready var _bullet_splosion = $splosion

var type = "physical or.. whatever."
var velocity = Vector3.ZERO

func _process(delta):
	if !exploding:
		velocity += localGravity * delta
		look_at(transform.origin + velocity.normalized(), Vector3.UP)
		transform.origin += velocity * delta
	else:
		velocity = Vector3(0, 0, 0)

func _on_body_entered(body):
	emit_signal("exploded", transform.origin)
	if "type" in body and body.type == "enemy":
		body.hit(damage, type)
	exploding = true
	$MeshInstance3D.visible = false
	$splosion.visible = true
	_bullet_splosion.play("splode")


func _on_splosion_animation_finished():
	queue_free()
