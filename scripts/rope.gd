extends Node2D

onready var links = $links
var direction = Vector2.ZERO
var tip = Vector2.ZERO

const speed = 50
var flying = false
var hooked = false

func shoot(dir: Vector2):
	direction = dir.normalized()
	flying = true
	tip = self.global_position
	print(dir)

func release():
	flying = false
	hooked = false

func _process(delta):
	self.visible = flying or hooked
	if not self.visible:
		return
	var tip_loc = to_local(tip)
	links.rotation = self.position.angle_to_point(tip_loc) - deg2rad(90)
	$tip.rotation = self.position.angle_to_point(tip_loc) - deg2rad(90)
	links.position = tip_loc
	links.region_rect.size.y = tip_loc.length()

func _physics_process(delta):
	$tip.global_position = tip
	if flying:
		if $tip.move_and_collide(direction * speed):
			hooked = true
			flying = false
	tip = $tip.global_position
