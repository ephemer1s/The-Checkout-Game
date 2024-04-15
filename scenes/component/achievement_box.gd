extends Control

@onready var icon = $MarginContainer/MarginContainer/HBoxContainer/MarginContainer/icon
@onready var title = $MarginContainer/MarginContainer/HBoxContainer/VBoxContainer/title
@onready var description = $MarginContainer/MarginContainer/HBoxContainer/VBoxContainer/desc

var ignorant_icon: Texture2D = preload("res://assets/inv_card.png")
var mindless_icon: Texture2D = preload("res://assets/end_troubled_mind.png")
var nameless_icon: Texture2D = preload("res://assets/end_nameless.png")
var bodiless_icon: Texture2D = preload("res://assets/flesh_1.png")
var soulless_icon: Texture2D = preload("res://assets/soul_1.png")
var depleted_icon: Texture2D = preload("res://assets/end_depleted.png")
var summoning_icon: Texture2D = preload("res://assets/end_true.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    title.text = ""
    description.text = ""

    set_achievement("depleted")


func set_achievement(ending: String) -> void:
    if ending == "ignorant":
        title.text = "THE IGNORANT"
        description.text = "a blessing in disguise."
        icon.texture = ignorant_icon
    elif ending == "mindless":
        title.text = "THE MINDLESS"
        description.text = "an endless white awaits."
        icon.texture = mindless_icon
    elif ending == "nameless":
        title.text = "THE NAMELESS"
        description.text = "who?"
        icon.texture = nameless_icon
    elif ending == "bodiless":
        title.text = "THE BODILESS"
        description.text = "for my savior, anything."
        icon.texture = bodiless_icon
    elif ending == "soulless":
        title.text = "THE SOULLESS"
        description.text = "..."
        icon.texture = soulless_icon
    elif ending == "depleted":
        title.text = "THE DEPLETED"
        description.text = "I am Jack's lack of meticulousness."
        icon.texture = depleted_icon
    elif ending == "summoning":
        title.text = "THE SUMMONING"
        description.text = "what beauty."
        icon.texture = summoning_icon
    else:
        print("wtf, ", ending)
