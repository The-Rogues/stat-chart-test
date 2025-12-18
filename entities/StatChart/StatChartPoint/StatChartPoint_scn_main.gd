# --StatChartPoint Scene Main Script--
# Author: Fletcher Green

# ------------------------------------------------------------------------------------
# Section: Declarations
# ------------------------------------------------------------------------------------
extends Node2D

var slf_radius: float # The radius of the point.
var slf_dir: Vector2 # The direction the point travels.
var slf_actual_spd: float # The speed the point is currently traveling.
var slf_logical_spd: float # The speed it takes the chart to travel between every two points.
var slf_unit: float # The size of a distance unit.
var slf_actual_pos: float # The actual position the point is at of the chart.
var slf_logical_pos: float # The value that the point represents, even if it is currently moving.

# ------------------------------------------------------------------------------------
# Section: Functions
# ------------------------------------------------------------------------------------

# --init_point Function--
# Description: Initialises a point with information from its parent.
# in_radius: The radius of the point as given by the parent.
# in_dir: The direction of the point as given by the parent.
# in_spd: The speed of the point as given by the parent.
# in_unit: The unit size as given by the parent.
# in_pos: The starting position of the point as given by the parent.
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

# --_draw Function--
# Description: Draws a solid point.
func _draw() -> void:
	draw_circle(
		Vector2(0.0, 0.0), 
		slf_radius, 
		Color(1.0, 1.0, 1.0, 1.0), 
		true
	)

# --_process Function--
# Description: If the actual and logical positions are not equal, this function calculates
#              how far the point should move to eventually reach the logical position.
# Delta: The time elapsed since the last process function call.
func _process(delta: float) -> void:
	# Check if the actual and logical positions are equal.
	if is_equal_approx(slf_actual_pos, slf_logical_pos):
		return
	
	# Calculate the direction the point needs to move based to get to the logical position.
	var sign: int = 1
	if slf_actual_pos > slf_logical_pos:
		sign = -1
	
	# Update the actual position of the point based on the speed it is moving
	# and the time that has elapsed.
	slf_actual_pos += sign * slf_actual_spd * delta
	
	# Check if the point has traveled past the logical position. Change it to the logical
	# position if it has.
	if slf_actual_pos > slf_logical_pos && sign == 1:
		slf_actual_pos = slf_logical_pos
		set_position(slf_dir * slf_actual_pos)
		return
	elif slf_actual_pos < slf_logical_pos && sign == -1:
		slf_actual_pos = slf_logical_pos
		set_position(slf_dir * slf_actual_pos)
		return
	
	# Move the point visually in its specified direction.
	translate(slf_dir * sign * slf_actual_spd * delta)

# --change_pos Function--
# Description: Updates the point's logical position and calculates the actual speed
#              needed to travel there.
# in_pos: The position to set the logical position to.
# Logic: When logical position is changed, we need to calculate the speed it 
#        takes to get to the logical position from the actual position.
#        We have distance, and we know the time we want to take to travel the distance.
#        Therefore, the speed will be abs(logical position - actual pos) / time
func change_pos(in_pos: int) -> void:
	if in_pos > 5 or in_pos < 1:
		return
	slf_logical_pos = in_pos * slf_unit
	slf_actual_spd = abs(slf_logical_pos - slf_actual_pos) / slf_logical_spd

# --increment_pos Function--
# Description: Increments the logical position of the point relative to its existing
#              position.
func increment_pos(in_amnt: int) -> void:
	if (in_amnt + slf_logical_pos) > 5 or (in_amnt + slf_logical_pos) < 1:
		return
	slf_logical_pos += in_amnt * slf_unit
	slf_actual_spd = abs(slf_logical_pos - slf_actual_pos) / slf_logical_spd

# --get_pos Function--
# Description: Returns the actual position of the point so that a triangle can be drawn
#              by the parent.
# Return: The actual position of the point.
func get_pos() -> Vector2:
	return slf_dir * slf_actual_pos
