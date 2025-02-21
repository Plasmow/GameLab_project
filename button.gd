extends Button

# Declare variables (e.g., stats, character data) here
var action_performed = false

# This function is connected to the button's "pressed" signal
func _on_ActionButton_pressed():
	action_performed = true
	# Here you can add any action you want to trigger, e.g. evolving a character
	print("Action Button Pressed!")
	# Call other functions based on your game logic (e.g., character evolution)
