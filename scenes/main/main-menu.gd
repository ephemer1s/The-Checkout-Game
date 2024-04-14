'''
main-menu.gd
--------------------
This file contain the codes related to the events on the MainMenu scene.
'''

extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
    $VBoxContainer/BtnNewGame.grab_focus()
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_btn_new_game_pressed():
    if OS.is_debug_build():
        print("[DEBUG MSG] Button <New Game> Pressed!")
    get_tree().change_scene_to_file("res://scenes/story/story.tscn")
    pass


func _on_btn_options_pressed():
    var scn_options = load("res://scenes/main/options.tscn").instantiate()
    get_tree().current_scene.add_child(scn_options)
    pass


func _on_btn_credit_pressed():
    var scn_credits = load("res://scenes/main/credits.tscn").instantiate()
    get_tree().current_scene.add_child(scn_credits)
    pass


func _on_btn_quit_game_pressed():
    get_tree().quit()
