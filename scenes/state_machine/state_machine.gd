extends Node2D

class_name StateMachine

signal transitioned(state_name)

var state_scene: PackedScene = preload("res://scenes/state_machine/state.tscn")
@onready var cur_state: State = state_scene.instantiate()

var parser: JSONParser
func _ready() -> void:
    pass

func init(_parser: JSONParser) -> void:
    parser = _parser
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
    cur_state = state_scene.instantiate()

    cur_state.enter(next_state_id, self, parser)
    transitioned.emit(cur_state.name)
