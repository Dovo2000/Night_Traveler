class_name AttackComponent

@export var attack_damage: float = 0.0
@export var knockback_force: float
@export var attack_position: Vector2

func test_function():
	print("I hit an attack with" + str(attack_damage) + "damage!")
