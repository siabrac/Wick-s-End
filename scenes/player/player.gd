extends CharacterBody2D
class_name Player

enum Directions {
	up, up_right, right, down_right, down, down_left, left, up_left
}


@export var speed: float = 400


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


var _current_direction: Directions = Directions.down


func _physics_process(delta):
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if !input_dir:
		play_idle_animation()
		velocity = Vector2.ZERO
	else:
		var velo = input_dir.normalized()
		_current_direction = get_direction_from_velocity(velo)
		play_walking_animation()
		velocity = velo * speed

	move_and_slide()

func play_idle_animation():
	sprite.play("idle_" + get_direction_string(_current_direction))


func play_walking_animation():
	sprite.play("walk_" + get_direction_string(_current_direction))


func get_direction_from_velocity(velocity: Vector2) -> Directions:
	var angle = rad_to_deg(velocity.angle())
	   
	if angle < 0:
		angle += 360
	if angle >= 337.5 or angle < 22.5:
		return Directions.right
	elif angle >= 22.5 and angle < 67.5:
		return Directions.down_right
	elif angle >= 67.5 and angle < 112.5:
		return Directions.down
	elif angle >= 112.5 and angle < 157.5:
		return Directions.down_left
	elif angle >= 157.5 and angle < 202.5:
		return Directions.left
	elif angle >= 202.5 and angle < 247.5:
		return Directions.up_left
	elif angle >= 247.5 and angle < 292.5:
		return Directions.up
	elif angle >= 292.5 and angle < 337.5:
		return Directions.up_right

	return Directions.down  # Default direction


func get_direction_string(direction: Directions) -> String:
	return Directions.keys()[direction]


