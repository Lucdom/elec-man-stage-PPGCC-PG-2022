extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 480 #480
var gravity = 1200
var jump_force = -920 #720
var is_grounded
var move_direction
onready var raycasts = $raycasts


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
		
	_get_input()
	
	velocity = move_and_slide(velocity)
	
	is_grounded = _chec_is_ground()
	
	_set_animation()
	

func _get_input():
	# Input.MOUSE_MODE_VISIBLE
	_set_velocity_x(0)
	_set_move_direction()
	_set_velocity_x(lerp(velocity.x, move_speed * move_direction, 0.3))
	_invert_texture(move_direction)
		
func _set_velocity_x(value: float):
	velocity.x = value
	
func _set_move_direction():
	move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and is_grounded:
		velocity.y = jump_force/2
		
func _chec_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
			
	return false

# move_direction será 1 ou 0
func _invert_texture(direction: int):
	if(direction != 0):
		$texture.scale.x = - direction 
			
func _set_animation():
	var anim = "idle"
	
	#if !is_grounded:
		#anim = "jump"	
	
	
	if velocity.x != 0:
		anim = "run"
		
	if $anim.assigned_animation != anim:
		$anim.play(anim)

