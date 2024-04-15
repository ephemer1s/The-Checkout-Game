extends Control

class_name ShadowButton

@onready var button = $Button
@onready var shadow = $Shadow
@onready var animation_player = $AnimationPlayer
var cur_state = State.READY
var is_hovering = false

var next_state_id

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
    setup_button("aslkdjfklajflksajfpoqwuierpoqjfklasjfdlkashjfaposuiipo", 1)

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

func setup_button(text: String, _next_state_id: int) -> void:
    button.text = text
    shadow.text = text
    next_state_id = _next_state_id

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
            Autoload.emit_transition_to(next_state_id)
            cur_state = State.HOVER
            animation_player.play("on_hover")
