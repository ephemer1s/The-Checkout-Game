extends Node

class_name Demon

@onready var body_animation = $Body
@onready var logo_animation = $Logo


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    play_animation("laugh")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func play_animation(animation_name: String) -> void:
    logo_animation.play(animation_name)
    body_animation.play("default")
