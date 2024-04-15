extends Node

signal transition_to(state_id)

func emit_transition_to(state_id: int) -> void:
    transition_to.emit(state_id)
