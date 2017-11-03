extends Node2D

onready var terrain = get_node("Destructible")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	get_node("FPS").set_text(str("FPS: ",OS.get_frames_per_second()))
	get_node("BlockCount").set_text(str("Block count: ",terrain.block_count))
	get_node("MinSize").set_text(str("min_size: ",terrain.min_size))

func _on_Button_pressed():
	get_tree().reload_current_scene()
