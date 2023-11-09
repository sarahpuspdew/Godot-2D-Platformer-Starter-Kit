extends Node
class_name HealthComponent

signal health_changed(amount : int)
signal died

@export var MAX_HEALTH : float
var health : float


func _ready():
	health = MAX_HEALTH


func damage(attack : Attack):
	health -= attack.damage
	health_changed.emit(health)
	
	if health <= 0 :
		died.emit()
