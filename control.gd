### Script du node Control (UI uniquement)
extends Control

func update_stats(stats: Dictionary):
	$Strength.text = "Strength: " + str(stats.strength)
	$Happiness.text = "Happiness: " + str(stats.happiness)
	$Intelligence.text = "Intelligence: " + str(stats.intelligence)
	$Hunger.text = "Hunger: " + str(stats.hunger)
	$Stamina.text = "Stamina: " + str(stats.stamina)
