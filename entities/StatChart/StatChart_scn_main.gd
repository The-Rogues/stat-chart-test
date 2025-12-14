# --StatChart Scene Main Script--
# Author: Fletcher Green
# TODO: Remove hardcoded elements from StatChart scene.
# TODO: Comment children scenes.

# ------------------------------------------------------------------------------------
# Section: Declarations
# ------------------------------------------------------------------------------------
extends Node2D

# --Exported Variables--
@export var slf_size: float = 200.0 # Size of the square that bounds the chart.
@export var slf_crcl_thick: float = 2.0 # Width of circles.
@export var slf_point_thick: float = 5.0 # Width of points.
@export var slf_vec_thick: float = 1.0 # Width of aesthetic vectors and chart triangle.
@export var slf_update_spd: float = 0.5 # Speed the chart takes to move from one pos to the next.

# --Circle Child Scenes--
@onready var slf_crcl_1 := $CircleLayer1
@onready var slf_crcl_2 := $CircleLayer2
@onready var slf_crcl_3 := $CircleLayer3
@onready var slf_crcl_4 := $CircleLayer4
@onready var slf_crcl_5 := $CircleLayer5

# --Point Child Scenes--
@onready var slf_pnt_1 := $Point1
@onready var slf_pnt_2 := $Point2
@onready var slf_pnt_3 := $Point3

# --Triangle Child Scenes--
@onready var slf_tri_1 := $Tri1
@onready var slf_tri_2 := $Tri2

# --Vector Child Scenes--
@onready var slf_vec_1 := $Vec1
@onready var slf_vec_2 := $Vec2
@onready var slf_vec_3 := $Vec3

# ------------------------------------------------------------------------------------
# Section: Chart Initilization
# ------------------------------------------------------------------------------------

# --_ready Function--
# Description: When the parent node of the StatChart is ready, this function initialises
#              all of the data members used by its children.
func _ready() -> void:
	
	# All circles are centered at position (0, 0) relative to the parent.
	# The radius of the outer circle is half of the width of the square that bounds
	# the chart. Every subsequent circle's radius decreases by a constant amount.
	slf_crcl_1.init_circle(Vector2(0.0, 0.0), slf_size / 10, 0.5, slf_crcl_thick * 0.75)
	slf_crcl_2.init_circle(Vector2(0.0, 0.0), (slf_size / 10) * 2, 0.5, slf_crcl_thick * 0.75)
	slf_crcl_3.init_circle(Vector2(0.0, 0.0), (slf_size / 10) * 3, 0.5, slf_crcl_thick * 0.75)
	slf_crcl_4.init_circle(Vector2(0.0, 0.0), (slf_size / 10) * 4, 0.5, slf_crcl_thick * 0.75)
	slf_crcl_5.init_circle(Vector2(0.0, 0.0), slf_size / 2, 1.0, slf_crcl_thick)
	
	# Since the Y-axis is flipped when it comes to drawing game elements, the unit
	# circle is traversed clockwise. This means we have to travel PI / 2 to get the
	# angle of the bottom point. An angle of 2PI is the whole unit circle, so traveling
	# one third of the circle is 2PI / 3. The positions of the other two points can be
	# calculated by adding thirds to the initial point.
	var init_angle: float = PI / 2
	var one_third: float = -1 * (2 * PI) / 3
	
	# Bottom point.
	slf_pnt_1.init_point(
		slf_point_thick,
		# Normalised vector for the direction of the first point.
		Vector2(cos(init_angle), sin(init_angle)),
		slf_update_spd,
		# Unit size is the radius of the smallest circle.
		# Other outer circles increase by a constant amount.
		slf_size / 10,
		1
	)
	
	# Right point.
	slf_pnt_2.init_point(
		slf_point_thick,
		# Normalised vector for the direction of the second point.
		Vector2(cos(init_angle + one_third), sin(init_angle + one_third)), 
		slf_update_spd,
		slf_size / 10,
		1
	)
	
	# Left point.
	slf_pnt_3.init_point(
		slf_point_thick,
		# Normalised vector for the direction of the third point.
		Vector2(cos(init_angle + 2 * one_third), sin(init_angle + 2 * one_third)), 
		slf_update_spd,
		slf_size / 10,
		1
	)
	
	# Triangle outline initialised with the initial positions of the points.
	slf_tri_1.init_tri(
		slf_vec_thick,
		1.0,
		false,
		Vector2(cos(init_angle), sin(init_angle)),
		Vector2(cos(init_angle + one_third), sin(init_angle + one_third)),
		Vector2(cos(init_angle + 2 * one_third), sin(init_angle + 2 * one_third))
	)
	
	# Filled triangle initialised with the initial positions of the points.
	slf_tri_2.init_tri(
		slf_vec_thick,
		0.5,
		true,
		Vector2(cos(init_angle), sin(init_angle)),
		Vector2(cos(init_angle + one_third), sin(init_angle + one_third)),
		Vector2(cos(init_angle + 2 * one_third), sin(init_angle + 2 * one_third))
	)
	
	# Bottom aesthetic vector.
	slf_vec_1.init_vec(
		slf_vec_thick,
		0.75,
		Vector2(0.0, 0.0),
		Vector2(cos(init_angle), sin(init_angle)) * slf_size / 2
	)
	
	# Right aesthetic vector.
	slf_vec_2.init_vec(
		slf_vec_thick,
		0.75,
		Vector2(0.0, 0.0),
		Vector2(cos(init_angle + one_third), sin(init_angle + one_third)) * slf_size / 2
	)
	
	# Left aesthetic vector.
	slf_vec_3.init_vec(
		slf_vec_thick,
		0.75,
		Vector2(0.0, 0.0),
		Vector2(cos(init_angle + 2 * one_third), sin(init_angle + 2 * one_third)) * slf_size / 2
	)

# ------------------------------------------------------------------------------------
# Section: Update Chart Functions
# ------------------------------------------------------------------------------------

# --_process Function--
# Description: Updates the chart triangles so that they are always connecting the 
#              three points.
# delta: Change in time from the previous frame. Unused.
func _process(delta: float) -> void:
	slf_tri_1.update_pos(slf_pnt_1.get_pos(), slf_pnt_2.get_pos(), slf_pnt_3.get_pos())
	slf_tri_2.update_pos(slf_pnt_1.get_pos(), slf_pnt_2.get_pos(), slf_pnt_3.get_pos())

# --set_bottom_value Function--
# Description: Updates the position of the chart's bottom point.
# value: An integer between one and five that the chart will be changed to display.
func set_bottom_value(value: int) -> void:
	slf_pnt_1.change_pos(value)

# --set_right_value Function--
# Description: Updates the position of the chart's right point.
# value: An integer between one and five that the chart will be changed to display.
func set_right_value(value: int) -> void:
	slf_pnt_2.change_pos(value)

# --set_left_value Function--
# Description: Updates the position of the chart's left point.
# value: An integer between one and five that the chart will be changed to display.
func set_left_value(value: int) -> void:
	slf_pnt_3.change_pos(value)
