extends Node2D

# load the scene
var meteor_scene: PackedScene = load("res://Scenes/medeor.tscn")

func _on_meteor_timer_timeout() -> void:
	var meteor = meteor_scene.instantiate()
	$Meteors.add_child(meteor)
