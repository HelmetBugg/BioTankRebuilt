extends CharacterBody3D

enum States {IDLE, PURSUE, ATTACK, DEATH}
var currentState = States.IDLE
var target;
const SPEED = 0.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	if target != null:
		velocity = -transform.basis.z * SPEED
	move_and_slide()

func _process(delta):
	if currentState == States.PURSUE:
		look_at(target.position, Vector3.UP)
	elif currentState == States.IDLE:
		pass
	elif currentState == States.DEATH:
		pass

func _on_sight_area_area_entered(area):
	if(area.name == "PlayerVisibilityArea"): #change to something less hacky
		currentState = States.PURSUE
		target = area.get_parent()


func _on_sight_area_area_exited(area):
	if(area.name == "PlayerVisibilityArea" and area.get_parent().name == target.name): 
		currentState = States.IDLE
		target = null
