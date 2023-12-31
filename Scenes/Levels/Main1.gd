extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_magic_wand_shoot(bullet: Variant, direction: Variant, location: Variant) -> void:
	var spawnedBullet = bullet.instantiate();
	add_child(spawnedBullet);
	spawnedBullet.rotation = direction;
	spawnedBullet.position = location;
	#spawnedBullet.velocity = spawnedBullet.velocity.rotated(direction);
