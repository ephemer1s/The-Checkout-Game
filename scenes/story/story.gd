extends Node

@onready var inventory = $Inventory
@onready var color_rect = $CanvasLayer/ColorRect
@onready var margin_container = $CanvasLayer/MarginContainer
@onready var item_description = $CanvasLayer/MarginContainer/HBoxContainer/ItemDescription
@onready var state_machine = $StateMachine
@onready var demon = $Demon
@onready var figure = $Figure
@onready var text_box = $TextBox
@onready var animation_player = $AnimationPlayer
@onready var end_screen = $EndScreen

var parser:JSONParser = JSONParser.new()
func _ready() -> void:
    item_description.text = ""
    inventory.connect("inventory_opened", on_inventory_opened)
    inventory.connect("inventory_closed", on_inventory_closed)
    inventory.connect("description_to_display", on_description_changed)
    end_screen.visible = false

    state_machine.init(parser)

func on_description_changed(text: String) -> void:
    item_description.text = text

func on_inventory_opened() -> void:
    color_rect.visible = true
    margin_container.visible = true

func on_inventory_closed() -> void:
    color_rect.visible = false
    margin_container.visible = false
