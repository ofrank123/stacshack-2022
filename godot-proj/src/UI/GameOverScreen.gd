extends CanvasLayer

onready var title = $PanelContainer/MarginContainer/VBoxContainer/Label

func set_title(win:bool):
	if win:
		title.text = "YOU WIN!"
		title.modulate = Color.green
	else:
		title.text = "YOU LOSE!"
		title.modulate = Color.red

func _on_QuitBtn_pressed() -> void:
	get_tree().quit()
