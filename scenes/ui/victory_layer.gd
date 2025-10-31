extends CanvasLayer
@onready var star1 := %StarImage1
@onready var star2 := %StarImage2
@onready var star3 := %StarImage3
func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quite_button_pressed() -> void:
	get_tree().quit()
