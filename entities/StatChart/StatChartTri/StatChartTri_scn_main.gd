extends Node2D

var slf_thick: float
var slf_alpha: float
var slf_filled: bool
var slf_pos_1: Vector2
var slf_pos_2: Vector2
var slf_pos_3: Vector2

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

func _draw() -> void:
	if slf_filled:
		draw_polygon(
			[slf_pos_1, slf_pos_2, slf_pos_3], 
			[Color(0.2235, 1.0, 0.0784, slf_alpha)]
		)
	else:
		draw_polyline(
			[slf_pos_1, slf_pos_2, slf_pos_3, slf_pos_1],
			Color(1.0, 1.0, 1.0, slf_alpha),
			slf_thick,
			true
		)

func update_pos(in_pos_1: Vector2, in_pos_2: Vector2, in_pos_3: Vector2) -> void:
	slf_pos_1 = in_pos_1
	slf_pos_2 = in_pos_2
	slf_pos_3 = in_pos_3
	queue_redraw()
