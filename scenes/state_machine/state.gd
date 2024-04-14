extends Node

class_name State

var state_machine: StateMachine

func enter() -> void:
    state_machine.owner.face_animation_player.play("smile")
    state_machine.owner.body_animation_player.play("smile")
    state_machine.owner.logo_animation_player.play("smile")
    state_machine.owner.demon_animation_player.play("smile")
    state_machine.owner.demon_mask_animation_player.play("smile")

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

func get_choices() -> Array:
    return []
