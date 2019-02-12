extends CanvasLayer

func _ready():
	initialize(get_parent().get_node("YSort/Player"))

func initialize(player):
	$PlayerGUI.initialize(player.get_stats_node())

