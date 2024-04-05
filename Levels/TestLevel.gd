extends Node2D


var mouse_position = null
var mouse_is_pressed = false
@onready var golfball = $Golfball



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				mouse_is_pressed = true
			else:
				mouse_is_pressed = false
				_shoot_golfball()
				
	if event is InputEventMouseMotion and mouse_is_pressed:
		mouse_position = get_local_mouse_position()
	else:
		mouse_position = null
		
	queue_redraw()

func _draw():
	if mouse_position != null:
		var distance = golfball.position.distance_to(mouse_position)
		var mouse_position_limited = mouse_position
		
		if distance > 100:
			var direction = (mouse_position - golfball.position).normalized()
			mouse_position_limited = golfball.position + direction * 100
		
		draw_line(golfball.position, mouse_position_limited, Color.RED, 6)
		
func _shoot_golfball():
	if mouse_position != null:
		#TODO: implement universal logic this is just a test
		golfball.apply_impulse(Vector2(mouse_position.x,mouse_position.y))
