extends Node

class_name Demon

@onready var body_animation = $Body
@onready var logo_animation = $Logo
@onready var hand_animation = $Hand
@onready var appear_animation = $Appearing


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    body_animation.visible = false
    logo_animation.visible = false
    hand_animation.visible = false
    appear()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func appear() -> void:
    appear_animation.visible = true
    appear_animation.play("default")
    await appear_animation.animation_finished
    appear_animation.visible = false
    body_animation.visible = true
    logo_animation.visible = true
    hand_animation.visible = true
    play_body_animation("default")
    play_logo_animation("default")
    play_hand_animation("default")

func play_body_animation(animation_name: String) -> void:
    body_animation.play(animation_name)

func play_logo_animation(animation_name: String) -> void:
    logo_animation.play(animation_name)

func play_hand_animation(animation_name: String) -> void:
    hand_animation.play(animation_name)
