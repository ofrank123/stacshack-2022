extends KinematicBody2D

var velocity : Vector2 = Vector2()
var direction : Vector2 = Vector2()
var speed : = 694.20

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

func _physics_process(delta: float) -> void: #runs every frame--player movement dealt with here
	read_input()
	
