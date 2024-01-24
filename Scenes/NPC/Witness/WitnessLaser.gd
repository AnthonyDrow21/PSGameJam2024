extends RayCast2D

@onready var player = get_tree().get_first_node_in_group("Player")

@export var damage = 0.1

@onready var lineInstance = $Line2D

var laserEndpoint = Vector2(0,0)
var findTarget = Vector2(0,0)
var laserStartpoint = Vector2(0,0)
var isCasting = false;
var offSet = randf_range(0.001, .01)

# Called when the node enters the scene tree for the first time.
func _ready():
	laserStartpoint = to_local(self.global_position)
	pass	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	laserEndpoint = to_local(player.global_position)
	findTarget = findTarget.lerp(laserEndpoint, offSet)
	set_target_position(findTarget)
	lineInstance.set_point_position(0, findTarget)
	if is_colliding() == true:
		if get_collider() != null && get_collider().is_in_group("Player") == true:
			player.damagePlayer(damage)
		else:
			pass
	else:
		pass
