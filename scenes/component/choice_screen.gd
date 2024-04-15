extends CanvasLayer

class_name ChoiceScreen

@onready var color_rect = $ColorRect
@onready var left_container: VBoxContainer = $MarginContainLeft/VBoxContainer
@onready var right_container: VBoxContainer = $MarginContainerRight/VBoxContainer
@onready var left_margin_container = $MarginContainLeft
@onready var right_margin_container = $MarginContainerRight
var button_scene: PackedScene = preload("res://scenes/component/shadow_button.tscn")
var rng
var left_separation_init_value = 0
var right_separation_init_value = 0
func _ready() -> void:
    get_tree().paused = true
    rng = RandomNumberGenerator.new()
    left_separation_init_value = rng.randi_range(700, 1000)
    right_separation_init_value = rng.randi_range(700, 1000)
    left_margin_container.add_theme_constant_override("margin_top", rng.randi_range(140, 240))
    right_margin_container.add_theme_constant_override("margin_top", rng.randi_range(140, 240))

func add_option(text:String, next_state_id:int) -> void:
    var button_instance = button_scene.instantiate() as ShadowButton
    var added_to_right = false
    if rng.randi_range(0, 1) == 0 :
        left_container.add_child(button_instance)
        left_container.add_theme_constant_override("separation", left_separation_init_value / len(left_container.get_children()))
    else:
        added_to_right = true
        right_container.add_child(button_instance)
        right_container.add_theme_constant_override("separation", right_separation_init_value / len(right_container.get_children()))
    button_instance.setup_button(text, next_state_id)

    var allowed_flags = [Control.SIZE_SHRINK_BEGIN, Control.SIZE_SHRINK_CENTER, Control.SIZE_SHRINK_END]
    if len(text) > 10 && added_to_right:
        button_instance.size_flags_horizontal = allowed_flags[rng.randi_range(0, 1)]
    elif len(text) > 6 && added_to_right:
        button_instance.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
    else:
        button_instance.size_flags_horizontal = allowed_flags[rng.randi_range(0, 2)]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
