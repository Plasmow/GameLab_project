extends Control

# Variables to hold the stats
var strength = 54
var intelligence = 50
var happiness = 50

# On ready, update the labels to show initial values
func _ready():
	update_stats()

# Function to update the label text with current stats
func update_stats():
	$Strength.text = "Strength: " + str(strength)
	$Intelligence.text = "Intelligence: " + str(intelligence)
	$Happiness.text = "Happiness: " + str(happiness)

# Action for the Eat Button
func _on_EatButton_pressed():
	strength += 10
	happiness += 5
	update_stats()

# Action for the Sleep Button
func _on_SleepButton_pressed():
	intelligence += 10
	happiness += 5
	update_stats()

# Action for the Exercise Button
func _on_ExerciseButton_pressed():
	strength += 15
	happiness += 10
	update_stats()


func _on_button_pressed():
	strength = 10	
	happiness += 5
	update_stats()
