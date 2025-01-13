extends Node

func _ready():
	var window = JavaScript.get_interface("window")
	if window:
		window.onChange()
