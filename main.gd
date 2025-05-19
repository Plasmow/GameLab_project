### Script du Node2D principal (MainUI.gd)
extends Node2D


# Stats du joueur
var happiness = 50
var strength = 50
var intelligence = 50
var hunger = 50
var stamina = 50
var animation_speed = 5.0
var has_fallen = false  # pour éviter de relancer la chute
# Références aux nodes
@onready var character = $CharacterBody2D
@onready var character_sprite = $CharacterBody2D/CharacterSprite
@onready var button = $Control/button
@onready var reset_button = $Control/reset
@onready var ui = $Control
@onready var rest_button = $Control/rest
@onready var action_buttons = [$Control/study, $Control/rest, $Control/workout, $Control/eat, $Control/button]


@onready var bed = $bed  # ton lit
@onready var bed_animation = $Environment/bed/AnimatedSprite2D
@onready var bed_sound = $Environment/bed/sleepsound
@onready var bed_marker = $Environment/bed/bed_marker

@onready var desk = $Environment/desk  # ton lit
@onready var desk_animation = $Environment/desk/AnimatedSprite2D
@onready var desk_sound = $Environment/desk/sleepsound
@onready var desk_marker = $Environment/desk/desk_marker


#gestion des musiques
@onready var ambience_music = $ambience
@onready var power_music = $power
var music_switched = false  # Pour ne pas changer en boucle
@onready var punch_sound = $PunchSound
@onready var eat_sound = $EatSound
@onready var lose_sound = $Womp



@onready var goal_marker = $GoalMarker  # Chemin du Marker2D
@onready var victory_label = $Control/VictoryLabel
var has_won = false

#gestion du saut de joie
@onready var joy_jump_marker = $joy_jump_marker

var has_jumped = false  # Pour éviter plusieurs sauts


func trigger_joy_jump():
	has_jumped = true
	character.velocity.y = -900  # force du saut, ajuste selon ta gravité
	character_sprite.play("Walk")
	# Le personnage continue de courir vers l’avant avec sa velocity.x

#clones
var direction = 1  # 1 = droite, -1 = gauche


func trigger_explosion():
	disable_action_buttons()  # Si tu as une fonction comme ça
	character_sprite.play("Explode")  # Ou AnimationPlayer si c’est une animation différente
	$explosion_sound.play()  # Facultatif si tu veux un son
	await get_tree().create_timer(1.5).timeout  # Temps pour laisser l’explosion jouer
	reset_game()


func handle_victory():
	has_won = true
	character_sprite.play("Idle")
	disable_action_buttons()
	victory_label.visible = true


func trigger_fall():
	has_fallen = true
	
	# Désactive les boutons
	for button in $Control.get_children():
		if button is Button:
			button.disabled = true

	# Optionnel : jouer une animation de chute
	character_sprite.play("Fall") 
	
	# Déplace vers le bas avec Tween (ou modifie velocity si physique utilisée)
	var tween = create_tween()
	var fall_position = character.position + Vector2(0, 300)  # chute de 300 px
	tween.tween_property(character, "position", fall_position, 1.5).set_trans(Tween.TRANS_SINE)
# Sauvegarde des positions initiales
var initial_character_position = Vector2.ZERO
var initial_button_position = Vector2.ZERO

func _ready():
	direction = 1
	print(bed_marker)  # Devrait afficher [Marker2D:...]
	print(bed_marker.global_position)  # Doit afficher un Vector2
	character_sprite.play("Idle")
	initial_character_position = character.position
	initial_button_position = button.position
	update_stats()

func update_stats():
	var stats = {
		"strength": strength,
		"happiness": happiness,
		"intelligence": intelligence,
		"hunger": hunger,
		"stamina": stamina
	}
	ui.update_stats(stats)
	check_intelligence_flip()
	# Changer la musique si la force dépasse 100
	if strength >= 100 and not music_switched:
		music_switched = true
		ambience_music.stop()
		power_music.play()
	elif strength < 100 and music_switched:
		music_switched = false
		power_music.stop()
		ambience_music.play()
	elif intelligence > 70 and stamina <30:
		trigger_explosion()
	elif stamina<19:
		character_sprite.play("Death")
		reset_game()


