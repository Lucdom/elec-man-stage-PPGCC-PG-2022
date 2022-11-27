extends KinematicBody2D

export var speed = 20
export var health = 1
var velocity = Vector2.ZERO
var move_direction = -1
var gravity = 1200

onready var _player = get_node("../Player")


func _physics_process(delta: float) -> void:
	speed = getSpeed()
	velocity.x = speed * move_direction
	velocity = move_and_slide(velocity)
	velocity = move_and_slide(velocity)
	
	if $ray_wall_left.is_colliding():
		move_direction = 1

	if $ray_wall_right.is_colliding():
		move_direction = -1
		
	if !$ray_ground_left.is_colliding():
		move_direction = 1
		
	if !$ray_ground_right.is_colliding() :
		move_direction = -1

func _position():
	return global_position.x
	
func getSpeed():
	var y_position = position.y - _player.position.y
	var is_inline = y_position < 14 && y_position > 6
	
	if (_player._chec_is_ground() && is_inline):
		return 60
	else:
		return 20


	
	

