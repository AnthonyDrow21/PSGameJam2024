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
					var points = arrangeInCircle(i.enemyNum, i.circleRadius, player.global_position);
					
					while counter < i.enemyNum:
						var enemySpawn = i.enemy.instantiate()
						if(i.enemySpawnLocationType == SpawnInfo.SpawnLocationType.RANDOM_OUTER):
							enemySpawn.global_position = get_random_position();
						elif(i.enemySpawnLocationType == SpawnInfo.SpawnLocationType.CIRCLE):
							enemySpawn.global_position = points[counter];
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

func arrangeInCircle(n: int, r: float, center = Vector2.ZERO, offsetAngle = 0.0) -> Array:
	var output = []
	var offset = 2.0 * PI / abs(n) # could verify that n is non-zero.
	for i in range(n):
		var pos = polar2Cartesian(r, i * offset + offsetAngle)
		output.push_back(pos + center)
	return output;

func polar2Cartesian(r, theta) -> Vector2:
	var x = r * cos(theta);
	var y = r * sin(theta);
	return Vector2(x, y);

func onPlayerDied():
	playerIsDead = true;
