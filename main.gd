extends Node2D  # The parent node for the game, holding both the UI and the character 

# Variables de stats
var happiness = 50
var strength = 50
var intelligence = 50

# Références aux nodes
@onready var character = $CharacterBody2D
@onready var character_sprite = $CharacterBody2D/CharacterSprite
@onready var button = $Control/button
@onready var reset_button: Button = $Control/reset  # Référence au bouton d'action

# Sauvegarde des positions initiales
var initial_character_position = Vector2.ZERO
var initial_button_position = Vector2.ZERO

func _ready():
	initial_character_position = character.position
	initial_button_position = 	button.position  # Sauvegarde la position initiale du bouton

# Gérer l'appui sur le bouton d'action
func _on_button_pressed():
	# Augmenter les stats
	strength += 10	
	happiness += 5
	
	# Mettre à jour la vitesse du personnage en fonction de la force
	character.update_strength(strength)	
	character.velocity.x = character.speed	

	update_stats()

# Gérer l'appui sur le bouton de réinitialisation
func _on_reset_pressed():
	# Réinitialiser les stats
	strength = 50
	happiness = 50
	
	# Réinitialiser les positions si les objets existent
	if character:
		character.position = initial_character_position
		character.velocity = Vector2.ZERO
		character.update_strength(strength)
	else:
		print("ERREUR : CharacterBody2D introuvable lors du reset !")

	if button:
		button.position = initial_button_position
	else:
		print("ERREUR : Bouton 'Button' introuvable lors du reset !")

	update_stats()


# Mettre à jour les affichages des stats
func update_stats():
	$Control/Strength.text = "Strength: " + str(strength)
	$Control/Happiness.text = "Happiness: " + str(happiness)
