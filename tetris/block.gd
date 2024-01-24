extends StaticBody2D

const VEL_Y := 100.0
const MAX_VEL_Y := 500.0
const BLOCK_SIZE := 32
var active := true
var screen_size: Vector2
var remainder: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("tetris")
	screen_size = get_viewport_rect().size
	position.x = screen_size.x / 2
	set_collision_scale(0.9)

func set_collision_scale(ratio: float):
	if has_node("coll1"):
		$coll1.scale = Vector2(ratio, ratio)
	if has_node("coll2"):
		$coll2.scale = Vector2(ratio, ratio)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt: float):
	if active:
		var mov := Vector2(0, 0)
		if Input.is_action_pressed("block_move_left"):
			remainder.x -= MAX_VEL_Y * dt
		
		if Input.is_action_pressed("block_move_right"):
			remainder.x += MAX_VEL_Y * dt
		
		while remainder.x < -BLOCK_SIZE:
			mov.x -= BLOCK_SIZE
			remainder.x += BLOCK_SIZE
		
		while remainder.x > BLOCK_SIZE:
			mov.x += BLOCK_SIZE
			remainder.x -= BLOCK_SIZE
		
		if not move_and_collide(mov, true):
			move_and_collide(mov)
		
		mov = Vector2(0, 0)
		if Input.is_action_pressed("block_down"):
			remainder.y += MAX_VEL_Y * dt
		else:
			remainder.y += VEL_Y * dt
		
		while remainder.y > BLOCK_SIZE:
			mov.y += BLOCK_SIZE
			remainder.y -= BLOCK_SIZE
		
		if not move_and_collide(mov, true):
			move_and_collide(mov)
		else:
			active = false
			set_collision_scale(1)
		
		mov = Vector2(0, 0)
		if Input.is_action_just_pressed("block_rotate"):
			rotation += PI / 2.0
			if move_and_collide(mov, true):
				rotation -= PI / 2.0
		
