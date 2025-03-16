extends Control

var strength = 50
var happiness = 50
var intelligence = 50

@onready var character = $"../CharacterBody2D"  # Adjust path if necessary

func _ready():
	update_stats()

func update_stats():
	$Strength.text = "Strength: " + str(strength)
	$Happiness.text = "Happiness: " + str(happiness)
	$Intelligence.text = "Intelligence: " + str(intelligence)

func _on_button_pressed():
	character.velocity.x = character.speed  # Déclencher le mouvement en fonction de la force

func _on_reset_button_pressed():
	# Reset all stats
	strength = 50
	happiness = 50
	intelligence = 50
	update_stats()
	
	# Reset character position
	character.position = Vector2(100, 100)  # Change to your starting position
	character.strength = strength  # Reset speed
