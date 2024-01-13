extends Enemy;

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movementSpeed
	move_and_slide()

func DamageEnemy(damage, incoming_dmg_pos):
	Display_DMG(damage)
	enemyHealth -= damage;
	if enemyHealth <= 0:
		player.gainXp(xpValue);
		queue_free()
	else:
		var knockback_modifier = 10;
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
