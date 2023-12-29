class_name Player
extends CharacterBody2D

signal playerHit;

@export var speed = 20.0;
var friction = 0.9;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every PHYSICS! frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Statically type our motion to be a vector.
	var motion: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Check if we have no input so that we can zero out the velocity rather than waiting for friction 
	# to slow us down. This makes the controls feel more snappy.
	if(motion == Vector2.ZERO):
		velocity = Vector2.ZERO;
	else:
		velocity += motion.normalized() * speed;
		velocity *= friction;
	
	# This handles the physics based movement, and will return a 
	move_and_slide();

# Make sure we flip the player's sprite when an invert occurs.
func _input(event):
	if event.is_action_pressed("invert"):
		invert();

# Invert the color of the sprite
func invert():
	var currentColor = $Sprite2D.self_modulate;
	var invertedColor = Color(1.0 - currentColor.r, 1.0 - currentColor.g, 1.0 - currentColor.b);
	$Sprite2D.set_self_modulate(invertedColor);
	print("Invert Player hit");

###
### /brief Get all weapons a player has an fire them.
###
func fireWeapons():
	
	pass;
