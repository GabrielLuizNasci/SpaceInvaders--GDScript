extends CharacterBody2D

@export var speed: float = 200.0
@export var direction: Vector2 = Vector2.UP

func _physics_process(_delta: float) -> void:
	velocity = direction * speed
	
	var collision = move_and_slide()
	
	if collision:
		var hit_body = get_slide_collision(0).get_collider()
		if hit_body and hit_body.has_method("die"):
			hit_body.die()
		queue_free()
	
	if global_position.y < -50 or global_position.y > get_viewport_rect().size.y + 50:
		queue_free() 
	move_and_slide()	
