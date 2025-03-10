extends CharacterBody2D

const GRAVITY = 980  # Gravité en pixels/s²
const SPEED = 100  # Vitesse de déplacement

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta  # Applique la gravité
	move_and_slide()

# Fonction pour avancer le personnage
func move_forward():
	velocity.x = SPEED  # Applique la vitesse horizontale
	move_and_slide()  # Appliquer le mouvement
