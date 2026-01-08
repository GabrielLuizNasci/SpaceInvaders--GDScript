extends ParallaxLayer

const SCROLL_SPEED := 80.0

var mirror_height: float = 0.0

func _ready() -> void:
	mirror_height = motion_mirroring.y
	
	if mirror_height == 0:
		print("ERRO: O ParallaxLayer.motion_mirroring.y não está definido no Inspector. O loop pode falhar.")
		mirror_height = get_viewport_rect().size.y

func _process(delta: float) -> void:
	var movement: float = SCROLL_SPEED * delta
	motion_offset.y += movement
	
	if motion_offset.y >= mirror_height:
		motion_offset.y -= mirror_height
