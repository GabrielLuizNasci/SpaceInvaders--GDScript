extends CharacterBody2D


@onready var move_timer: Timer = $Timers/MoveTimer
@onready var teleport_timer: Timer = $Timers/TeleportTimer

var speed: float = 200.0
var teleport_force: float = 1250.0
var can_move : bool = true
var can_teleport: bool = false

func _physics_process(_delta: float) -> void:
	if can_move:
		velocity.y = speed
		move_and_slide()
		can_move = false
		move_timer.start()
	else:
		velocity.y = 0.0
	
	if can_teleport:
		velocity.x = randf_range(-teleport_force, teleport_force)
		move_and_slide()
		can_teleport = false
		teleport_timer.start()
		velocity.x = 0.0
	else:
		velocity.x = 0.0

func _on_move_timer_timeout() -> void:
	can_move = true

func _on_teleport_timer_timeout() -> void:
	can_teleport = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Shot"):
		queue_free()
