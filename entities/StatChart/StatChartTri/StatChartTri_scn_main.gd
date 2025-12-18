# --StatChartTri Scene Main Script--
# Author: Fletcher Green

# ------------------------------------------------------------------------------------
# Section: Declarations
# ------------------------------------------------------------------------------------
extends Node2D

var slf_thick: float # Triangle edge width.
var slf_alpha: float # Triangle opacity.
var slf_filled: bool # Bool that tells if the triangle is a filled variant.
var slf_pos_1: Vector2 # First vertex of the triangle.
var slf_pos_2: Vector2 # Second vertex of the triangle.
var slf_pos_3: Vector2 # Third vertex of the triangle.

# ------------------------------------------------------------------------------------
# Section: Functions
# ------------------------------------------------------------------------------------

# --init_tri Function--
# Description: Initilises the data members of the triangle.
# in_thick: The thickness of the triangle supplied by the parent.
# in_alpha: The opacity of the triangle supplied by the parent.
# in_filled: Boolean that tells if the riangle is filled supplied by the parent.
# in_pos_1, ...2, ...3: The positions of the verticies of the triangle supplied by the parent.
func init_tri(
	in_thick: float,
	in_alpha: float,
	in_filled: bool,
	in_pos_1: Vector2,
	in_pos_2: Vector2,
	in_pos_3: Vector2
) -> void:
	slf_thick = in_thick
	slf_alpha = in_alpha
	slf_filled = in_filled
	slf_pos_1 = in_pos_1
	slf_pos_2 = in_pos_2
	slf_pos_3 = in_pos_3

# --_draw Function--
# Descriptions: Draws the specified triangle.
func _draw() -> void:
	if slf_filled:
		# This path is taken if the triangle is filled.
		draw_polygon(
			[slf_pos_1, slf_pos_2, slf_pos_3], 
			[Color(0.2235, 1.0, 0.0784, slf_alpha)]
		)
	else:
		# This path is taken if the triangle is not filled.
		draw_polyline(
			[slf_pos_1, slf_pos_2, slf_pos_3, slf_pos_1],
			Color(1.0, 1.0, 1.0, slf_alpha),
			slf_thick,
			true
		)

# --update_pos Function--
# Descripition: Updates the position data members of the class and redraws the triangle.
# in_pos_1, ...2, ...3: The positions of the triangle to be redrawn.
func update_pos(in_pos_1: Vector2, in_pos_2: Vector2, in_pos_3: Vector2) -> void:
	slf_pos_1 = in_pos_1
	slf_pos_2 = in_pos_2
	slf_pos_3 = in_pos_3
	queue_redraw() # Redraw the triangle using the draw function.
