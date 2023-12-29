extends Area2D

signal playerHit;

@export var speed = 100.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO;
	if(Input.is_action_pressed("move_right") == true):
		velocity.x += 1;
	if(Input.is_action_pressed("move_left") == true):
		velocity.x -= 1;
	if(Input.is_action_pressed("move_up") == true):
		velocity.y -= 1;
	if(Input.is_action_pressed("move_down") == true):
		velocity.y += 1;
	
	# Normalize the velocity so that diagnol movement is not faster than a single direction.
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed;
	
	position += velocity * delta;
