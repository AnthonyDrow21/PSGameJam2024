class_name Enemy;
extends CharacterBody2D

@export var movementSpeed = 60.0
@export var enemyHealth = 5
@export var knockbackValue = 5 
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var incomingProjectile
var lightGem = preload("res://Scenes/Levels/LightGem.tscn");
var darkGem = preload("res://Scenes/Levels/DarkGem.tscn");
const EnemyDMGAnim = preload("res://Scenes/NPC/EnemyDMG.tscn")
var incomingDamage = 1
var xpValue = 1.0;
var rng = RandomNumberGenerator.new();

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movementSpeed
	move_and_slide()

func DamageEnemy(damage, incoming_dmg_pos, knockback_modifier = 1):
	Display_DMG(damage)
	enemyHealth -= damage;
	if enemyHealth <= 0:
		player.gainXp(xpValue);
		queue_free()
		#TODO# If we want gems for increasing XP this is the call to start at.
		spawn_gem(incoming_dmg_pos)
	else:
		knockback_enemy(incoming_dmg_pos, damage, knockback_modifier)

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

func knockback_enemy(dmg_source_pos: Vector2, received_dmg: int, knockback_modifier: int):
	var knockback_strength = received_dmg * knockback_modifier
	var knockback = dmg_source_pos * knockback_strength
	move_and_collide(knockback) 

func spawn_gem(location):
		## Randomize the chance that a Gem will spawn, and lower those chances for the higher XP gems.
	var random_number = rng.randf_range(0.0, 100.0)
	if random_number >= 90.0:
		#Spawn the Dark Gem
		var DarkGem = darkGem.instantiate();
		DarkGem.position = location;
		self.add_child(DarkGem);
	else: if random_number >= 20.0:
		#Spawn the light Gem
		var LightGem = lightGem.instantiate();
		LightGem.position = location;
		self.add_child(LightGem);
