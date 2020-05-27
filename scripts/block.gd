extends StaticBody2D

func _ready():
	input_pickable = true


func _on_StaticBody2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		Global.tetherpos = global_position
	#print(Global.tetherpos)
