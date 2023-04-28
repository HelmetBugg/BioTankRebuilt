extends CharacterBody3D

enum States {IDLE, PURSUE, ATTACK, DEATH}
var type = "enemy"
var currentState = States.IDLE
var target
var health = 2
const SPEED = 0.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	if currentState == States.DEATH:
		velocity = Vector3(0, 0, 0)
	elif currentState == States.PURSUE and target != null:
		velocity = -transform.basis.z * SPEED
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()


func take_damage(damage):
	health -= damage
	if health <= 0:
		currentState = States.DEATH
		print("I ded")
	
	
func hit(damage, type):
	print("I've been struck!")
	take_damage(damage)


func _process(delta):
	if currentState == States.PURSUE:
		look_at(target.position, Vector3.UP)
	elif currentState == States.IDLE:
		pass
	elif currentState == States.DEATH:
		pass


func _on_sight_area_area_entered(area):
	if currentState == States.DEATH:
		return
	if(area.name == "PlayerVisibilityArea"): #change to something less hacky
		currentState = States.PURSUE
		target = area.get_parent()


func _on_sight_area_area_exited(area):
	if currentState == States.DEATH:
		return
	if(area.name == "PlayerVisibilityArea" and area.get_parent().name == target.name): 
		currentState = States.IDLE
		target = null
