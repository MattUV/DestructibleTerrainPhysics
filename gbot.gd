extends Area2D

var released = true
var click_pos = Vector2(0,0)
var prev_pos

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if released:
			click_pos = get_global_mouse_pos()
			prev_pos = get_global_pos()
			released = false
			
		set_global_pos(prev_pos + get_global_mouse_pos() - click_pos)
	else:
		released = true


func _on_GBot_body_enter( body ):
	if body.has_method("subdivide"):
		body.subdivide()
