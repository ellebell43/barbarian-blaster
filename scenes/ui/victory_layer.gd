extends CanvasLayer

@onready var star1 := %StarImage1
@onready var star2 := %StarImage2
@onready var star3 := %StarImage3

@onready var health_label := %MaxHealth
@onready var currency_label := %CurrencyLeft

@onready var base: PlayerBase = get_tree().get_first_node_in_group("base")
@onready var ui: UI = get_tree().get_first_node_in_group("ui")

func victory() -> void:
	visible = true
	if base.max_health <= base.current_health:
		star2.modulate = Color.WHITE
		health_label.visible = true
	if ui.current_currency >= 500:
		star3.modulate = Color.WHITE
		currency_label.visible = true

func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quite_button_pressed() -> void:
	get_tree().quit()
