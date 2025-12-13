extends Node2D

var slf_pos: Vector2
var slf_radius: float
var slf_alpha: float
var slf_thick: float

func init_circle(in_pos: Vector2, in_radius: float, in_alpha: float, in_thick) -> void:
	slf_pos = in_pos
	slf_radius = in_radius
	slf_alpha = in_alpha
	slf_thick = in_thick

func _draw() -> void:
	draw_circle(
		slf_pos, 
		slf_radius, 
		Color(1.0, 1.0, 1.0, slf_alpha), 
		false, 
		slf_thick, 
		true
	)
