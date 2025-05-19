extends Button  # Attach this to your Button node

var dragging = false
var offset = Vector2.ZERO

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true
			offset = get_global_mouse_position() - global_position
		elif not event.pressed:
			dragging = false

func _process(delta):
	if dragging:
		var mouse_y = get_global_mouse_position().y - offset.y
		global_position.y = mouse_y  # On ne modifie que Y
