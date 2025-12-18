# --StatChartCircle Scene Main Script--
# Author: Fletcher Green

# ------------------------------------------------------------------------------------
# Section: Declarations
# ------------------------------------------------------------------------------------
extends Node2D

var slf_pos: Vector2 # The position to draw the circle relatove to the parent.
var slf_radius: float # The radius of the circle.
var slf_alpha: float # The opacity of the circle.
var slf_thick: float # The width of the circles edge.

# ------------------------------------------------------------------------------------
# Section: Functions
# ------------------------------------------------------------------------------------

# --init_circle Function--
# Description: Initilises the circle's data member.
# in_pos: The position of the circle relative to the parent.
# in_radius: The radius of the circle provided by the parent.
# in_alpha: The opacity of the circle provided by the parent.
# in_thick: The width of the circle's edge provided by the parent.
func init_circle(in_pos: Vector2, in_radius: float, in_alpha: float, in_thick) -> void:
	slf_pos = in_pos
	slf_radius = in_radius
	slf_alpha = in_alpha
	slf_thick = in_thick

# --_draw Function--
# Description: Draws a circle with the available data members.
func _draw() -> void:
	draw_circle(
		slf_pos, 
		slf_radius, 
		Color(1.0, 1.0, 1.0, slf_alpha), 
		false, 
		slf_thick, 
		true
	)
