extends CanvasLayer

@onready var end = $End
@onready var true_end = $TrueEnd

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    end.visible = false
    true_end.visible = false

func play_end(end_name: String) -> void:
    print("END NAME:", end_name)
    if end_name == "summoning":
        true_end.visible = true
        true_end.play("default")
        await true_end.animation_finished
        true_end.play("repeat")
    else:
        end.visible = true
        end.play(end_name)
