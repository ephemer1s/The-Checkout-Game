extends Node2D

class_name StateMachine

signal transitioned(state_name)

# Path to the initial active state. Export it to pick the initial state in the inspector.
@export var initial_state = NodePath()
@onready var cur_state: State = get_node(initial_state) as State
var prev_state: State = null

func _ready() -> void:
    for child in get_children():
        if child is State:
            child.state_machine = self

    cur_state.enter()

func _unhandled_input(event: InputEvent) -> void:
    cur_state.handle_input(event)

func _process(delta: float) -> void:
    cur_state.update(delta)

func _physics_process(delta: float) -> void:
    print(cur_state)
    cur_state.physics_update(delta)

func transition_to(target_state_name: String) -> void:
    if not has_node(target_state_name):
        return

    prev_state = cur_state
    cur_state.exit()
    cur_state = get_node(target_state_name) as State

    cur_state.enter()
    transitioned.emit(cur_state.name)
