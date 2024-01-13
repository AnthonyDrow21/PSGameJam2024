extends Enemy

@onready var getPlayer = get_tree().get_first_node_in_group("res://Scenes/Player/Player.tscn")
@onready var getMain = get_tree().get_root().get_node("Main")

signal wizardBlast()
var magicReady = false
var wizardBullet = preload("res://Scenes/NPC/Wizard/wizardBullet.tscn")

func _ready():
	movementSpeed = 30;
	enemyHealth = 20;
	self.wizardBlast.connect(getMain.onWizardBlast)

func _physics_process(_delta):
	if magicReady == true:
		wizardBlast.emit(wizardBullet,self.position, self.rotation)
		magicReady = false
	else:
		pass
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movementSpeed
	move_and_slide()
	
#
func _on_attack_timer_timeout():
	magicReady = true

func DamageEnemy(damage, incoming_dmg_pos):
	Display_DMG(damage)
	enemyHealth -= damage;
	if enemyHealth <= 0:
		player.gainXp(xpValue);
		queue_free()
	else:
		var knockback_modifier = 5;
		knockback_enemy(incoming_dmg_pos, damage, knockback_modifier)
