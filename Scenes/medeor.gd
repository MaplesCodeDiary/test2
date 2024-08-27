# This script controls the behavior of meteors in a 2D game, including loading meteor images, 
# randomly positioning them, and handling their movement and rotation on the screen.

extends Node2D  # The script is extending Node2D, meaning it's attached to a 2D node in the Godot engine

# Declare global variables that will be used throughout the script
var meteor_images = []  # This array will hold the file paths of all meteor images
var speed = 0  # This variable will control how fast the meteor moves vertically
var direction_x = 0.0  # This will control the horizontal movement of the meteor
var rotation_speed = 0  # This controls how fast the meteor rotates as it falls

# _ready() is a built-in Godot function that runs when the node and its children are added to the scene
func _ready():
	# Step 1: Load meteor images from the specified directory

	# Create a DirAccess object to interact with the file system and open the specified directory
	var dir = DirAccess.open("res://PNG/Meteors/")
	
	# Check if the directory was successfully opened
	if dir != null:
		# Start reading the contents of the directory
		dir.list_dir_begin()
		
		# Get the first file in the directory
		var file_name = dir.get_next()
		
		# Loop through all the files in the directory until there are no more files to read
		while file_name != "":
			# Check if the file name ends with ".png", indicating it's a PNG image
			if file_name.ends_with(".png"):
				# If it's a PNG file, add its full path to the meteor_images array
				meteor_images.append("res://PNG/Meteors/" + file_name)
			
			# Move on to the next file in the directory
			file_name = dir.get_next()
		
		# End the directory listing process, which is good practice to free up resources
		dir.list_dir_end()
	
	# Step 2: Select a random meteor image and apply it to the Sprite2D node

	# Check if the meteor_images array contains any images
	if meteor_images.size() > 0:
		# If it does, select one image at random
		var random_index = randi_range(0, meteor_images.size() - 1)  # Generate a random index
		var path = meteor_images[random_index]  # Get the image path at the random index
		$Sprite2D.texture = load(path)  # Load the image as a texture and apply it to the Sprite2D node
	else:
		# If no images were found, print an error message to the console
		print("No PNG files found in directory!")

	# Step 3: Initialize the meteor's position and movement

	# Get the width of the game's viewport (the visible area of the screen)
	var width = get_viewport().get_visible_rect().size.x
	
	# Generate a random X position within the screen's width to place the meteor
	var random_x = randi_range(0, width)
	
	# Generate a random Y position slightly above the screen, so the meteor falls into view
	var random_y = randi_range(-100, -50)
	
	# Set the meteor's starting position using the random X and Y values
	position = Vector2(random_x, random_y)
	
	# Set the meteor's speed (how fast it falls) to a random value between 100 and 250
	speed = randi_range(100, 250)
	
	# Set the horizontal direction (left or right movement) to a random value between -1 and 1
	direction_x = randf_range(-1, 1)
	
	# Set the rotation speed to a random value between 40 and 50 degrees per second
	rotation_speed = randi_range(40, 50)

# _process(delta) is another built-in Godot function that runs every frame
# delta is the time elapsed since the last frame, used to make movement frame-rate independent
func _process(delta):
	# Step 4: Update the meteor's position and rotation each frame

	# Update the meteor's position by moving it downwards (and sideways slightly) based on its speed
	# We use delta to ensure the movement is smooth and consistent, regardless of the frame rate
	position += Vector2(direction_x, 1.0) * speed * delta
	
	# Rotate the meteor based on the rotation speed, giving it a spinning effect
	rotation_degrees += rotation_speed * delta

# _on_body_entered(_body: Node2D) is a custom function that is triggered when the meteor collides with another object
# This function needs to be connected to a signal in Godot, typically via the editor
func _on_body_entered(_body: Node2D) -> void:
	# Print a message to the console when the meteor collides with another object
	# This is a simple placeholder for collision handling logic
	print('owie')
