class_name MagicWandBullet;
extends Area2D

@onready var enemies = get_tree().get_nodes_in_group("Enemy");

@export var bulletSpeed = 200.0;
@export var damage = 1;
@export var pierce = 1;

var targetVector = Vector2.RIGHT;
var closestEnemy;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Find the nearest enemy when we enter the scene and then save that as our velocity vector.
	var closestDistance = 1000000;
	for enemy in enemies:
		var distance = position.distance_to(enemy.position);
		if(distance < closestDistance):
			closestDistance = distance;
			closestEnemy = enemy;
	
	targetVector = self.position.direction_to(closestEnemy.position);

func _physics_process(delta: float) -> void:
	position += (targetVector * bulletSpeed) * delta;

## This screen notifier connection means we will remove this bullet from the scene once it is outside of the player's view.
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free();

#Function defining the pierce quality
func _Enemy_Hit(charge = 1):
	pierce -= charge
	if pierce <= 0:
		queue_free()

#Signal after Area2D is entered
func _on_area_2d_area_entered(area):
	# check if area is enemy
	var parent = area.get_parent();
	# TODO : fix this line: The group of parent is Enemy as intended.  Was there something else 
	#			broken here?
	if(parent.is_in_group("Enemy") == true):
		parent.DamageEnemy(self.damage, targetVector, parent.knockbackValue);
		_Enemy_Hit()

func applyUpgrades(wand):
	self.damage += wand.damageUpgrade;
	self.bulletSpeed += wand.speedUpgrade;
	self.pierce += wand.pierceUpgrade;
