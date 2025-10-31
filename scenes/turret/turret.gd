class_name Turret

extends Node3D

@export var projectile: PackedScene
@export var shot_speed := 1.0
@export var turret_range := 10.0

@onready var shot_timer: Timer = $ShotTimer
@onready var turret_barrel: MeshInstance3D = $TurretBase/TurretTop
@onready var animation_player := $AnimationPlayer

var shoot := false
var enemy_path: Path3D

func _ready() -> void:
	shot_timer.wait_time = shot_speed

func _physics_process(_delta: float) -> void:
	var target = find_best_target()
	if target:
		shoot = true
		look_at(find_best_target().global_position, Vector3.UP, true)
	else:
		shoot = false

func _on_shot_timer_timeout() -> void:
	if shoot:
		animation_player.play("shoot")
		var shot = projectile.instantiate()
		add_child(shot)
		shot.global_position = turret_barrel.global_position
		shot.direction = global_transform.basis.z # modify direction based on the global z axis rather than the parents z

func find_best_target() -> PathFollow3D:
	var best_target: PathFollow3D = null
	for target in enemy_path.get_children():
		if target is PathFollow3D:
			if not best_target or target.progress > best_target.progress:
				if global_position.distance_to(target.global_position) <= turret_range:
					best_target = target
	return best_target
