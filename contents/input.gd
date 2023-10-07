extends Panel
# Define the control for the text editing area
onready var editor = $"text editor area"
# Define the control for the menu bar
onready var menu_bar = $"menu buttons"
onready var open_dialog = $"open file"
onready var save_dialogue = $"save"

# Variable to store the current working directory
var current_directory = "."

func _ready():
	createMenuButtons()

# Create menu buttons and add them to the menu bar
func createMenuButtons():
	var btn_new = Button.new()
	btn_new.text = "New"
	btn_new.connect("pressed", self, "_on_new_file")
	btn_new.rect_min_size = Vector2(80, 30)

	var btn_open = Button.new()
	btn_open.text = "Open"
	btn_open.connect("pressed", self, "_on_open_file")
	btn_open.rect_min_size = Vector2(80, 30)

	var btn_save = Button.new()
	btn_save.text = "Save"
	btn_save.connect("pressed", self, "_on_save_file")
	btn_save.rect_min_size = Vector2(80, 30)

	var btn_syntax = Button.new()
	btn_syntax.text = "Toggle Basic Syntax"
	btn_syntax.connect("pressed", self, "_on_syntax")
	btn_syntax.rect_min_size = Vector2(120, 30)

	var h_box_container = HBoxContainer.new()
	h_box_container.add_child(btn_new)
	h_box_container.add_child(btn_open)
	h_box_container.add_child(btn_save)
	h_box_container.add_child(btn_syntax)

	menu_bar.add_child(h_box_container)

# Create a new file
func _on_new_file():
	editor.text = ""
	editor.clear_undo_history()

# Open a file and load its content into the text editor
func _on_open_file():
	open_dialog.set_current_dir(current_directory)  # Set the initial directory path
	open_dialog.popup_centered()
	open_dialog.connect("file_selected", self, "_load_file_content")

# Load file content into the text editor
func _load_file_content(path):
	current_directory = open_dialog.get_current_dir()  # Update the current directory
	var file = File.new()
	if file.open(path, File.READ) == OK:
		editor.text = file.get_as_text()
		file.close()

# Save the content of the text editor to a file
func _on_save_file():
	save_dialogue.set_current_dir(current_directory)  # Set the initial directory path
	save_dialogue.popup_centered()
	save_dialogue.connect("file_selected", self, "_save_file_content")

# Save the content of the text editor to a file
func _save_file_content(path):
	current_directory = save_dialogue.get_current_dir()  # Update the current directory
	var file = File.new()
	if file.open(path, File.WRITE) == OK:
		file.store_string(editor.text)
		file.close()

# Toggle basic syntax highlighting
func _on_syntax():
	editor.syntax_highlighting = !editor.syntax_highlighting
