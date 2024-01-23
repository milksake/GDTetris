extends Node2D

var active_block : Node2D = null
var current_block_index = 0

var phase = 0
@onready var tetris_area = $TetrisArea
@onready var player = $Player
@onready var player_start_position = player.position

func _ready() -> void:
	tetris_area.connect("blocks_finished", change_phase)
	player.connect("died", reset_phase)

func _process(delta: float) -> void:
	if phase == 0:
		tetris_area.update()
	if Input.is_action_just_pressed("reset_all"):
		reset_all()
	if Input.is_action_just_pressed("reset"):
		reset_phase()

func change_phase():
	phase += 1
	if phase == 1:
		player.active = true

func reset_all():
	tetris_area.clear_blocks()
	player.position = player_start_position
	player.modify_rotation = true
	player.active = false
	phase = 0

func reset_phase():
	if phase == 0:
		tetris_area.clear_blocks()
	else:
		player.position = player_start_position

func _on_goal_body_entered(body: Node2D) -> void:
	print("You Win")
	reset_all()
