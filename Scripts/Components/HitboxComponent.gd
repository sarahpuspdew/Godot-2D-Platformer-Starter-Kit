extends Area2D
class_name HitboxComponent

@export var damage : float
@export var knockback_force : float
@export var attack_position : Vector2


func _on_area_entered(area):
	if area is HurtboxComponent:
		var hurtbox : HurtboxComponent = area
		
		var attack = Attack.new()
		attack.damage = damage
		attack.knockback_force = knockback_force
		attack.attack_position = attack_position
		
		hurtbox.damage(attack)
		
		print(hurtbox)
