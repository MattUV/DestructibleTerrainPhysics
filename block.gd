extends RigidBody2D

onready var terrain = get_parent().get_parent()

export var size = 32
export var mass = 10.0
var min_size = 4

var shape
var region_origin = Vector2(0,0)
var newNode = []

func _ready():
	connect("mouse_enter",self,"_on_block_mouse_enter")
	get_node("VisibilityNotifier2D").connect("exit_screen",self,"_on_VisibilityNotifier2D_exit_screen")
	
	set_mass(mass)
	
	clear_shapes()
	var new_shape = terrain.get_node(str("Shapes/Shape",size)).get_shape()
	add_shape(new_shape)
	
	get_node("Sprite").set_region_rect(Rect2(region_origin,Vector2(size,size)))
	
	set_fixed_process(true)

func _on_block_mouse_enter():
	subdivide()

func subdivide():
	if size / 2 >= min_size:
		var new_size = size / 2
		for i in range(4):
			newNode.append(duplicate())
			newNode[i].size = new_size
		
		newNode[0].set_pos(get_pos() + Vector2(-new_size/2, -new_size/2))
		newNode[1].set_pos(get_pos() + Vector2(new_size/2, -new_size/2))
		newNode[2].set_pos(get_pos() + Vector2(-new_size/2, new_size/2))
		newNode[3].set_pos(get_pos() + Vector2(new_size/2, new_size/2))
		
		newNode[0].region_origin = region_origin
		newNode[1].region_origin = region_origin + Vector2(new_size, 0)
		newNode[2].region_origin = region_origin + Vector2(0, new_size)
		newNode[3].region_origin = region_origin + Vector2(new_size, new_size)
		
		for i in range(4):
			newNode[i].mass = mass / 4
			newNode[i].set_global_rot(get_global_rot())
			get_parent().add_child(newNode[i])
	
	queue_free()

func _fixed_process(delta):
	min_size = terrain.min_size
	if size < min_size/2:
		queue_free()
		
	var energy = mass * get_linear_velocity().length_squared() / 2
	if get_colliding_bodies().size() > 0:
		if energy > 8000:
			subdivide()

func _on_VisibilityNotifier2D_exit_screen():
	queue_free()
