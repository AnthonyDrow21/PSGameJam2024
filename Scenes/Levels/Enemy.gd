extends CharacterBody2D

var _speed = 30

##var velocity = Vector2.ZERO

# @onready means that this variable will be instantiated after the ready() function is called.
@onready var player = get_tree().get_nodes_in_group("Player")[0];
var _randomnum
var _target

enum {
	SURROUND,
	ATTACK,
	HIT
}

var _state = SURROUND

func _ready():
	var _rng = RandomNumberGenerator.new()
	_rng.randomize()
	_randomnum = _rng.randf()

func _physics_process(delta):
	_target = get_circle_position(_randomnum)
	
	match _state:
		SURROUND:
			move(_target,delta)
			
func move(target,delta):
	var _direction = (target - global_position).normalized()
	var desired_velocity = _direction * _speed 
	var _steering = (desired_velocity - velocity) * delta * 2.5
	velocity += _steering
	move_and_slide()

func get_circle_position(random):
	var kill_circle_center = player.position ##Switch out with player location later
	print("current kill center: ", kill_circle_center)
	
	var _radius = 40
	var _angle = random * PI * 2;
	var x = kill_circle_center.x + cos(_angle) * _radius;
	var y = kill_circle_center.y + sin(_angle) * _radius;
	
	return Vector2(x, y)
