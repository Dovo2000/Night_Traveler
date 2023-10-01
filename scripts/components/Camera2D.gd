extends Camera2D

const LOOK_AHEAD_FACTOR: float = 0.2
const SHIFT_TRANSITION = Tween.TRANS_SINE
const SHIFT_EASE = Tween.EASE_OUT
const SHIFT_DURATION: float = 1.5

var facing = 0
@onready var prev_camera_pos = global_position

func _process(delta):
	check_facing()
	prev_camera_pos = global_position

func check_facing():
	var new_facing = sign(global_position.x - prev_camera_pos.x)
	if new_facing != 0 && facing != new_facing:
		facing = new_facing
		var target_offset = get_viewport_rect().size.x * LOOK_AHEAD_FACTOR * facing
		var tween: Tween = get_tree().create_tween().set_trans(SHIFT_TRANSITION).set_ease(SHIFT_EASE)
		tween.tween_property(self, "position:x", target_offset, SHIFT_DURATION)
		tween.play()
