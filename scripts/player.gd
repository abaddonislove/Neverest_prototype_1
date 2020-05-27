extends KinematicBody2D

const movespeed = 10000 
const jumppower = 10000 * 3
const gravity = .2
const chain_pull = 10
var movement = Vector2.ZERO
var rope = false
var chain_velocity = Vector2.ZERO
signal death

func _process(delta):
	Global.playerpos = global_position
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("death")

func _physics_process(delta):
	var axis = get_axis()
	movement = axis * movespeed * delta
	movement = move_and_slide(movement)
	
	if $chain.hooked:
		chain_velocity = to_local($chain.tip).normalized()*chain_pull
		if chain_velocity.y > 0:
			chain_velocity.y *= 0.55
		else:
			chain_velocity.y *= 1.65
		if sign(chain_velocity.x) != sign(axis.x):
			chain_velocity.x *= 0.7
	else:
		chain_velocity = Vector2(0,0)

func get_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down"))-int(Input.is_action_pressed("ui_up"))
	return axis

func draw(playerpos,mousepos):
	var rope = Global.rope.instance()
	add_child(rope)
	#rope.global_position = playerpos + (mousepos - playerpos)*.5
	#rope.rotation = get_angle_to(mousepos)
	rope.scale.y = .1

func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed:
			$chain.shoot(get_local_mouse_position())
		else:
			$chain.release()

func _on_KinematicBody2D_death():
	$Sprite.set_modulate(Color(0,0,0,1))
	pass # Replace with function body.
