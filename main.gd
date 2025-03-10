extends Node2D  # The parent node for the game, holding both the UI and the character

# Variables to hold the stats
var happiness = 50
var strength = 50
var intelligence = 50

# Reference to the character sprite or animated sprite
@onready var character_sprite = $CharacterBody2D/CharacterSprite


# Get the current stats to pass to the UI
func get_stats() -> Dictionary:
	return {
		"strength": strength,
		"intelligence": intelligence,
		"happiness": happiness
	}

# Update the stats and reflect the changes in the character state
func update_stats():
	# Example of stat modification
	strength += 10	
	happiness += 5
	
	# Update the UI (Call the UI script's update_stats)
	$Control.update_stats()  # Calling the update_stats() function of the Control node
	
	# Update the character's state (animations)
	update_character_state()

# Update the character's animation based on the stats
func update_character_state():
	character_sprite.play("Walk")  # Default walking animation



# Handle the button press to modify stats
func _on_button_pressed():
	# Increase stats
	strength += 10	
	happiness += 5
	
	# Debugging
	print("Strength:", strength, "Happiness:", happiness)
	
	# Update stats in the UI and character
	update_stats()
