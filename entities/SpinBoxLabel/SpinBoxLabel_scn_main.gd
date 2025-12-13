extends SpinBox

@export var slf_name: String = "Name"
@export var slf_min: int = 0
@export var slf_max: int = 100

@onready var slf_lbl := $Label

func _ready() -> void:
	slf_lbl.text = slf_name
	self.max_value = slf_max
	self.min_value = slf_min
