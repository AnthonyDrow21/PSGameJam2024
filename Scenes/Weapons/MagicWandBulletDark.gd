class_name MagicWandBulletDark;

extends MagicWandBullet

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var closestDistance = 1000000;
	for enemy in enemies:
		var distance = position.distance_to(enemy.position);
		if(distance < closestDistance):
			closestDistance = distance;
			closestEnemy = enemy;
	
	if(closestEnemy != null):
		targetVector = self.position.direction_to(closestEnemy.position);

