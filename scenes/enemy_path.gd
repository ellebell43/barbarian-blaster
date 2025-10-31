class_name EnamyPath

extends Path3D

@export var enemy_scene: PackedScene

@onready var spawn_timer := $SpawnTimer

func spawn_enemy() -> void:
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
