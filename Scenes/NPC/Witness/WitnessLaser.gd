extends RayCast2D

@onready var player = get_tree().get_first_node_in_group("Player")

@export var castSpeed = 7000.0
@export var maxLength = 1400.0
@export var growthTime = 0.1
@export var damage = 0.5

@onready var lineInstance = $Line2D

var actualTarget = Vector2(0,0)
var findTarget = Vector2(0,0)
var offTarget = Vector2(0,0)
var isCasting = false;
var offSet = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	actualTarget = to_local(player.global_position)
	offTarget = to_local(self.global_position)
	offSet += delta * 0.01
	findTarget = offTarget.lerp(actualTarget, offSet)
	set_target_position(findTarget)
	lineInstance.set_point_position(0, findTarget)
	if is_colliding() == true:
		if get_collider() != null && get_collider().is_in_group("Player") == true:
			player.damagePlayer(damage)
		else:
			pass
	else:
		pass
		

#func _on_timer_timeout():
	#offTarget = self.global_position
	#pass # Replace with function body.
