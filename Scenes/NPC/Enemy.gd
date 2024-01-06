class_name Enemy;
extends CharacterBody2D

@export var movementSpeed = 30.0
@export var enemyHealth = 5
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var incomingProjectile
var incomingDamage = 1
var xpValue = 1.0;

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movementSpeed
	move_and_slide()

func DamageEnemy(damage):
	enemyHealth -= damage;
	if enemyHealth <= 0:
		player.gainXp(xpValue);
		queue_free()
