extends Node2D

var slf_thick: float
var slf_alpha: float
var slf_pos_1: Vector2
var slf_pos_2: Vector2

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

func _draw() -> void:
	draw_line(slf_pos_1, slf_pos_2, Color(1.0, 1.0, 1.0, slf_alpha), slf_thick, true)
