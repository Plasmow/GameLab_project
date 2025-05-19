extends CharacterBody2D

@onready var tilemap = $"../TileMap"  # Vérifie le chemin correct vers ton TileMap
@onready var win_label = $"VictoryLabel"
@onready var lose_sound = $"../Womp"




var strength = 50  # Stat de force qui influencera la vitesse
var speed = strength * 2  # La vitesse dépend de la force
var gravity = 980  # Gravité appliquée au personnage

func _physics_process(delta):
	velocity.y += gravity * delta  # Appliquer la gravité
	move_and_slide()

	# Récupérer la taille du viewport
	var screen_size = get_viewport_rect().size  

	# Vérifier si le personnage sort des bords
	if global_position.x < 0:
		global_position.x = screen_size.x-30
	
	if global_position.y > 200:  # Ajuste selon la hauteur de ton niveau
		set_process(false)  # Arrête les mouvements
		await get_tree().create_timer(2.0).timeout
		get_tree().reload_current_scene()
		lose_sound.play()
	if global_position.x > screen_size.x:  # remplace par une vraie valeur
		set_process(false)
	
	print("X=y:", global_position.y, "Screen width:", screen_size.y)



	# Vérifier les collisions
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()



func update_strength(new_strength):
	strength = new_strength
	speed = strength * 2  # Met à jour la vitesse en fonction de la force
