extends Control  # The UI container

# Declare your variables properly within the class
var strength_label
var intelligence_label
var happiness_label
var game_script

# On ready, initialize the references and update stats
func _ready():
	# Assign the references to the UI elements
	strength_label = $Strength
	intelligence_label = $Intelligence
	happiness_label = $Happiness
	
	# Get the parent (Node2D) and reference the game script
	game_script = get_parent()  # Assuming the parent is Node2D, which holds the main game script
	
	# Update stats initially
	update_stats()

# Function to update the label text with current stats
func update_stats():
	var stats = game_script.get_stats()  # Fetch stats from the parent (Node2D script)
	strength_label.text = "Strength: " + str(stats["strength"])
	intelligence_label.text = "Intelligence: " + str(stats["intelligence"])
	happiness_label.text = "Happiness: " + str(stats["happiness"])
