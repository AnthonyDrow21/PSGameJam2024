extends Enemy

@onready var getPlayer = get_tree().get_first_node_in_group("res://Scenes/Player/Player.tscn")
@onready var getMain = get_tree().get_root().get_node("Main")

signal wizardBlast()
var magicReady = false
var wizardBullet = preload("res://Scenes/NPC/Wizard/wizardBullet.tscn")

func _ready():
	self.knockbackValue = 2;
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
	
func _on_attack_timer_timeout():
	magicReady = true
