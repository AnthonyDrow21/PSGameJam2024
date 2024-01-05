extends CharacterBody2D

@export var movementSpeed = 30.0
@export var enemyHealth = 1;
@onready var player = get_tree().get_first_node_in_group("Player")

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movementSpeed
	move_and_slide()

func _on_hit_box_area_entered(area):
	enemyHealth = enemyHealth - 1
	if enemyHealth <= 0:
		queue_free()
	else:
		pass
	pass # Replace with function body.
