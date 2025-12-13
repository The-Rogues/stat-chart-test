extends Node2D

@export var slf_size: float = 200.0 # Size of the square that bounds the chart.
@export var slf_crcl_thick: float = 2.0
@export var slf_point_thick: float = 5.0
@export var slf_vec_thick: float = 1.0
@export var slf_update_spd: float = 0.5

@onready var slf_crcl_1 := $CircleLayer1
@onready var slf_crcl_2 := $CircleLayer2
@onready var slf_crcl_3 := $CircleLayer3
@onready var slf_crcl_4 := $CircleLayer4
@onready var slf_crcl_5 := $CircleLayer5

@onready var slf_pnt_1 := $Point1
@onready var slf_pnt_2 := $Point2
@onready var slf_pnt_3 := $Point3

@onready var slf_vec_1 := $Vec1
@onready var slf_vec_2 := $Vec2
@onready var slf_vec_3 := $Vec3

@onready var slf_aes_1 := $AesLine1
@onready var slf_aes_2 := $AesLine2
@onready var slf_aes_3 := $AesLine3

func _ready() -> void:
	
	slf_crcl_1.init_circle(Vector2(0.0, 0.0), slf_size / 10, 0.5, slf_crcl_thick * 0.75)
	slf_crcl_2.init_circle(Vector2(0.0, 0.0), (slf_size / 10) * 2, 0.5, slf_crcl_thick * 0.75)
	slf_crcl_3.init_circle(Vector2(0.0, 0.0), (slf_size / 10) * 3, 0.5, slf_crcl_thick * 0.75)
	slf_crcl_4.init_circle(Vector2(0.0, 0.0), (slf_size / 10) * 4, 0.5, slf_crcl_thick * 0.75)
	slf_crcl_5.init_circle(Vector2(0.0, 0.0), slf_size / 2, 1.0, slf_crcl_thick)
	
	var init_angle: float = PI / 2
	var one_third: float = -1 * (2 * PI) / 3
	
	slf_pnt_1.init_point(
		slf_point_thick,
		Vector2(cos(init_angle), sin(init_angle)),
		slf_update_spd,
		slf_size / 10,
		1
	)
	slf_pnt_2.init_point(
		slf_point_thick,
		Vector2(cos(init_angle + one_third), sin(init_angle + one_third)), 
		slf_update_spd,
		slf_size / 10,
		1
	)
	slf_pnt_3.init_point(
		slf_point_thick,
		Vector2(cos(init_angle + 2 * one_third), sin(init_angle + 2 * one_third)), 
		slf_update_spd,
		slf_size / 10,
		1
	)
	
	slf_vec_1.init_vec(
		slf_vec_thick,
		1.0,
		slf_pnt_1.get_pos(),
		slf_pnt_2.get_pos()
	)
	slf_vec_2.init_vec(
		slf_vec_thick,
		1.0,
		slf_pnt_2.get_pos(),
		slf_pnt_3.get_pos()
	)
	slf_vec_3.init_vec(
		slf_vec_thick,
		1.0,
		slf_pnt_3.get_pos(),
		slf_pnt_1.get_pos()
	)
	
	slf_aes_1.init_vec(
		slf_vec_thick,
		0.75,
		Vector2(0.0, 0.0),
		Vector2(cos(init_angle), sin(init_angle)) * slf_size / 2
	)
	slf_aes_2.init_vec(
		slf_vec_thick,
		0.75,
		Vector2(0.0, 0.0),
		Vector2(cos(init_angle + one_third), sin(init_angle + one_third)) * slf_size / 2
	)
	slf_aes_3.init_vec(
		slf_vec_thick,
		0.75,
		Vector2(0.0, 0.0),
		Vector2(cos(init_angle + 2 * one_third), sin(init_angle + 2 * one_third)) * slf_size / 2
	)

func _process(delta: float) -> void:
	slf_vec_1.update_pos(slf_pnt_1.get_pos(), slf_pnt_2.get_pos())
	slf_vec_2.update_pos(slf_pnt_2.get_pos(), slf_pnt_3.get_pos())
	slf_vec_3.update_pos(slf_pnt_3.get_pos(), slf_pnt_1.get_pos())

func set_bottom_value(value: int) -> void:
	slf_pnt_1.change_pos(value)

func set_right_value(value: int) -> void:
	slf_pnt_2.change_pos(value)

func set_left_value(value: int) -> void:
	slf_pnt_3.change_pos(value)
