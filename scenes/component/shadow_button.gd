extends Control

class_name ShadowButton

@onready var button = $Button
@onready var shadow = $Shadow
@onready var animation_player = $AnimationPlayer
var cur_state = State.READY
var is_hovering = false

var next_state_id
var money_action = ""

var demonic = preload("res://assets/fonts/Demon-Regular.ttf")
var normal = preload("res://assets/fonts/SueEllenFrancisco-Regular.ttf")

var demonic_color = Color(1, 0.78, 0)
var normal_color = Color(0, 0, 0)
enum State {
    READY,
    HOVER,
    PRESSED
}

func _ready() -> void:
    shadow.disabled = true
    shadow.visible = false
    button.connect("mouse_entered", on_mouse_entered)
    button.connect("mouse_exited", on_mouse_exited)

func on_mouse_entered() -> void:
    shadow.visible = true
    is_hovering = true
    if cur_state == State.READY:
        animation_player.play("on_hover")
        cur_state = State.HOVER

func on_mouse_exited() -> void:
    is_hovering = false
    if cur_state == State.HOVER:
        animation_player.play("on_leave")
        shadow.visible = false
        cur_state = State.READY

func setup_button(text: String, _next_state_id: int, _money_action: String) -> void:
    if text[0] == "[":
        button.add_theme_font_override("font", demonic)
        button.add_theme_color_override("font_color", demonic_color)
        button.add_theme_color_override("font_hover_color", demonic_color)
        button.add_theme_color_override("font_hover_pressed_color", demonic_color)
        button.add_theme_color_override("font_pressed_color", demonic_color)
        button.add_theme_color_override("font_focus_color", demonic_color)
        shadow.add_theme_font_override("font", demonic)
    else:
        button.add_theme_font_override("font", normal)
        button.add_theme_color_override("font_color", normal_color)
        button.add_theme_color_override("font_hover_color", normal_color)
        button.add_theme_color_override("font_hover_pressed_color", normal_color)
        button.add_theme_color_override("font_pressed_color", normal_color)
        button.add_theme_color_override("font_focus_color", normal_color)
        shadow.add_theme_font_override("font", normal)
    text = text.replace("[", "").replace("]", "")
    button.text = text
    shadow.text = text
    next_state_id = _next_state_id
    money_action = _money_action

func _process(delta: float) -> void:
    if cur_state == State.HOVER and Input.is_action_just_pressed("confirm"):
        animation_player.play("on_click")
        cur_state = State.PRESSED
    elif cur_state == State.PRESSED and Input.is_action_just_released("confirm"):
        animation_player.play("on_release")
        if !is_hovering:
            shadow.visible = false
            cur_state = State.READY
        else:
            Autoload.emit_transition_to(next_state_id, money_action)
            cur_state = State.HOVER
            animation_player.play("on_hover")
