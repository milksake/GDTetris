extends Node2D

@export var IBlock: PackedScene
var blocks := []

# Called when the node enters the scene tree for the first time.
func _ready():
	$floor.add_to_group("tetris")
	create_block()
	$Timer.connect("timeout", create_block)
	$Timer.start()

func create_block():
	var new_block := IBlock.instantiate()
	add_child(new_block)
	blocks.append(new_block)
	print("nuevo bloque")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
