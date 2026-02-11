extends CharacterBody2D

signal shield_broken

func die() -> void:
	shield_broken.emit()
	queue_free()
