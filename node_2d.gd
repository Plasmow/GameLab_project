extends Node2D

@onready var character = $Character

# Dictionary storing evolution images based on choices
var evolution_states = {
	"eat": "res://assets/images/strong_character.png",
	"study": "res://assets/images/nerd_character.png",
	"play": "res://assets/images/happy_character.png"
}

func evolve(action):
	if action in evolution_states:
		character.texture = load(evolution_states[action])
