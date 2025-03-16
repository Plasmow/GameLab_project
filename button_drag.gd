extends Button  # Attach this to your Button node

var dragging = false
var offset = Vector2.ZERO

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true
			offset = get_global_mouse_position() - global_position  # Store initial offset
		elif not event.pressed:
			dragging = false  # Stop dragging when mouse is released

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position() - offset
