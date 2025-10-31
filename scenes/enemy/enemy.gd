class_name Enemy
extends PathFollow3D

@export var speed:= 5
@export var damage: int = 1
@export var delay: float = 0
@export var max_health := 50
@export var currency_reward = 15

@onready var base: PlayerBase = get_tree().get_first_node_in_group("base")
@onready var animation_player = $AnimationPlayer
@onready var ui: UI = get_tree().get_first_node_in_group("ui")

var current_health: int:
	set(new_health):
		if new_health < current_health:
			animation_player.play("take_damage")
		current_health = new_health
		if current_health < 1:
			ui.current_currency += currency_reward
			queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * speed
	if (progress_ratio == 1):
		base.take_damage(damage)
		queue_free()
