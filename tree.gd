extends Node2D

@onready var tree_sprite = $tree_sprite
@onready var anim = $AnimationPlayer

var is_grown = false
var is_fallen = false

func grow():
	if not is_grown:
		is_grown = true
		tree_sprite.visible = true
		anim.play("grow_tree")

func fall():
	if is_grown and not is_fallen:
		is_fallen = true
		anim.play("fall_tree")
		await anim.animation_finished
		# À la fin, l'arbre est couché (pas besoin de switch de sprite)
