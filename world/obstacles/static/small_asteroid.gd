extends RigidBody3D

const torque:Vector3 = Vector3(0.1, 0, 0.1)

func _ready() -> void:
	self.gravity_scale = 0
	angular_damp_mode = RigidBody3D.DAMP_MODE_REPLACE
	angular_damp = 0.0
	linear_damp_mode = RigidBody3D.DAMP_MODE_REPLACE
	linear_damp = 0.0
	apply_torque_impulse(torque)
