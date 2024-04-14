extends CanvasLayer

const TEXT_READ_RATE = 0.02
@onready var textbox_container = $TextboxContainer
@onready var end_label = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var text_label = $TextboxContainer/MarginContainer/HBoxContainer/Text

func _ready():
    update_text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.!")

func clear_textbox() -> void:
    text_label.text = ""
    end_label.text = ""

func hide_textbox() -> void:
    clear_textbox()
    textbox_container.hide()

func show_textbox() -> void:
    textbox_container.show()

func update_text(text: String) -> void:
    clear_textbox()
    text_label.text = text
    var tween = get_tree().create_tween()
    tween.tween_property(text_label, "visible_characters", len(text), len(text) * TEXT_READ_RATE).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
    tween.tween_callback(on_tween_completed)

func on_tween_completed():
    end_label.text = "▼"
