extends Node

@onready var inventory = $Inventory
@onready var color_rect = $CanvasLayer/ColorRect
@onready var margin_container = $CanvasLayer/MarginContainer
@onready var item_description = $CanvasLayer/MarginContainer/HBoxContainer/ItemDescription

func _ready() -> void:
    item_description.text = ""
    inventory.connect("inventory_opened", on_inventory_opened)
    inventory.connect("inventory_closed", on_inventory_closed)
    inventory.connect("description_to_display", on_description_changed)

func on_description_changed(text: String) -> void:
    item_description.text = text

func on_inventory_opened() -> void:
    color_rect.visible = true
    margin_container.visible = true

func on_inventory_closed() -> void:
    color_rect.visible = false
    margin_container.visible = false
