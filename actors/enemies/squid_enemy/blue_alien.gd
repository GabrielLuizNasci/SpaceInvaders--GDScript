class_name BlueEnemy extends BaseEnemy

@onready var teleport_timer: Timer = $Timers/TeleportTimer

@export var teleport_force: float = 1250.0

var can_teleport: bool = true

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if can_teleport:
		velocity.x = randf_range(-teleport_force, teleport_force)
		move_and_slide()
		can_teleport = false
		teleport_timer.start()
	else:
		velocity.x = 0.0

func _on_teleport_timer_timeout() -> void:
	can_teleport = true
