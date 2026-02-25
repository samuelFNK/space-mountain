extends CharacterBody3D

const min_speed:float = 10
const max_speed:float = 30

var turn_speed:float = 0.75
var pitch_speed:float = 0.5
var level_speed:float = 3.0
var throttle_delta:float = 30
var acceleration:float = 6.0

var current_speed:float = 0
var target_speed:float = 0

var vel:Vector3 = Vector3.ZERO
var turn_input:float = 0
var pitch_input:float = 0

func get_input(delta:float):
	if Input.is_action_pressed("throttle_up"):
		target_speed = min(current_speed + throttle_delta * delta, max_speed)
	if Input.is_action_pressed("pitch_down"):
		target_speed = max(current_speed - throttle_delta * delta, min_speed)
	turn_input = Input.get_action_strength("roll_left") - Input.get_action_strength("roll_right")
	pitch_input = Input.get_action_strength("pitch_up") - Input.get_action_strength("pitch_down")
	
func _physics_process(delta:float) -> void:
	get_input(delta)
	
	#PITCH
	transform.basis = transform.basis.rotated(transform.basis.x, pitch_input * pitch_speed * delta)
	#ROTATION
	transform.basis = transform.basis.rotated(Vector3.UP, turn_input * turn_speed * delta)
	$MeshInstance3D.rotation.z = lerp($MeshInstance3D.rotation.z, turn_input, level_speed * delta)
	#VELOCITY
	current_speed = lerp(current_speed, target_speed, acceleration * delta)
	vel = -transform.basis.z * current_speed
	velocity = vel
	move_and_slide()
