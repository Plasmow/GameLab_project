extends CharacterBody2D

var strength = 50  # Stat de force qui influencera la vitesse
var speed = strength * 2  # La vitesse dépend de la force
var gravity = 980  # Gravité appliquée au personnage

func _physics_process(delta):
	velocity.y += gravity * delta  # Appliquer la gravité
	move_and_slide()  # Déplacement du personnage

func update_strength(new_strength):
	strength = new_strength
	speed = strength * 2  # Met à jour la vitesse en fonction de la force
