extends CanvasLayer

@onready var end = $End
@onready var true_end = $TrueEnd
@onready var animation_player = $AnimationPlayer
@onready var achievement_box = $AchievementBox

var menu: PackedScene = preload("res://scenes/main/main-menu.tscn")
var can_quit = false

func _ready() -> void:
    end.visible = false
    true_end.visible = false
    play_end("soulless")

func play_end(end_name: String) -> void:
    achievement_box.set_achievement(end_name)
    if end_name == "summoning":
        true_end.visible = true
        true_end.play("default")
        await true_end.animation_finished
        true_end.play("repeat")
    else:
        end.visible = true
        end.play(end_name)
    animation_player.play("show_achivement")
    await get_tree().create_timer(4).timeout
    animation_player.play("hide_achivement")
    await animation_player.animation_finished
    can_quit = true

func _process(delta: float) -> void:
    if can_quit and (Input.is_action_just_pressed("confirm") || Input.is_action_just_pressed("keyboard_confirm")) || Input.is_action_just_pressed("esc"):
        animation_player.play("fade_out")
        await animation_player.animation_finished
        get_tree().change_scene_to_packed(menu)
