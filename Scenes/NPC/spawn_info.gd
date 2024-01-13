extends Resource

class_name SpawnInfo

enum SpawnLocationType{RANDOM_OUTER, CIRCLE}

@export var timeStart:int
@export var timeEnd:int
@export var enemy:Resource
@export var enemyNum:int
@export var enemySpawnDelay:int
@export var corruptionTier:int
@export var circleRadius:float; # This value is only used if SpawnLocationType == Circle;
@export var enemySpawnLocationType : SpawnLocationType

var spawnDelayCounter = 0

