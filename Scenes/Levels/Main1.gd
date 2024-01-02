extends Node2D

var wand;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check every frame if the magic wand has been added. If it has, then wire up the shoot signal.
	checkForMagicWand();
	
	# DEBUG # prints the number of children in the scene every frame.
	# var children = self.get_children();
	# print(children.size());


func onMagicWandShoot(bullet: Variant, direction: Variant, location: Variant) -> void:
	## AED ## We need to set the bullet's position first before we add it to the scene, otherwise the 
	## ready function will think the bullet's position is zero rather than the player's position.
	var spawnedBullet = bullet.instantiate();
	spawnedBullet.position = location;
	add_child(spawnedBullet);

func checkForMagicWand() -> void:
	if(wand == null):
		var player = get_node("Player");
		wand = player.get_node("Wand");
	
	if(wand != null):
		var isConnected: bool = wand.is_connected("magicWandShoot", onMagicWandShoot);
		if(isConnected == false):
			wand.magicWandShoot.connect(onMagicWandShoot);
			print("magic Wand shoot is Connected");
