extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_magic_wand_shoot(bullet: Variant, direction: Variant, location: Variant) -> void:
	var spawnedBullet = bullet.instantiate();
	spawnedBullet.position = location;
	## AED ## We need to set the bullet's position first before we add it to the scene, otherwise the 
	# ready function will think the bullet's position is zero rather than the player's position.
	add_child(spawnedBullet);
	#spawnedBullet.rotation = direction;
	#spawnedBullet.velocity = spawnedBullet.velocity.rotated(direction);
