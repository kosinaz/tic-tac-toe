extends GridContainer

func _draw():
	var grid_size = rect_size / 3  # Assuming the grid is square
	for i in range(1, 3):  # Two grid lines for a 3x3 grid
		var x = i * grid_size.x
		var y = i * grid_size.y
		draw_line(Vector2(x, 0), Vector2(x, rect_size.y), Color(0.25, 0.25, 0.25), 3)  # Vertical line
		draw_line(Vector2(0, y), Vector2(rect_size.x, y), Color(0.25, 0.25, 0.25), 3)  # Horizontal line

