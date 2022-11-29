extends AnimationPlayer

enum ANIMATION_STATES {
	idle_bottom,
	idle_top,
	
	run_bottom,
	run_top,
	
	jump_bottom,
	jump_top,
	
	death
}

var state = ANIMATION_STATES.idle_bottom

func animation_state(is_jumping: bool, velocity: Vector2, facing_direction: Vector2, hp: int):
	var facing_left = facing_direction.x < 0;
	var facing_bottom = facing_direction.y > 0;
	var direction_value = abs(velocity.x) + abs(velocity.y)
	
	state = ANIMATION_STATES.idle_bottom if facing_bottom else ANIMATION_STATES.idle_top
	
	if direction_value > 2 and facing_bottom:
		state = ANIMATION_STATES.run_bottom
	if direction_value > 2 and !facing_bottom:
		state = ANIMATION_STATES.run_top
	
	if is_jumping and facing_bottom:
		state = ANIMATION_STATES.jump_bottom
	if is_jumping and !facing_bottom:
		state = ANIMATION_STATES.jump_top
	
	if hp <= 0:
		state = ANIMATION_STATES.death
	
	pass

func animation_control():
	match state:
		ANIMATION_STATES.idle_bottom:
			play("Idle_bottom")
		ANIMATION_STATES.idle_top:
			play("Idle_top")
			
		ANIMATION_STATES.run_bottom:
			play("Move_bottom")
		ANIMATION_STATES.run_top:
			play("Move_top")
		
		ANIMATION_STATES.jump_bottom:
			play("Jump_bottom")
		ANIMATION_STATES.jump_top:
			play("Jump_top")
		
		ANIMATION_STATES.death:
			play("Death")
	
	pass

func _process(_delta):
	animation_control()
	pass
