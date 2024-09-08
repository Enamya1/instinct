extends Node2D

@export var map_width: int = 100
@export var map_height: int = 100



@onready var tile_map: TileMap = $TileMap


@onready var mobe = preload("res://scene/character_body_2d.tscn")




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_noise_map()
	for i in range(5):
		var thing = mobe.instantiate()  
		thing.position.x = i+10 * 10
		add_child(thing) 
		
	#var random_x = randi_range(-screen_size.x,screen_size.x)
	#var random_y = randi_range(-screen_size.y,screen_size.y)
	#fill_map_with_random_tiles
	
	
	


func generate_noise_map():
	for x in range(map_width):
		for y in range(map_height):
			# Set the tile with all parameters
			var coords = Vector2i(x, y)
			var layer = 0
			var source_id = 0 # Or use a specific source_id from your TileSet
			var atlas_coords = Vector2i(randi_range(0,5),randi_range(0,5)) # Use the default if not using an atlas
			var alternative_tile = 0 # Default alternative tile in	
			tile_map.set_cell(layer, coords, source_id, atlas_coords, alternative_tile)	
	
