extends TextureRect

class_name Slot

signal clicked_on


var item
var no : int
var count := -1
var is_highlighted := false setget set_highlight, get_highlight


func get_count () -> int:
	return item.get_count()


func add_item (dictionary : Dictionary) -> void:
	if not dictionary.has("item"):
		return
	
	if not dictionary.has("count"):
		return
	
	self.item = dictionary["item"]
	self.count = dictionary["count"]
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	set_texture(self.item.icon)


func remove_item () -> Dictionary:
	var temp = {
		"item" : item,
		"count" : count
	}
	
	self.item = null
	self.count = 0
	mouse_default_cursor_shape = Control.CURSOR_ARROW
	return temp


func set_highlight (highlight_mode : bool) -> void:
	is_highlighted = highlight_mode
	
	if is_highlighted:
		$Highlight.show()
	else:
		$Highlight.hide()


func get_highlight () -> bool:
	return is_highlighted


func toggle_highlight () -> void:
	set_highlight(!get_highlight())


var input_is_enabled = true


func set_input_mode (input_mode : bool) -> void:
	input_is_enabled = input_mode


func _gui_input (event):
	if input_is_enabled:
		if event is InputEventMouseButton and event.is_pressed():
			emit_signal("clicked_on")


func _ready ():
	add_to_group("Input")
	print('alive')