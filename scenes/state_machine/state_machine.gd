extends Node2D

class_name StateMachine

var state_scene: PackedScene = preload("res://scenes/state_machine/state.tscn")
@onready var cur_state: State = state_scene.instantiate()
var choice_screen: PackedScene = preload("res://scenes/component/choice_screen.tscn")
var parser: JSONParser
var choice_screen_instance = null
func _ready() -> void:
    Autoload.connect("transition_to", transition_to)

func on_text_finished() -> void:
    choice_screen_instance = choice_screen.instantiate() as ChoiceScreen
    owner.add_child(choice_screen_instance)
    for choice in parser.itemData["content"]["option"]:
        choice_screen_instance.add_option(choice['desc'], choice['next'])

func init(_parser: JSONParser) -> void:
    parser = _parser
    owner.text_box.connect("text_finished", on_text_finished)

    cur_state.enter(0, self, parser)

func _unhandled_input(event: InputEvent) -> void:
    cur_state.handle_input(event)

func _process(delta: float) -> void:
    cur_state.update(delta)

func _physics_process(delta: float) -> void:
    print(cur_state)
    cur_state.physics_update(delta)

func transition_to(next_state_id: int) -> void:
    cur_state.exit()
    if choice_screen_instance && is_instance_valid(choice_screen_instance):
        choice_screen_instance.queue_free()
        get_tree().paused = false

    cur_state = state_scene.instantiate()
    cur_state.enter(next_state_id, self, parser)
