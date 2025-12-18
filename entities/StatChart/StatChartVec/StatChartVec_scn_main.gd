# --StatChartVec Scene Main Script--
# Author: Fletcher Green

# ------------------------------------------------------------------------------------
# Section: Declarations
# ------------------------------------------------------------------------------------
extends Node2D

var slf_thick: float # The thickness of the vector.
var slf_alpha: float # The opacity of the vector.
var slf_pos_1: Vector2 # The position of the vector's first point.
var slf_pos_2: Vector2 # The position of the vector's second point.

# ------------------------------------------------------------------------------------
# Section: Functions
# ------------------------------------------------------------------------------------

# --init_vec Function--
# Description: Initialises the data members of the class.
# in_thick: Input thickness provided by the parent.
# in_alpha: Input alpha porvided by the parent.
# in_pos_1 and in_pos_2: Input positions provided by the parent.
func init_vec(
	in_thick: float,
	in_alpha: float,
	in_pos_1: Vector2,
	in_pos_2: Vector2
) -> void:
	slf_thick = in_thick
	slf_alpha = in_alpha
	slf_pos_1 = in_pos_1
	slf_pos_2 = in_pos_2

# --_draw Function--
# Description: Draws a line from the first position to the second position.
func _draw() -> void:
	draw_line(slf_pos_1, slf_pos_2, Color(1.0, 1.0, 1.0, slf_alpha), slf_thick, true)
