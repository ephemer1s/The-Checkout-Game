'''
main-menu.gd
--------------------
This file contain the codes related to the events on the MainMenu scene.
'''

extends Control

var game: PackedScene = preload("res://scenes/story/story.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
    Audio.play_bgm("shop")
    #$VBoxContainer/BtnNewGame.grab_focus()
    #Audio.stream = load("res://assets/sfx/shop_bgm.mp3")
    #Audio.play()
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


#func start_game():
    #get_tree().change_scene_to_packed(game)


func _on_btn_new_game_pressed():
    if OS.is_debug_build():
        print("[DEBUG MSG] Button <New Game> Pressed!")
    Audio.get_node("sfx_button_click").play()
    #call_deferred("start_game")
    get_tree().change_scene_to_packed(game)
    pass


func _on_btn_options_pressed():
    var scn_options = load("res://scenes/main/options.tscn").instantiate()
    Audio.get_node("sfx_button_click").play()
    get_tree().current_scene.add_child(scn_options)
    pass


func _on_btn_credit_pressed():
    var scn_credits = load("res://scenes/main/credits.tscn").instantiate()
    Audio.get_node("sfx_button_click").play()
    get_tree().current_scene.add_child(scn_credits)
    pass


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
