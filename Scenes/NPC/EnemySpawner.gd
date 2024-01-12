extends Node2D

@export var spawns: Array[SpawnInfo] = []

@onready var player: Player = get_tree().get_first_node_in_group("Player")
var skeleton = preload("res://Scenes/NPC/Skeleton/EnemySkeleton.gd")
var wizard = preload("res://Scenes/NPC/Wizard/EnemyWizard.tscn")
var time = 0
var playerIsDead: bool = false;

func _ready() -> void:
	player.playerDied.connect(onPlayerDied);

func _on_timer_timeout():
	if(playerIsDead == false):
		time += 1
		for i in spawns:

			if time >= i.timeStart and time <= i.timeEnd:
				if i.spawnDelayCounter < i.enemySpawnDelay:
					i.spawnDelayCounter += 1
				else:
					i.spawnDelayCounter = 0
					var counter = 0
					while counter < i.enemyNum:
						var enemySpawn = i.enemy.instantiate()
						if(i.enemySpawnLocationType == SpawnInfo.SpawnLocationType.RANDOM_OUTER):
							enemySpawn.global_position = get_random_position();
						elif(i.enemySpawnLocationType == SpawnInfo.SpawnLocationType.RANDOM_OUTER):
							enemySpawn.global_position = get_random_position();
						enemySpawn.global_position = get_random_position()
						add_child(enemySpawn)
						counter += 1

func get_random_position():
	var vpr = get_viewport_rect().size * randf_range(1.1, 1.4)
	var topLeft = Vector2(player.global_position.x - vpr.x/2, player.global_position.y - vpr.y/2)
	var topRight = Vector2(player.global_position.x + vpr.x/2, player.global_position.y - vpr.y/2)
	var bottomLeft = Vector2(player.global_position.x - vpr.x/2, player.global_position.y + vpr.y/2)
	var bottomRight = Vector2(player.global_position.x + vpr.x/2, player.global_position.y + vpr.y/2)
	var posSide = ["up", "down", "right", "left"].pick_random()
	var spawnPos1 = Vector2.ZERO
	var spawnPos2 = Vector2.ZERO
	
	match posSide:
		"up":
			spawnPos1 = topLeft
			spawnPos2 = topRight
		"down":
			spawnPos1 = bottomLeft
			spawnPos2 = bottomRight
		"right":
			spawnPos1 = topRight
			spawnPos2 = bottomRight
		"left":
			spawnPos1 = topLeft
			spawnPos2 = bottomLeft
			
	var xSpawn = randf_range(spawnPos1.x, spawnPos2.x)
	var ySpawn = randf_range(spawnPos1.y, spawnPos2.y)
	return Vector2(xSpawn, ySpawn)

func onPlayerDied():
	playerIsDead = true;
