class_name Main;
extends Node2D

signal pausePressed();
signal unpausePressed();

var wand: MagicWand;
var wandFound: bool = false;
var isPaused: bool = false;

var shotGun: ShotGun;
var shotGunFound: bool = false;

@onready var player: Player = get_node("Player");

@export var worldCorruption: CorruptionInfo;

# Max time in seconds
@export var maxTime = 600.0;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check every frame if the magic wand has been added. If it has, then wire up the shoot signal.
	if(wandFound == false):
		checkForMagicWand(player);
	if(shotGunFound == false):
		checkForShotGun(player);
	
	# DEBUG # prints the number of direct children of main every frame.
	#var children = self.get_children();
	#print(children.size());
	
	# DEBUG # prints the number of enemies on screen;
	#var spawner = get_node("EnemySpawner");
	#var enemies = spawner.get_children();
	#print("Current enemy count: ", enemies.size());

func onMagicWandShoot(bullet: Variant, direction: Variant, location: Variant) -> void:
	## AED ## We need to set the bullet's position first before we add it to the scene, otherwise the 
	## ready function will think the bullet's position is zero rather than the player's position.
	var spawnedBullet = bullet.instantiate();
	spawnedBullet.position = location;
	spawnedBullet.applyUpgrades(wand);
	add_child(spawnedBullet);
	
func onShotGunShoot(bullet: Variant, direction: Variant, location: Variant) -> void:
	for angle in [-30, 0, 30]:
		var spawnedBullet = bullet.instantiate()
		spawnedBullet.position = location
		spawnedBullet.damage += shotGun.damageUpgrade;
		add_child(spawnedBullet)
		var newVector = spawnedBullet.targetVector.rotated(deg_to_rad(angle))
		spawnedBullet.targetVector = newVector
	
func checkForMagicWand(player) -> void:
	if(wand == null):
		wand = player.get_node("Wand");
	
	if(wand != null):
		var isConnected: bool = wand.is_connected("magicWandShoot", onMagicWandShoot);
		if(isConnected == false):
			wand.magicWandShoot.connect(onMagicWandShoot);
			wandFound = true;

func checkForShotGun(player) -> void:
	if(shotGun == null):
		shotGun = player.get_node("ShotGun");
	
	if(shotGun != null):
		var isConnected: bool = shotGun.is_connected("shotGunShoot", onShotGunShoot);
		if(isConnected == false):
			shotGun.shotGunShoot.connect(onShotGunShoot);
			print("ShotGunShoot Connected")
			shotGunFound = true;
	
func _input(event):
	if event.is_action_pressed("Pause"):
		var tree = get_tree();
		if(tree.paused == false):
			tree.paused = true;
			pausePressed.emit();
		else:
			tree.paused = false;
			unpausePressed.emit();
	
	if event.is_action_pressed("invert"):
		if(player.isInverted == true):
			startOrResumeCorruption();
		else:
			pauseCorruption();
	pass;

func startOrResumeCorruption():
	$CorruptionReductionTimer.stop();
	var cTimer: Timer = $CorruptionIncreaseTimer;
	if(cTimer.is_paused() == true):
		cTimer.set_paused(false);
	elif(cTimer.is_stopped() == true):
		cTimer.start();

func pauseCorruption():
	$CorruptionReductionTimer.start();
	var cIncreaseTimer: Timer = $CorruptionIncreaseTimer;
	if(cIncreaseTimer.is_paused() == false):
		cIncreaseTimer.set_paused(true);
	pass;

func _on_player_player_died() -> void:
	$HUD.showGameOver();
	
###NPC Utility
func onWizardBlast(wizardBullet, position, rotation):
	var wizBull = wizardBullet.instantiate();
	wizBull.position = position
	add_child(wizBull);


func _on_Corruption_timeout() -> void:
	worldCorruption.corruption += worldCorruption.corruptionRate;
	if(worldCorruption.corruption >= worldCorruption.corruptionThreshold):
		onCorruptionIncrease();


func _on_corruption_reduction_timer_timeout() -> void:
	if(worldCorruption.corruption > 0):
		worldCorruption.corruption = max(0.0, worldCorruption.corruption - worldCorruption.corruptionReduction);

func onCorruptionIncrease():
	worldCorruption.corruptionTier += 1;
	worldCorruption.corruptionRate *= 2;
	worldCorruption.corruption = 0.0;
	
	# Modify the darkness value of the player.
	var darknessTier = clamp(worldCorruption.corruptionTier, 0, worldCorruption.darknessPerTier.size() - 1);
	var darknessValue = worldCorruption.darknessPerTier[darknessTier];
	var light = player.get_node("PlayerLight");
	light.texture_scale = darknessValue;
	
	
