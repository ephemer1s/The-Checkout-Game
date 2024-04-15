'''
main-menu.gd
--------------------
This file contain the codes related to the events on the MainMenu scene.
'''

extends Control
@onready var achievements_button = $VBoxContainer/BtnOptions
var game: PackedScene = preload("res://scenes/story/story.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
    Audio.play_bgm("shop")
    achievements_button.connect("pressed", on_achievement_button_pressed)

func on_achievement_button_pressed():
    var achievement_instance = load("res://scenes/main/achievement.tscn").instantiate()
    Audio.get_node("sfx_button_click").play()
    get_tree().current_scene.add_child(achievement_instance)

func _on_btn_new_game_pressed():
    if OS.is_debug_build():
        print("[DEBUG MSG] Button <New Game> Pressed!")
    Audio.get_node("sfx_button_click").play()
    get_tree().change_scene_to_packed(game)

func _on_btn_options_pressed():
    var scn_options = load("res://scenes/main/options.tscn").instantiate()
    Audio.get_node("sfx_button_click").play()
    get_tree().current_scene.add_child(scn_options)


func _on_btn_credit_pressed():
    var scn_credits = load("res://scenes/main/credits.tscn").instantiate()
    Audio.get_node("sfx_button_click").play()
    get_tree().current_scene.add_child(scn_credits)


func _on_btn_quit_game_pressed():
    Audio.get_node("sfx_button_click").play()
    get_tree().quit()


func _on_btn_new_game_mouse_entered():
    Audio.get_node("sfx_button_highlight").play()


func _on_btn_options_mouse_entered():
    Audio.get_node("sfx_button_highlight").play()


func _on_btn_credits_mouse_entered():
    Audio.get_node("sfx_button_highlight").play()


func _on_btn_quit_game_mouse_entered():
    Audio.get_node("sfx_button_highlight").play()
