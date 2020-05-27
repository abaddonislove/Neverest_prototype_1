extends Node2D


func _ready():
	var player = Global.player.instance()
	add_child(player)
	player.global_position = Vector2(0,0)
