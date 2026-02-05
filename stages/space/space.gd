extends Node2D

const YELLOW_SCENE = preload("res://actors/enemies/alien_enemy/yellow_alien.tscn")
const BLUE_SCENE = preload("res://actors/enemies/squid_enemy/blue_alien.tscn")
const PINK_SCENE = preload("res://actors/enemies/shield_enemy/pink_alien.tscn")

@onready var alien_spawn_timer: Timer = $Timers/AlienSpawnTimer
@onready var squid_spawn_timer: Timer = $Timers/SquidSpawnTimer
@onready var pink_spawn_timer: Timer = $Timers/PinkSpawnTimer
@onready var difficulty_timer: Timer = $Timers/DifficultyTimer

var viewport_width: float = 0.0
var alien_spawn_interval: float = 1.5 
var squid_spawn_interval: float = 8.0 
var pink_spawn_interval: float = 12.0 
var min_spawn_interval: float = 0.5 

func _ready() -> void:
	viewport_width = get_viewport_rect().size.x
	
	alien_spawn_timer.wait_time = alien_spawn_interval
	squid_spawn_timer.wait_time = squid_spawn_interval
	pink_spawn_timer.wait_time = pink_spawn_interval
	difficulty_timer.wait_time = 30.0 
	
	alien_spawn_timer.start()
	squid_spawn_timer.start()
	pink_spawn_timer.start()
	difficulty_timer.start()

func spawn_enemy(enemy_scene: PackedScene) -> void:
	var enemy = enemy_scene.instantiate()
	
	var spawn_x = randf_range(50, viewport_width - 50)
	var spawn_y = -10 
	enemy.global_position = Vector2(spawn_x, spawn_y)
	
	add_child(enemy)

func _on_alien_spawn_timer_timeout() -> void:
	spawn_enemy(YELLOW_SCENE)
	alien_spawn_timer.start()

func _on_squid_spawn_timer_timeout() -> void:
	spawn_enemy(BLUE_SCENE)
	squid_spawn_timer.start()

func _on_pink_spawn_timer_timeout() -> void:
	spawn_enemy(PINK_SCENE)
	pink_spawn_timer.start()

func _on_difficulty_timer_timeout() -> void:
	if alien_spawn_interval > min_spawn_interval:
		alien_spawn_interval *= 0.85 
		alien_spawn_timer.wait_time = alien_spawn_interval
		
	if squid_spawn_interval > alien_spawn_interval * 2.0: 
		squid_spawn_interval *= 0.90
		squid_spawn_timer.wait_time = squid_spawn_interval
		
	difficulty_timer.start() 
	print("Dificuldade Aumentada!")
	print(" Alien Spawn Time: ", alien_spawn_timer.wait_time)
	print("Squid Spawn Time: ", squid_spawn_timer.wait_time)
