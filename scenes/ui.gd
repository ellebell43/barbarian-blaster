class_name UI

extends MarginContainer

@export var starting_currency := 150

@onready var currency_label := $Currency

var current_currency: int:
	set(currency_in):
		current_currency = max(currency_in, 0)
		currency_label.text = "Gold: " + str(current_currency)

func _ready():
	current_currency = starting_currency
