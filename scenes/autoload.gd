extends Node

signal transition_to(state_id, money_action)

var endings = []

func emit_transition_to(state_id: int, money_action: String) -> void:
    transition_to.emit(state_id, money_action)
