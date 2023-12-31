class_name Enemy;
extends CharacterBody2D

@export var movementSpeed = 30.0
@export var enemyHealth = 5
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var incomingProjectile
const EnemyDMGAnim = preload("res://Scenes/NPC/EnemyDMG.tscn")
var incomingDamage = 1
var xpValue = 1.0;

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movementSpeed
	move_and_slide()

func DamageEnemy(damage):
	Display_DMG(damage)
	enemyHealth -= damage;
	if enemyHealth <= 0:
		player.gainXp(xpValue);
		queue_free()

func damage_effect(EFFECT: PackedScene, effect_position: Vector2 = global_position):
	if EFFECT:
		var effect = EFFECT.instantiate()
		get_tree().current_scene.add_child(effect)
		effect.global_position = effect_position
		return effect

func Display_DMG(damage: int):
	var indicator = damage_effect(EnemyDMGAnim)
	if indicator:
		indicator.label.text = str(damage)
