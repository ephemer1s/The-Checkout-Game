extends Node

class_name State

var state_machine: StateMachine

func enter() -> void:
    pass

func exit() -> void:
    pass

func update(delta: float) -> void:
    pass

func physics_update(delta: float) -> void:
    pass

func handle_input(event: InputEvent) -> void:
    pass

func get_illegible_text() -> String:
    return ""

func get_shop_text() -> String:
    return ""

func get_demonic_text() -> String:
    return ""
