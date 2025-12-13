extends Node2D

@onready var slf_chart := $StatChart

func _on_spin_box_label_1_value_changed(value: float) -> void:
	slf_chart.set_bottom_value(value)

func _on_spin_box_label_2_value_changed(value: float) -> void:
	slf_chart.set_right_value(value)

func _on_spin_box_label_3_value_changed(value: float) -> void:
	slf_chart.set_left_value(value)
