extends Node

signal text_finished

const TEXT_READ_RATE: float = 0.02
var current_state: TextBoxState = TextBoxState.READY
var text_queue = []
var cur_tween: Tween
var hovering = false
@onready var textbox_container = $TextboxContainer
@onready var margin_container = $TextboxContainer/MarginContainer
@onready var end_label = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var text_label = $TextboxContainer/MarginContainer/HBoxContainer/Text
@onready var end_animation = $TextboxContainer/MarginContainer/HBoxContainer/EndAnimation

enum TextBoxState {
    READY,
    READING,
    FINISHED
}

func ready_text_box():
    current_state = TextBoxState.READY

func queue_text(next_text):
    text_queue.push_back(next_text)

func _ready():
    margin_container.connect("mouse_entered", on_mouse_entered)
    margin_container.connect("mouse_exited", on_mouse_exited)


func on_mouse_entered() -> void:
    hovering = true

func on_mouse_exited() -> void:
    hovering = false

func _process(delta: float) -> void:
    match current_state:
        TextBoxState.READY:
            print("here")
            if end_animation.is_playing():
                end_animation.stop()
            print("here1")
            if !text_queue.is_empty():
                print("here2")
                display_text()
        TextBoxState.READING:
            if end_animation.is_playing():
                end_animation.stop()
            if (hovering and Input.is_action_just_pressed("confirm")) or Input.is_action_just_pressed("keyboard_confirm"):
                text_label.visible_ratio = 1.0
                if cur_tween:
                    cur_tween.kill()
                change_state(TextBoxState.FINISHED)
                on_tween_completed()
        TextBoxState.FINISHED:
            if (hovering and Input.is_action_just_pressed("confirm")) or Input.is_action_just_pressed("keyboard_confirm"):
                change_state(TextBoxState.READY)


func clear_textbox() -> void:
    text_label.text = ""
    end_label.visible = false

func hide_textbox() -> void:
    clear_textbox()
    textbox_container.hide()

func show_textbox() -> void:
    textbox_container.show()

func display_text() -> void:
    var text = text_queue.pop_front()
    clear_textbox()
    text_label.visible_ratio = 0.0
    text_label.text = text
    change_state(TextBoxState.READING)
    if cur_tween:
        cur_tween.kill()
    cur_tween = get_tree().create_tween()
    cur_tween.tween_property(text_label, "visible_ratio", 1.0, len(text) * TEXT_READ_RATE).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
    cur_tween.tween_callback(on_tween_completed)

func on_tween_completed():
    change_state(TextBoxState.FINISHED)
    if !text_queue.is_empty():
        end_animation.play("triangle")

func change_state(next_state: TextBoxState) -> void:
    current_state = next_state
    match current_state:
        TextBoxState.READY:
            print("[DEBUG MSG] Changing state to: State.READY")
        TextBoxState.READING:
            print("[DEBUG MSG] Changing state to: State.READING")
        TextBoxState.FINISHED:
            text_finished.emit()
            print("[DEBUG MSG] Changing state to: State.FINISHED")
