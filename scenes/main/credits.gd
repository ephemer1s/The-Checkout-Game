extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_btn_back_pressed():
    #get_tree().current_scene.get_parent().remove_child(get_tree().current_scene)
    Audio.get_node("sfx_button_click").play()
    get_tree().change_scene_to_file("res://scenes/main/main-menu.tscn")


func _on_btn_back_mouse_entered():
    Audio.get_node("sfx_button_highlight").play()
