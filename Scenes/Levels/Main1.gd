class_name Main;
extends Node2D

signal pausePressed();
signal unpausePressed();

var wand;
var wandFound = false;
var isPaused = false;

# Max time in seconds
@export var maxTime = 600.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check every frame if the magic wand has been added. If it has, then wire up the shoot signal.
	var player = get_node("Player");
	#print("The player's current speed is: ", player.speed);
	if(player != null && wandFound == false):
		checkForMagicWand(player);
	
	# DEBUG # prints the number of children in the scene every frame.
	#var children = self.get_children();
	#print(children.size());

func onMagicWandShoot(bullet: Variant, direction: Variant, location: Variant) -> void:
	## AED ## We need to set the bullet's position first before we add it to the scene, otherwise the 
	## ready function will think the bullet's position is zero rather than the player's position.
	var spawnedBullet = bullet.instantiate();
	spawnedBullet.position = location;
	add_child(spawnedBullet);

func checkForMagicWand(player) -> void:
	if(wand == null):
		wand = player.get_node("Wand");
	
	if(wand != null):
		var isConnected: bool = wand.is_connected("magicWandShoot", onMagicWandShoot);
		if(isConnected == false):
			wand.magicWandShoot.connect(onMagicWandShoot);
			wandFound = true;

func _input(event):
	if event.is_action_pressed("Pause"):
		var tree = get_tree();
		if(tree.paused == false):
			tree.paused = true;
			pausePressed.emit();
		else:
			tree.paused = false;
			unpausePressed.emit();
	pass;

func _on_player_player_died() -> void:
	$HUD.showGameOver();
