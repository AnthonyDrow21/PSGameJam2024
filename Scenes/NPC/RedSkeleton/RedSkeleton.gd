extends Enemy;

func _ready():
	movementSpeed = 60;
	enemyHealth = 25;
	self.knockbackValue = 2.5;
	#$AnimationPlayer
	
func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movementSpeed
	move_and_slide()

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
