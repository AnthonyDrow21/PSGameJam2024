class_name Player
extends CharacterBody2D

signal playerHit(damage);
signal playerDied;

const wandScene = preload("res://Scenes/Weapons/MagicWand.tscn");
@onready var currentColor = $Sprite2D.get_self_modulate();
@onready var wand: MagicWand = wandScene.instantiate();

@export var speed = 20.0;
@export var attackSpeed = 1.0; # This is a measure of attacks per second.
@export var damageInterval = 0.5;

var currentWeapons := [];
var friction = 0.9;

var MAX_HEALTH: float = 100.0;
var currentHealth: float = MAX_HEALTH;

var isInverted = false;
var isDamagable = true;

var totalLevel: int = 1;
var totalXp: float = 0.0;
var lightLevel: int = 0;
var darkLevel: int = 0;
var lightXP = 0.0;
var darkXP = 0.0;
var requiredLightXP = 10.0;
var requiredDarkXP = 10.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# This adds a magic wand to the player by default.
	wand.name = "Wand";
	self.add_child(wand);
	
	$DamageTimer.wait_time = damageInterval;
	updateHealthBar();
	pass;

# Called every PHYSICS! frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if(self.is_visible() == true):
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
				#print("setting non hit color")
				setPlayerColor(currentColor)
		else:
			setPlayerColor(Color.RED);
			if(isDamagable == true):
				damagePlayer(5.0);
		
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
		wand.altShoot(self.rotation, self.position);
	else:
		wand.shoot(self.rotation, self.position);

func damagePlayer(damage):
	currentHealth -= damage;
	
	playerHit.emit(damage);
	updateHealthBar();
	isDamagable = false;
	
	if(currentHealth <= 0):
		killPlayer();
		playerDied.emit();
	else:
		$DamageTimer.start();

# TODO # The current health bar looks transparent. Find a way to make it stand out.
func updateHealthBar():
	$HealthBar.value = currentHealth;	

func setPlayerColor(color):
	$Sprite2D.set_self_modulate(color);	

func _on_damage_timer_timeout() -> void:
	isDamagable = true;

func killPlayer() -> void:
	self.hide();

func gainXp(xp) -> void:
	totalXp += xp;
	if(isInverted == true):
		darkXP += xp;
	else:
		lightXP += xp;
	
	var ding = false;
	var darkLvlUp = false;
	if(darkXP >= requiredDarkXP):
		ding = true;
		darkLvlUp = true;
	elif(lightXP >= requiredLightXP):
		ding = true;
	
	if(ding == true):
		lvlUp(darkLvlUp);

func lvlUp(isDarkLevelUp):
	totalLevel += 1;
	if(isDarkLevelUp == true):
		darkLevel += 1;
		requiredDarkXP += requiredDarkXP;
		print("Dark Level ding")
	else:
		lightLevel += 1;
		requiredLightXP += requiredLightXP;
		print("Light Level ding")
	
	print("Ding! Level ", totalLevel, " achieved");
