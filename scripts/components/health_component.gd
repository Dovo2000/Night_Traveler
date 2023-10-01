extends Node2D

class_name HealthComponent

@export var curr_hp: float = 0.0
@export var max_hp: float = 0.0

func _ready():
	reset_hp()

func damage(attack: AttackComponent):
	curr_hp += attack.attack_damage
	if curr_hp <= 0: # Die
		get_parent().queue_free() # Clears parent node from the scene
	
func reset_hp():
	curr_hp = max_hp
