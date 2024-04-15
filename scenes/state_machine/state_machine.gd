extends Node2D

class_name StateMachine

var state_scene: PackedScene = preload("res://scenes/state_machine/state.tscn")
@onready var cur_state: State = state_scene.instantiate()
var choice_screen: PackedScene = preload("res://scenes/component/choice_screen.tscn")
var parser: JSONParser
var choice_screen_instance = null

var cost_total = 0.0
var named_blake = false

func _ready() -> void:
    Autoload.connect("transition_to", transition_to)

func get_money_action(option) -> String:
    if option["tooltip"] == "add money":
        return "+" + str(option["money"])
    elif option["tooltip"] == "sub money":
        return "-" + str(option["money"])
    elif option["tooltip"] == "mul money":
        return "*" + str(option["money"])
    return ""

func on_text_finished() -> void:
    if "option" not in parser.itemData["content"]:
        return

    if len(parser.itemData["content"]["option"]) == 1:
        if parser.itemData["content"]["option"][0]["tooltip"] == "alternative" and cost_total > 27:
            Autoload.emit_transition_to(parser.itemData["content"]["option"][0]['alternative'], get_money_action(parser.itemData["content"]["option"][0]))
        elif parser.itemData["content"]["option"][0]["tooltip"] == "alt_ending" and !named_blake:
            Autoload.emit_transition_to(parser.itemData["content"]["option"][0]['alt_ending'], get_money_action(parser.itemData["content"]["option"][0]))
        else:
            Autoload.emit_transition_to(parser.itemData["content"]["option"][0]['next'], get_money_action(parser.itemData["content"]["option"][0]))
    else:
        choice_screen_instance = choice_screen.instantiate() as ChoiceScreen
        owner.add_child(choice_screen_instance)
        for choice in parser.itemData["content"]["option"]:
            choice_screen_instance.add_option(choice['desc'], choice['next'], get_money_action(choice))

func init(_parser: JSONParser) -> void:
    parser = _parser
    owner.text_box.connect("text_finished", on_text_finished)

    cur_state.enter(0, self, parser)

func _unhandled_input(event: InputEvent) -> void:
    cur_state.handle_input(event)

func _process(delta: float) -> void:
    cur_state.update(delta)

func _physics_process(delta: float) -> void:
    cur_state.physics_update(delta)

func transition_to(next_state_id: int, money_action: String) -> void:
    cur_state.exit()
    if next_state_id == 11:
        named_blake = true

    if money_action:
        if money_action[0] == '+':
            money_action = money_action.erase(0)
            cost_total += float(money_action)
        elif money_action[0] == '-':
            money_action = money_action.erase(0)
            cost_total -= float(money_action)
        elif money_action[0] == '*':
            money_action = money_action.erase(0)
            cost_total *= float(money_action)
    if cost_total > 0:
        owner.figure.update_cost_label(cost_total)
    if choice_screen_instance && is_instance_valid(choice_screen_instance):
        choice_screen_instance.queue_free()
        get_tree().paused = false

    cur_state = state_scene.instantiate()
    cur_state.enter(next_state_id, self, parser)
