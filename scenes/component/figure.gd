extends Node

class_name Figure

@onready var body_animation = $Body
@onready var face_animation = $Face
@onready var logo_animation = $Logo


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    play_animation("confused")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func play_animation(animation_name: String) -> void:
    body_animation.play("default")
    logo_animation.play("default")
    face_animation.play(animation_name)
