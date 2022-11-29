extends Sprite

var facing_left = true;
var facing_bottom = true;

func _process(delta):
	var direction = (get_global_mouse_position() - global_position).normalized()
	
	facing_left = scale.x == 1
	facing_bottom = direction.y > 0;
	
	if direction.x < 0 and !facing_left:
		scale.x = 1;

	if direction.x >= 0 and facing_left:
		scale.x = -1;
	
	if facing_bottom:
		z_index = 4
	else:
		z_index = 6
	
	pass;
