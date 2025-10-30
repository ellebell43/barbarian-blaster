extends Camera3D

@export var map: GridMap

@onready var mouse_ray = $MouseRay

enum cell_type {VOID = -1, FREE = 0, FREE_FOCUSED = 1, OCCUPIED = 2, OCCUPIED_FOCUSED = 3}

var focus_cell: Vector3i
var cell: Vector3i

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Set mouse ray target via mouse position
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	mouse_ray.target_position = project_local_ray_normal(mouse_position) * 100.0 # increase ray range by 100m
	mouse_ray.force_raycast_update() # force update to get current thing the ray is hitting
	
	# If the ray is colliding with a grid map, figure out what cell is being hovered over.
	if mouse_ray.is_colliding(): 
		var collider = mouse_ray.get_collider()
		if collider is GridMap:
			var collision_point = mouse_ray.get_collision_point()
			cell = map.local_to_map(collision_point)
			var current_cell_type = map.get_cell_item(cell)
			print(cell)
			
			if not cell == focus_cell:
				highlight_cell(cell)
				stop_highlight_cell(focus_cell)
				focus_cell = cell
				
			if Input.is_action_just_pressed("click") and not current_cell_type == cell_type.VOID:
					map.set_cell_item(cell, cell_type.OCCUPIED_FOCUSED)
	else:
		stop_highlight_cell(focus_cell)
		stop_highlight_cell(cell)
		focus_cell = Vector3i(100,100,100)

func highlight_cell(passed_cell: Vector3i) -> void:
	if map.get_cell_item(passed_cell) == cell_type.FREE:
		map.set_cell_item(passed_cell, cell_type.FREE_FOCUSED)
	if map.get_cell_item(passed_cell) == cell_type.OCCUPIED:
		map.set_cell_item(passed_cell, cell_type.OCCUPIED_FOCUSED)

func stop_highlight_cell(passed_cell: Vector3i) -> void:
	if map.get_cell_item(passed_cell) == cell_type.FREE_FOCUSED:
		map.set_cell_item(passed_cell, cell_type.FREE)
	if map.get_cell_item(passed_cell) == cell_type.OCCUPIED_FOCUSED:
		map.set_cell_item(passed_cell, cell_type.OCCUPIED)
