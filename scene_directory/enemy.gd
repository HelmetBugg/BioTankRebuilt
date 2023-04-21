extends CharacterBody3D

enum States {IDLE, PURSUE, ATTACK, DEATH}
var currentState = States.IDLE
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	pass



func _on_sight_area_area_entered(area):
	if(area.name == "PlayerVisibilityArea"): #change to something less hacky
		currentState = States.PURSUE
	print(currentState)
