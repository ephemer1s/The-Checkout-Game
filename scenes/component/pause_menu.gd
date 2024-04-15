extends Control

var is_paused = false:
    set(value):
        is_paused = value
        get_tree().paused = is_paused
        visible = is_paused

func _unhandled_input(event):
    if event.is_action_pressed("pause"):
        #get_tree().paused = !get_tree().paused
        #visible = !visible
        Audio.get_node("sfx_button_click").play()
        self.is_paused = !is_paused

func _on_resume_pressed():
    print("resume")
    #get_tree().paused = false
    #visible = false
    Audio.get_node("sfx_button_click").play()
    
    self.is_paused = false

func _on_main_menu_pressed():
    print("return to menu")
    Audio.get_node("sfx_button_click").play()
    
    get_tree().paused = false
    get_tree().change_scene_to_file("res://scenes/main/main-menu.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_resume_mouse_entered():
    Audio.get_node("sfx_button_highlight").play()
    pass # Replace with function body.


func _on_main_menu_mouse_entered():
    Audio.get_node("sfx_button_highlight").play()
    pass # Replace with function body.
