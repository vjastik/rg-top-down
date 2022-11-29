extends Node2D

var is_casting = false;
var available_radius = 100;

func activate():
	$Indicator.visible = true
	pass;

func apply_spell():
	print("applied")
	$Indicator.visible = false
	pass;

func control_position():
	var relative_mouse_position = get_global_mouse_position() - global_position
	var length_mouse = relative_mouse_position.length();
	var max_position = relative_mouse_position.normalized() * available_radius;
	
	if (length_mouse > available_radius):
		$Indicator.position = max_position
	else:
		$Indicator.position = relative_mouse_position
	
#	$Indicator.position = get_global_mouse_position() - global_position
	pass;

func _process(delta):
	control_position()
	pass;
