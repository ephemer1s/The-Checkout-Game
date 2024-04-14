extends Node

const TEXT_READ_RATE: float = 0.02
var current_state: TextBoxState = TextBoxState.READY
var text_queue = []
var cur_tween: Tween
@onready var textbox_container = $TextboxContainer
@onready var end_label = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var text_label = $TextboxContainer/MarginContainer/HBoxContainer/Text
@onready var end_animation = $TextboxContainer/MarginContainer/HBoxContainer/EndAnimation

enum TextBoxState {
	READY,
	READING,
	FINISHED
}

func queue_text(next_text):
	text_queue.push_back(next_text)

func _ready():
	queue_text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
	queue_text("Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ")
	queue_text("Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ")
	queue_text("Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
	queue_text("The end.")

func _process(delta: float) -> void:
	match current_state:
		TextBoxState.READY:
			end_animation.stop()
			if !text_queue.is_empty():
				display_text()
		TextBoxState.READING:
			end_animation.stop()
			if Input.is_action_just_pressed("confirm"):
				text_label.visible_ratio = 1.0
				if cur_tween:
					cur_tween.kill()
				change_state(TextBoxState.FINISHED)
				on_tween_completed()
		TextBoxState.FINISHED:
			if Input.is_action_just_pressed("confirm"):
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
			print("Changing state to: State.READY")
		TextBoxState.READING:
			print("Changing state to: State.READING")
		TextBoxState.FINISHED:
			print("Changing state to: State.FINISHED")
