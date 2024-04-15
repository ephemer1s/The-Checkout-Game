extends CanvasLayer

@onready var achievement_1 = $MarginContainerLeft/MarginContainer/VBoxContainer/A1
@onready var achievement_2 = $MarginContainerLeft/MarginContainer/VBoxContainer/A2
@onready var achievement_3 = $MarginContainerLeft/MarginContainer/VBoxContainer/A3
@onready var achievement_4 = $MarginContainerLeft/MarginContainer/VBoxContainer/A4
@onready var achievement_5 = $MarginContainerRight/MarginContainer/VBoxContainer/A5
@onready var achievement_6 = $MarginContainerRight/MarginContainer/VBoxContainer/A6
@onready var achievement_7 = $MarginContainerRight/MarginContainer/VBoxContainer/A7

@onready var back_button = $MarginContainerRight/BackButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    back_button.connect("pressed", on_button_pressed)
    back_button.connect("mouse_entered", on_mouse_entered)
    achievement_1.set_achievement("hidden")
    achievement_2.set_achievement("hidden")
    achievement_3.set_achievement("hidden")
    achievement_4.set_achievement("hidden")
    achievement_5.set_achievement("hidden")
    achievement_6.set_achievement("hidden")
    achievement_7.set_achievement("hidden")
    display_achievements()

func on_button_pressed():
    Audio.get_node("sfx_button_click").play()
    get_tree().change_scene_to_file("res://scenes/main/main-menu.tscn")
    queue_free()

func on_mouse_entered():
    Audio.get_node("sfx_button_highlight").play()

func display_achievements():
    if "summoning" in Autoload.endings:
        achievement_1.set_achievement("summoning")
    if "bodiless" in Autoload.endings:
        achievement_2.set_achievement("bodiless")
    if "soulless" in Autoload.endings:
        achievement_3.set_achievement("soulless")
    if "nameless" in Autoload.endings:
        achievement_4.set_achievement("nameless")
    if "depleted" in Autoload.endings:
        achievement_5.set_achievement("depleted")
    if "mindless" in Autoload.endings:
        achievement_6.set_achievement("mindless")
    if "ignorant" in Autoload.endings:
        achievement_7.set_achievement("ignorant")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
