extends Node2D

var block_count = 0
var fps
export var min_size = 4

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	block_count = get_node("Blocks").get_child_count()
	if block_count < 400:
		min_size = 8
	else:
		min_size = 16
	
	fps = OS.get_frames_per_second()
	if fps > 55:
		min_size /= 2
	elif fps < 40:
		min_size *= 2
	
	if fps < 30:
		min_size = clamp(min_size, 4, 32)
	else:
		min_size = clamp(min_size, 4 , 16)