func _on_button_pressed():
	strength += 10
	happiness += 5
	character.update_strength(strength)
	character.velocity.x = character.speed*direction

	character_sprite.animation = "Walk"
	character_sprite.speed_scale = animation_speed
	character_sprite.play()
	animation_speed += 1.0

	update_stats()

func _on_reset_pressed():
	enable_action_buttons()
	character_sprite.play("Idle")
	strength = 50
	happiness = 50
	intelligence = 50
	hunger = 50
	stamina = 50

	if character:
		character.position = initial_character_position
		character.velocity = Vector2.ZERO
		character.update_strength(strength)
	if button:
		button.position = initial_button_position

	update_stats()

func reset_game():
	get_tree().reload_current_scene()




func check_intelligence_flip():
	if intelligence > 60 and stamina>50:
		character_sprite.flip_h = true
		direction=-1
	else:
		character_sprite.flip_h = false
		direction=1
		
func _on_study_pressed():
	disable_action_buttons()
	
	


	# 3. Déplacer progressivement le personnage (simple tween)

	var target_pos = desk_marker.global_position
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(character, "position", target_pos, 1.0)
	# 4. Attendre la fin du déplacement
	await tween.finished

	# 5. Masquer le personnage
	character.visible = false

	# 6. Jouer animation et son du lit
	desk_animation.play("study")
	desk_sound.play()

	# 7. Attendre fin animation
	await get_tree().create_timer(3.0).timeout
	desk_animation.stop()

	# 8. Réapparaître à la position initiale
	character.position = initial_character_position
	character.visible = true
	# Exemple d'action pour "Study"
	intelligence += 5
	stamina -= 5
	hunger += 2
	update_stats()
	if intelligence>80 and stamina<30 :
		trigger_explosion()
	enable_action_buttons()


# Ajoute ici les autres actions (rest, play, workout, eat...) selon le même modèle
func disable_action_buttons():
	for btn in action_buttons:
		btn.disabled = true

func enable_action_buttons():
	for button in action_buttons:
		button.disabled = false


func _on_rest_pressed():
	disable_action_buttons()
	
	


	# 3. Déplacer progressivement le personnage (simple tween)

	var target_pos = bed_marker.global_position
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(character, "position", target_pos, 1.0)
	# 4. Attendre la fin du déplacement
	await tween.finished

	# 5. Masquer le personnage
	character.visible = false

	# 6. Jouer animation et son du lit
	bed_animation.play("sleep")
	bed_sound.play()

	# 7. Attendre fin animation
	await get_tree().create_timer(3.0).timeout
	bed_animation.stop()

	# 8. Réapparaître à la position initiale
	character.position = initial_character_position
	character.visible = true

	# 9. Réactiver tous les boutons
	
	happiness += 10
	stamina += 20
	update_stats()
	enable_action_buttons()




func _on_workout_pressed():
	if character_sprite.animation != "Punch":
		disable_action_buttons()
		character_sprite.play("Punch")
	else:
		character_sprite.stop()
		character_sprite.play("Punch")  # Redémarre proprement si déjà "Punch"

	punch_sound.play()

	await character_sprite.animation_finished
	enable_action_buttons()
	strength += 5
	stamina -= 10
	hunger += 4
	update_stats()

func _on_eat_pressed():
	if character_sprite.animation != "Eat":
		disable_action_buttons()
		character_sprite.play("Eat")
	else:
		character_sprite.stop()
		character_sprite.play("Eat")  # Redémarre proprement si déjà "Punch"

	eat_sound.play()

	await character_sprite.animation_finished
	enable_action_buttons()
	hunger -= 10
	stamina += 2
	update_stats()

func _process(delta):
	if not has_won and character.global_position.x >= goal_marker.global_position.x:
		handle_victory()
	if hunger <= 0 and not has_fallen:
		trigger_fall()
	if not has_jumped and character.global_position.x >= joy_jump_marker.global_position.x and happiness > 90:
		trigger_joy_jump()
