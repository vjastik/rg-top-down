extends KinematicBody2D

export (int) var max_speed = 75;
export (int) var jump_speed = 150;
export (int) var acceleration = 25;

var velocity = Vector2();
var facing = Vector2();
var is_jumping = false;

var max_hp = 6;
var hp = max_hp;

func jump_off():
	is_jumping = false;
	$SpellItem.visible = true;
	pass;

func jump_control():
	if Input.is_action_just_pressed("jump"):
		is_jumping = true;
		$SpellItem.visible = false;
	
	if velocity != Vector2.ZERO and !is_jumping:
		facing = velocity.normalized();
	
	if is_jumping:
		velocity = facing * jump_speed
	
	pass;

func movement():
	var direction = Vector2();
	
	if Input.is_action_pressed("right"):
		direction.x = min(velocity.x + acceleration, max_speed)
	if Input.is_action_pressed("left"):
		direction.x = max(velocity.x - acceleration, -max_speed)
	if Input.is_action_pressed("down"):
		direction.y = min(velocity.y + acceleration, max_speed)
	if Input.is_action_pressed("up"):
		direction.y = max(velocity.y - acceleration, -max_speed)
	
	if direction == Vector2.ZERO:
		velocity.x = lerp(velocity.x, 0, 0.2)
		velocity.y = lerp(velocity.y, 0, 0.2)
		return;
	
	velocity = direction
	pass;

func _input(event):
	if event.is_action_pressed("fire") and !$SpellCast.is_casting:
		$SpellItem.set_is_firing(true);
	elif $SpellItem.is_firing and event.is_action_released("fire"):
		$SpellItem.set_is_firing(false);
	
	if event.is_action_pressed("spell"):
		$SpellCast.is_casting = true
	
	if event.is_action_pressed("fire") and $SpellCast.is_casting:
		$SpellCast.active_spell.apply_spell()
		$SpellCast.is_casting = false;
	pass;

func _physics_process(delta):
	if hp > 0:
		movement()
		jump_control()
		
		if !is_jumping:
			$SpellItem.fire_control(delta)
		
		velocity = move_and_slide(velocity)
	
	$AnimationPlayer.animation_state(
		is_jumping,
		velocity,
		$SpellItem.position,
		hp
	)
	pass
