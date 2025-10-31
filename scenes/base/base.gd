class_name PlayerBase

extends Node3D

@export var max_health: int = 5
@onready var health_label: Label3D = $HealthLabel

var current_health: int:
	set(new_health):
		current_health = new_health
		health_label.text = str(current_health) + "/" + str(max_health)
		health_label.modulate = Color.RED.lerp(Color.WHITE, float(current_health) / float(max_health))
		if (current_health <= 0):
			get_tree().reload_current_scene()
	get:
		return current_health

func _ready() -> void:
	current_health = max_health

func take_damage (damage: int) -> void:
	current_health -= damage
