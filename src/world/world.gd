extends YSort

var player : KinematicBody2D = null

func move_up () -> void:
	assert(player)
	player.move(Vector2(0, -1))


func move_down () -> void:
	assert(player)
	player.move(Vector2(0, 1))


func move_left () -> void:
	assert(player)
	player.move(Vector2(-1, 0))


func move_right () -> void:
	assert(player)
	player.move(Vector2(1, 0))


var can_use_item := false


func _on_ToolTimer_timeout():
	can_use_item = true


func use_item () -> void:
	if can_use_item:
		can_use_item = false
		assert(get_node("ToolTimer"))
		get_node("ToolTimer").start()
		emit_signal("use_item")

signal use_item


var action_key_array = [
	["move_up", funcref(self, "move_up")],
	["move_down", funcref(self, "move_down")],
	["move_left", funcref(self, "move_left")],
	["move_right", funcref(self, "move_right")],
	["use_item", funcref(self, "use_item")]
]


var input_is_enabled := true


func set_input_mode (input_mode : bool) -> void:
	input_is_enabled = input_mode


func process_input () -> void:
	for action_pair in action_key_array:
		var action_name : String = action_pair[0]
		var action_func = action_pair[1]
		
		if Input.is_action_pressed(action_name):
			action_func.call_func()


func kill_flower (flower_name : String):
	get_node(flower_name).queue_free()


func add_object (object) -> void:
	add_child(object)


func add_flower (flower : Flower) -> void:
	add_object(flower)
	flower.connect("kill", self, "kill_flower")


func _process (delta):
	if input_is_enabled:
		process_input()


func _ready ():
	add_to_group("Input")
	
	if get_node("Player"):
		player = get_node("Player")