extends CharacterBody2D

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
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt: float):
	if active:
		if Input.is_action_pressed("block_down"):
			remainder.y += MAX_VEL_Y * dt
		else:
			remainder.y += VEL_Y * dt
		
		if Input.is_action_pressed("block_move_left"):
			remainder.x -= MAX_VEL_Y * dt
		
		if Input.is_action_pressed("block_move_right"):
			remainder.x += MAX_VEL_Y * dt
		
		while remainder.x > BLOCK_SIZE:
			position.x += BLOCK_SIZE
			remainder.x -= BLOCK_SIZE
		
		while remainder.x < -BLOCK_SIZE:
			position.x -= BLOCK_SIZE
			remainder.x += BLOCK_SIZE
		
		while remainder.y > BLOCK_SIZE:
			position.y += BLOCK_SIZE
			remainder.y -= BLOCK_SIZE
		
		if Input.is_action_just_pressed("block_rotate"):
			rotation += PI / 2.0

		move_and_slide()
		if is_on_floor():
			active = false
