class_name Player
extends CharacterBody2D

signal playerHit;

@export var speed = 20.0;
# This is a measure of attacks per second.
@export var attackSpeed = 1.0;
@onready var currentColor = $Sprite2D.get_self_modulate();
var wand;

var currentWeapons := [];
var friction = 0.9;
var isInverted = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# This is currently assuming that the player will always get a Magic wand on startup.
	wand = $MagicWand;
	wand.name = "Wand";
	pass # Replace with function body.

# Called every PHYSICS! frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Statically type our motion to be a vector and get the movement inputs from the player.
	var motion: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	# Check if we have no input so that we can zero out the velocity rather than waiting for friction 
	# to slow us down. This makes the controls feel more snappy.
	if(motion == Vector2.ZERO):
		velocity = Vector2.ZERO;
	else:
		velocity += motion.normalized() * speed;
		velocity *= friction;
	# This handles the physics based movement, and will return true if it collided with an object.
	var collided = move_and_slide();
	var badCollision = false;
	
	# Check for collisions with enemies.
	for i in get_slide_collision_count():
			var collision = get_slide_collision(i);
			var colObject = collision.get_collider();
			
			# We will only detect an enemy collision if they are in the "Enemy" group.
			if(colObject.is_in_group("Enemy") == true):
				badCollision = true;
	
	# Revert our color if we have not hit anything or the environment, otherwise set the hit color.
	if(collided == false || badCollision == false):
		if($Sprite2D.get_self_modulate() != currentColor):
			print("setting non hit color")
			$Sprite2D.set_self_modulate(currentColor);
	else:
		print("setting hit color")
		$Sprite2D.set_self_modulate(Color.RED);
	
	fireWeapons();

# Make sure we flip the player's sprite when an invert occurs.
func _input(event):
	if event.is_action_pressed("invert"):
		invert();

# Invert the color of the sprite
func invert():
	var invertedColor = Color(1.0 - currentColor.r, 1.0 - currentColor.g, 1.0 - currentColor.b);
	$Sprite2D.set_self_modulate(invertedColor);
	currentColor = $Sprite2D.self_modulate;	
	isInverted = !isInverted;
	print("Invert Player hit");

###
### /brief Get all weapons a player has an fire them.
###
func fireWeapons():
	if(isInverted == true):
		wand.shoot(self.rotation, self.position);
		pass;
		#magicWandShoot.emit(bullet, rotation, position);
