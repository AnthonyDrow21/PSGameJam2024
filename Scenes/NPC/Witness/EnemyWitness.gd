extends Enemy

@onready var getPlayer = get_tree().get_first_node_in_group("res://Scenes/Player/Player.tscn")
@onready var getMain = get_tree().get_root().get_node("Main")

func _ready():
	enemyHealth = 25
	self.xpValue = 3.0
	self.knockbackValue = 2;

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movementSpeed
	move_and_slide()
