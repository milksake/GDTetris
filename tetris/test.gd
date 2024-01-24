extends Node2D

@export var IBlock: PackedScene
@export var JBlock: PackedScene
@export var LBlock: PackedScene
@export var OBlock: PackedScene
@export var SBlock: PackedScene
@export var TBlock: PackedScene
@export var ZBlock: PackedScene
var BlockTypes: Array[PackedScene]
var blocks := []

# Called when the node enters the scene tree for the first time.
func _ready():
	BlockTypes = [IBlock, JBlock, LBlock, OBlock, SBlock, TBlock, ZBlock]
	$floor.add_to_group("tetris")
	create_block()

func create_block():
	var new_block: StaticBody2D = BlockTypes[randi() % BlockTypes.size()].instantiate()
	add_child(new_block)
	blocks.append(new_block)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not blocks.back().active:
		create_block()
