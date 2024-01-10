extends Enemy

func _ready():
	movementSpeed = 120;
	enemyHealth = 20;

#func _physics_process(_delta):
	#var direction = global_position.direction_to(player.global_position)
	#velocity = direction * movementSpeed
	#move_and_slide()

#func DamageEnemy(damage):
	#enemyHealth -= damage;
	#if enemyHealth <= 0:
		#player.gainXp(xpValue);
		#queue_free()


