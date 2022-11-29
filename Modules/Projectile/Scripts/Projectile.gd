extends Node2D

const Colidable = [1, 8]

var distance = 100;
var speed = 100;
var direction = Vector2();

var velocity = Vector2();

func setup(_distance: int, _speed: int, _direction: Vector2, _position: Vector2):
	self.distance = _distance;
	self.speed = _speed;
	self.direction = _direction;
	self.position = _position;

func _draw():
	draw_circle(Vector2.ZERO, 4.0, Color(0.7, 0, 0))

func _process(delta):
	distance -= speed;
	
	if distance > 0:
		position += direction.normalized() * speed * delta
#		velocity = move_and_slide(direction.normalized() * speed);
	else:
		queue_free()


func _on_Area2D_body_entered(body):
	if Colidable.has(body.get_collision_layer()):
		queue_free()
	pass
