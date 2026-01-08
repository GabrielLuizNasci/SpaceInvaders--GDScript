extends CharacterBody2D

@export var speed := 100.0
@export var fire_rate := 0.5

@onready var fire_timer: Timer = $FireTimer
@onready var blast_spawn_point: Node2D = $BlastSpawnPoint
@onready var restart_detection_area: Area2D = %RestartDetectionArea

var can_shoot := true
var viewport_width := 0.0
var shot_path = preload("res://objects/shots/green_shot.tscn")

func _ready() -> void:
	viewport_width = get_viewport_rect().size.x

func _physics_process(_delta: float) -> void:
	handle_movement()
	handle_shooting()

func handle_movement() -> void:
	var direction := Input.get_axis("left", "right")
	velocity.x = direction * speed
	velocity.y = 0.0
	
	move_and_slide()

func handle_shooting() -> void:
	if Input.is_action_just_pressed("shoot") and can_shoot:
		can_shoot = false
		fire_timer.start()
		var shot = shot_path.instantiate()
		
		shot.global_position = blast_spawn_point.global_position
		get_parent().add_child(shot)

func _on_fire_timer_timeout() -> void:
	can_shoot = true

func _on_restart_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		print("JOGADOR ATINGIDO! Reiniciando a cena...")
		get_tree().reload_current_scene()
