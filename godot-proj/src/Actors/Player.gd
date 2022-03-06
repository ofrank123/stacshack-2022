extends KinematicBody2D

signal moved(new_pos)

var velocity : Vector2 = Vector2()
var direction : Vector2 = Vector2()
var speed : = 694.20

export var last_executed_room := 1000 #just a large value
export var is_busy := false

func read_input():
	velocity = Vector2()
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		direction = Vector2(0,-1)
	if Input.is_action_pressed("down"):
		velocity.y += 1
		direction = Vector2(0,1)
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		direction = Vector2(-1,0)
	if Input.is_action_pressed("right"):
		velocity.x += 1
		direction = Vector2(1,0)
	
	#if two keys pressed at once, power of vector comes from how hard you are pressing the keys
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity*speed) #200 is the speed

func _physics_process(_delta: float) -> void: #runs every frame--player movement dealt with here
	read_input()
	emit_signal("moved", self.position)
	

func _on_Timer_timeout() -> void:
	is_busy = false
	RoomsData.room_states = str(last_executed_room) + str(RoomsData.roomsAndState[last_executed_room]+1)
	print("Timer finished!")
#to do: for defuse button, if timer finished, room state only updated to 4 (i.e. room_states changed) IF FAILED.
#otherwise, ending screen should show!
