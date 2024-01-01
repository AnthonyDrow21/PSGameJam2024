class_name MagicWandBullet;
extends Area2D

@onready var enemies = get_tree().get_nodes_in_group("Enemy");
var bulletSpeed = 100.0;
var targetVector = Vector2.RIGHT;
var closestEnemy;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Find the nearest enemy when we enter the scene and then save that as our velocity vector.
	var closestDistance = 1000000;
	for enemy in enemies:
		#print(self.position);
		var distance = position.distance_to(enemy.position);
		#print(distance);
		if(distance < closestDistance):
			closestDistance = distance;
			closestEnemy = enemy;
	
	targetVector = self.position.direction_to(closestEnemy.position);
	#print(targetVector);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Find nearest enemy
	
	var speed = targetVector * bulletSpeed;
	position += speed * delta;
