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
var grounded:bool = false

var vel:Vector3 = Vector3.ZERO
var turn_input:float = 0
var pitch_input:float = 0

func get_input(delta:float):
	if Input.is_action_pressed("throttle_up"):
		target_speed = min(current_speed + throttle_delta * delta, max_speed)
	if Input.is_action_pressed("throttle_down"):
		var min_limit:float = 0.0 if grounded else min_speed
		target_speed = max(current_speed - throttle_delta * delta, min_limit)
	turn_input = 0
	if current_speed > 0.5: 
		turn_input = Input.get_action_strength("roll_left") - Input.get_action_strength("roll_right")
	pitch_input = 0
	if not grounded:
		pitch_input -= Input.get_action_strength("pitch_down") 
	if current_speed >= 1:
		pitch_input += Input.get_action_strength("pitch_up")
	
func _physics_process(delta:float) -> void:
	get_input(delta)
	
	#PITCH
	transform.basis = transform.basis.rotated(transform.basis.x, pitch_input * pitch_speed * delta)
	#ROTATION
	transform.basis = transform.basis.rotated(Vector3.UP, turn_input * turn_speed * delta)
	if grounded:
		$MeshInstance3D.rotation.z = 0
	else:
		$MeshInstance3D.rotation.z = lerp($MeshInstance3D.rotation.z, turn_input, level_speed * delta)
	#VELOCITY
	current_speed = lerp(current_speed, target_speed, acceleration * delta)
	vel = -transform.basis.z * current_speed
	velocity = vel
	
	if is_on_floor():
		if not grounded:
			rotation.x = 0
		grounded = true
		vel.y -= 1
		velocity = vel
	else:
		grounded = false
		
	move_and_slide()
