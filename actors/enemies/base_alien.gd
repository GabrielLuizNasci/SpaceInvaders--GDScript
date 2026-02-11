extends CharacterBody2D
class_name BaseEnemy

@onready var move_timer: Timer = $Timers/MoveTimer

@export var speed: float = 200.0

var can_move : bool = true

func _physics_process(_delta: float) -> void:
	if can_move:
		velocity.y = speed
		move_and_slide()
		can_move = false
		move_timer.start()
	else:
		velocity.y = 0.0

func _on_move_timer_timeout() -> void:
	can_move = true

func die() -> void:
	queue_free()
