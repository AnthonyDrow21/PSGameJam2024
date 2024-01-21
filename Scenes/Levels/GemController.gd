class_name GemController; 
extends Area2D

@onready var enemies = get_tree().get_nodes_in_group("Enemy");
@onready var player = get_tree().get_first_node_in_group("Player")
var lightGem = preload("res://Scenes/Levels/LightGem.tscn");
var darkGem = preload("res://Scenes/Levels/DarkGem.tscn");
var rng = RandomNumberGenerator.new();

func spawnGem(location):
	## Randomize the chance that a Gem will spawn, and lower those chances for the higher XP gems.
	var random_number = rng.randf_range(0.0, 100.0)
	if random_number >= 90.0:
		#Spawn the Dark Gem
		var DarkGem = darkGem.instantiate()
		DarkGem.position = location
		add_child(DarkGem)
		pass;
	if random_number >= 50.0:
		#Spawn the light Gem
		var LightGem = lightGem.instantiate()
		LightGem.position = location
		add_child(LightGem)
		pass;
	pass;
