extends Node2D

const Projectile = preload("res://Modules/Projectile/TestProjectile.tscn")

export var interval_time = 0.5;
export var radius = 8.0;

var timer = 0;

var is_firing = false;

func set_is_firing(value: bool):
	is_firing = value
	pass;

func fire():
	var projectile = Projectile.instance()
	var direction = get_global_mouse_position() - global_position;
	projectile.setup(
		500 * 40,
		200,
		direction,
		global_position
	);
	get_tree().get_root().call_deferred("add_child", projectile);

func control_position():
	var direction = (get_global_mouse_position() - get_parent().position).normalized();
	position = direction * radius;

func fire_control(delta):
	if is_firing and timer >= interval_time:
		fire();
		timer = 0;
	
	if timer < interval_time:
		timer += delta;
	pass;

func _process(_delta):
	control_position();
