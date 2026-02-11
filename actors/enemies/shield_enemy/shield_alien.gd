class_name ShieldAlien extends BaseEnemy

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var shield: CharacterBody2D = $Shield

func _ready() -> void:
	collision_shape_2d.disabled = true
	shield.shield_broken.connect(on_shield_broken)

func on_shield_broken() -> void:
	collision_shape_2d.set_deferred("disabled", false)
	print("Escudo quebrado")
