extends ItemList

var _data := {}
var _started := false
var _marker := "[resource]"
var _drag := -1

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				_drag = get_item_at_position(event.global_position, true)
			else:
				move_item(_drag, get_item_at_position(event.global_position, true))

func _onUp():
	if not is_anything_selected():
		return
	var index = get_selected_items()[0]
	if index > 0:
		move_item(index, index - 1)

func _onDown():
	if not is_anything_selected():
		return
	var index = get_selected_items()[0]
	if index < get_item_count():
		move_item(index, index + 1)

func _onSave():
	pass

func _ready():
	var file = File.new()
	if file.open("res://test.txt", File.READ) == OK:
		while not file.eof_reached():
			var line = file.get_line()
			if not _started:
				if line == _marker:
					_started = true
				continue
			var s = line.split("/")
			var x = line.split("\"")
			if x.size() > 1:
				_data[s[0]] = x[1]
	for key in _data:
		add_item(key + " " + _data[key])
