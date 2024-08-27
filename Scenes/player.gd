extends CharacterBody2D #extends calls the subclass CharacterBody2D

@export var speed := 500 #export means you can touch this in the inspector,
#speed is a variable that is being made and given the value 500
@export var friction := 0.0  # New variable for slowing down, can be adjusted in inspector

var momentum := Vector2.ZERO  # New variable to store momentum

# Called when the node enters the scene tree for the first time.
func _ready(): #_ready is a predefined method, this will run at the start of the game
	#position is being set for the object.
	position = Vector2(500,500)

func _process(_delta): #process is a predefined method that loops while the game runs. 
	#delta is a Godot fix for frame rate stuff, though it's not used in this script
	var direction = Input.get_vector("left", "right", "up", "down") #creating a variable named direction. 
	#calling the input setting in the script. Input.get_vector is an inbuilt function that checks the state of the input actions
	
	if direction.length() > 0: #This is like asking "Is the spaceship moving at all?" (magnitude = √(x² + y²))
		# Apply input to momentum
		momentum = momentum.lerp(direction * speed, 0.15)
		rotation = direction.angle() + PI/2 #this is like saying "Point the nose of the spaceship where it's going"
		#and + PI/2 is a special number that adjusts the rotation so the nose points forward
	else:
		# Slow down when there's no input
		momentum = momentum.lerp(Vector2.ZERO, friction)
	
	velocity = momentum #we're using momentum for velocity now instead of directly using direction * speed
	move_and_slide()#this moves our boy based on the velocity we just set
