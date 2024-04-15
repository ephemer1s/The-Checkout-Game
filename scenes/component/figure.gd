extends Node

class_name Figure

@onready var body_animation = $Body
@onready var face_animation = $Face
@onready var logo_animation = $Logo
@onready var background = $Background
@onready var midground = $Midground
@onready var card_reader = $Foreground/CardReader
@onready var special = $Foreground/Special

var demonic_special = preload("res://assets/poster_1_demon.png")
var demonic_poster = preload("res://assets/poster_2_demon.png")
var demonic_jar = preload("res://assets/donation_jar_demon.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    update_special()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func play_body_animation(animation_name: String) -> void:
    body_animation.play(animation_name)

func play_logo_animation(animation_name: String) -> void:
    logo_animation.play(animation_name)

func play_face_animation(animation_name: String) -> void:
    face_animation.play(animation_name)

func update_background() -> void:
    background.texture = demonic_poster

func update_midground() -> void:
    midground.texture = demonic_jar

func update_special() -> void:
    special.texture = demonic_special
