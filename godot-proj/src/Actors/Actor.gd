extends KinematicBody2D
class_name Actor

#physics process runs every frame - you should store player movements here
func _physics_process(delta: float) -> void: 
	var velocity: = Vector2(300,0)
	move_and_slide(velocity)
