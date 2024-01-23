extends Area2D

var IBlock: PackedScene = preload("res://tetris/I-block.tscn")
var JBlock: PackedScene = preload("res://tetris/J-block.tscn")
var LBlock: PackedScene = preload("res://tetris/L-block.tscn")
var BlockTypes: Array[PackedScene]
var blocks := []

enum PIECES {I, J, L}
@export var level_blocks : Array[PIECES]
var active_block : Node2D = null
var current_block_index = 0

signal blocks_finished

func _ready():
	BlockTypes = [IBlock, JBlock, LBlock]

func update() -> void:
	if not active_block or not active_block.active:
		create_block()

func create_block():
	if current_block_index >= level_blocks.size():
		blocks_finished.emit()
		return
	var new_block: CharacterBody2D = BlockTypes[level_blocks[current_block_index]].instantiate()
	add_child(new_block)
	new_block.global_position.y = 0
	new_block.position.x = 0
	blocks.append(new_block)
	active_block = new_block
	current_block_index += 1

func clear_blocks():
	for b in blocks:
		b.call_deferred("queue_free")
	blocks.clear()
	current_block_index = 0
