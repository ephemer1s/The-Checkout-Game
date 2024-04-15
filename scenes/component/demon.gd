extends Node

class_name Demon

@onready var body_animation = $Body
@onready var logo_animation = $Logo
@onready var hand_animation = $Hand
@onready var appear_animation = $Appearing
@onready var heart_and_soul_animation = $HeartAndSoul

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    heart_and_soul_animation.visible = false
    body_animation.visible = false
    logo_animation.visible = false
    hand_animation.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func hide_heart_and_soul() -> void:
    heart_and_soul_animation.visible = false

func appear() -> void:
    appear_animation.visible = true
    appear_animation.play("default")
    await appear_animation.animation_finished
    appear_animation.visible = false
    body_animation.visible = true
    logo_animation.visible = true
    hand_animation.visible = true
    play_body_animation("default")
    play_mask_animation("default")
    play_hand_animation("default")

func play_body_animation(animation_name: String) -> void:
    body_animation.play(animation_name)

func play_mask_animation(animation_name: String) -> void:
    logo_animation.play(animation_name)

func play_hand_animation(animation_name: String) -> void:
    hand_animation.play(animation_name)

func enlarge_hand_scale() -> void:
    hand_animation.scale = Vector2(0.9, 0.9)

func reset_hand_scale() -> void:
    hand_animation.scale = Vector2(0.8, 0.8)

func play_heart_and_soul_animation() -> void:
    play_body_animation("default")
    play_mask_animation("laugh")
    play_hand_animation("open")
    heart_and_soul_animation.visible = true
