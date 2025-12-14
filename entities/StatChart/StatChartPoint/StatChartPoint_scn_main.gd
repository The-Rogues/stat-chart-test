extends Node2D

var slf_radius: float
var slf_dir: Vector2
var slf_actual_spd: float
var slf_logical_spd: float
var slf_unit: float
var slf_actual_pos: float
var slf_logical_pos: float

func init_point(
	in_radius: float,
	in_dir: Vector2,
	in_spd: float,
	in_unit: float,
	in_pos: int
) -> void:
	slf_radius = in_radius
	slf_dir = in_dir
	slf_logical_spd = in_spd
	slf_unit = in_unit
	slf_actual_pos = float(in_pos) * slf_unit
	slf_logical_pos = float(in_pos) * slf_unit
	set_position(slf_actual_pos * slf_dir)

func _draw() -> void:
	draw_circle(
		Vector2(0.0, 0.0), 
		slf_radius, 
		Color(1.0, 1.0, 1.0, 1.0), 
		true
	)
	
func _process(delta: float) -> void:
	if is_equal_approx(slf_actual_pos, slf_logical_pos):
		return
		
	var sign: int = 1
	if slf_actual_pos > slf_logical_pos:
		sign = -1
		
	slf_actual_pos += sign * slf_actual_spd * delta
	
	if slf_actual_pos > slf_logical_pos && sign == 1:
		slf_actual_pos = slf_logical_pos
		set_position(slf_dir * slf_actual_pos)
		return
	elif slf_actual_pos < slf_logical_pos && sign == -1:
		slf_actual_pos = slf_logical_pos
		set_position(slf_dir * slf_actual_pos)
		return
	
	translate(slf_dir * sign * slf_actual_spd * delta)

# When logical position is changed, we need to calculate the speed it takes to get to
# the logical position from the actual position.
# We have distance, and we know the time we want to take to travel the distance.
# Therefore, the speed will be abs(logical position - actual pos) / time
func change_pos(in_pos: int) -> void:
	if in_pos > 5 or in_pos < 1:
		return
	slf_logical_pos = in_pos * slf_unit
	slf_actual_spd = abs(slf_logical_pos - slf_actual_pos) / slf_logical_spd
	
func increment_pos(in_amnt: int) -> void:
	if (in_amnt + slf_logical_pos) > 5 or (in_amnt + slf_logical_pos) < 1:
		return
	slf_logical_pos += in_amnt * slf_unit
	slf_actual_spd = abs(slf_logical_pos - slf_actual_pos) / slf_logical_spd

func get_pos() -> Vector2:
	return slf_dir * slf_actual_pos
