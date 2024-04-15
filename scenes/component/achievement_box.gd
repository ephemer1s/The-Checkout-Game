extends Control

@onready var icon = $MarginContainer/MarginContainer/HBoxContainer/MarginContainer/icon
@onready var title = $MarginContainer/MarginContainer/HBoxContainer/VBoxContainer/title
@onready var description = $MarginContainer/MarginContainer/HBoxContainer/VBoxContainer/desc

var ignorant_icon: Texture2D = preload("res://assets/end_ignorant.png")
var mindless_icon: Texture2D = preload("res://assets/end_troubled_mind.png")
var nameless_icon: Texture2D = preload("res://assets/end_nameless.png")
var bodiless_icon: Texture2D = preload("res://assets/end_bodiless.png")
var soulless_icon: Texture2D = preload("res://assets/end_soulless.png")
var depleted_icon: Texture2D = preload("res://assets/end_depleted.png")
var summoning_icon: Texture2D = preload("res://assets/end_true.png")

func _ready() -> void:
    title.text = ""
    description.text = ""
    set_achievement("mindless")


func set_achievement(ending: String) -> void:
    if ending == "ignorant":
        title.text = "ENDING # 7 - THE IGNORANT"
        description.text = "a blessing in disguise."
        icon.texture = ignorant_icon
    elif ending == "mindless":
        title.text = "ENDING # 6 - THE MINDLESS"
        description.text = "an endless white awaits."
        icon.texture = mindless_icon
    elif ending == "nameless":
        title.text = "ENDING # 4 - THE NAMELESS"
        description.text = "who?"
        icon.texture = nameless_icon
    elif ending == "bodiless":
        title.text = "ENDING # 2 - THE BODILESS"
        description.text = "for my savior, anything."
        icon.texture = bodiless_icon
    elif ending == "soulless":
        title.text = "ENDING # 3 - THE SOULLESS"
        description.text = "..."
        icon.texture = soulless_icon
    elif ending == "depleted":
        title.text = "ENDING # 5 - THE DEPLETED"
        description.text = "I am Jack's lack of meticulousness."
        icon.texture = depleted_icon
    elif ending == "summoning":
        title.text = "ENDING # 1 - THE SUMMONING"
        description.text = "what beauty."
        icon.texture = summoning_icon
    else:
        print("wtf, ", ending)
