extends Node3D

const speed:float = 80


func _physics_process(delta: float) -> void:
	
	self.global_position = self.global_position + -transform.basis.z * speed * delta
	
	if $RayCast3D.is_colliding():
		self.queue_free()
	
