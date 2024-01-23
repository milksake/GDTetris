extends CharacterBody2D

@export var horizontal_speed : float = 200.0
@export var jump_velocity : float = -400.0
@export_enum("Left:-1", "Right:1") var direction : int = -1

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var angular_velocity : float = 180.0 / (jump_velocity / gravity * -2.0)
var modify_rotation := true

@export var active := false

@onready var sprite = $Sprite2D as Sprite2D

signal died

func _physics_process(delta: float) -> void:
	if not active:
		sprite.rotation_degrees += angular_velocity * delta
		return
	
	if is_on_floor():
		if modify_rotation and not Input.is_action_pressed("ui_accept"):
			#var cast = sprite.rotation_degrees as int
			#sprite.rotation_degrees = sprite.rotation_degrees - cast + cast % 360
			var final_rotation : int = (sprite.rotation_degrees + 45.0) / 90.0
			var t = create_tween()
			t.tween_property(sprite, "rotation_degrees", final_rotation * 90, 0.1)
			modify_rotation = false
			
		if Input.is_action_pressed("ui_accept"):
			velocity.y = jump_velocity
	else:
		velocity.y += gravity * delta
		sprite.rotation_degrees += angular_velocity * delta * direction
		modify_rotation = true

	if is_on_wall():
		var change_dir := false
		for index in get_slide_collision_count():
			var collision := get_slide_collision(index)
			var collider := collision.get_collider()
			if collider.collision_layer & 4:
				change_dir = true
		
		if change_dir:
			direction *= -1
		else:
			died.emit()
	velocity.x = direction * horizontal_speed

	move_and_slide()
