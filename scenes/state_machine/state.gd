extends Node

class_name State

var state_id: int
var state_machine: StateMachine
var parser: JSONParser

func enter(_state_id: int, _state_machine: StateMachine, _parser: JSONParser) -> void:
    state_id = _state_id
    state_machine = _state_machine
    parser = _parser

    parser.parse(state_id)
    if parser.itemData["type"] == "state":
        var animation = parser.itemData["content"]["animation"]

        state_machine.owner.figure.play_face_animation(animation["face"])
        state_machine.owner.figure.play_body_animation(animation["body"])
        state_machine.owner.figure.play_logo_animation(animation["logo"])
        if animation["logo"] == "mask":
            state_machine.owner.figure.update_background()
            state_machine.owner.figure.update_special()
            state_machine.owner.figure.update_midground()

        state_machine.owner.demon.reset_hand_scale()
        if animation["demon"] == 'appear':
            state_machine.owner.demon.appear()
            state_machine.owner.demon.hide_heart_and_soul()
            state_machine.owner.text_box.enable_shadow()
        elif animation["hand"] == "heartandsoul":
            state_machine.owner.demon.play_heart_and_soul_animation()
        else:
            state_machine.owner.demon.hide_heart_and_soul()
            if animation["hand"] == "big_contract":
                state_machine.owner.demon.enlarge_hand_scale()
            state_machine.owner.demon.play_mask_animation(animation["mask"])
            state_machine.owner.demon.play_body_animation(animation["demon"])
            state_machine.owner.demon.play_hand_animation(animation["hand"])

        state_machine.owner.text_box.queue_text(get_richtext_textstr(get_shop_text()))
        state_machine.owner.text_box.ready_text_box()
    elif parser.itemData["type"] == "ending":
        var ending_name = parser.itemData["content"]["title"]
        state_machine.owner.color_rect.visible = false
        state_machine.owner.margin_container.visible = false
        state_machine.owner.animation_player.play("fade_out")
        await state_machine.owner.animation_player.animation_finished

        state_machine.owner.end_screen.visible = true
        state_machine.owner.end_screen.play_end(ending_name)

func exit() -> void:
    if is_instance_valid(self):
        queue_free()

func update(delta: float) -> void:
    pass

func physics_update(delta: float) -> void:
    pass

func handle_input(event: InputEvent) -> void:
    pass

func get_shop_text() -> String:
    return parser.itemData["content"]["description"]["desc_shop"]

func get_demonic_text() -> String:
    return parser.itemData["content"]["description"]["desc_demonic"]

#func get_illegible_text() -> Array[String]:
    #'''
    #this function only extract string in brackets in this state's desc, to an array.
    #'''
    #var shop_text = get_shop_text()
    #var demonic_text = get_demonic_text()
#
    #var regex = RegEx.new()
    #regex.compile("\\[[^\\]]*\\]")
#
    #var shop_mosaic = regex.search(shop_text).get_strings()
    #var demonic_mosaic = regex.search(demonic_text).get_strings()
#
    #if OS.is_debug_build():
        #print("[DEBUG MSG] matched mosaic text list:")
        #print(shop_mosaic, demonic_mosaic)
#
    #return [shop_mosaic, demonic_mosaic]


func get_richtext_textstr(text, theme="shop") -> String:
    '''
    This function generates richtext label from description texts to display them on textbox.
    '''
    var richtxt = "[shake rate=25 level=5]"
    for ch in text:
        if ch == "[":
            richtxt += "[b][color=#FFC700]"
        elif ch == "]":
            richtxt += "[/color][/b]"
        else:
            richtxt += ch
    richtxt += "[/shake]"
    return richtxt


func get_animation_type_dict() -> String:
    return parser.itemData["content"]["animation"]

#TODO: enable this when the key "background" added to json
#func get_background -> String:
    #return parser.itemData["content"]["background"]

func get_options() -> Array:
    return parser.itemData["content"]["option"]  # option: id:int, tooltip:str, desc:str, next:int

func get_cur_id() -> int:
    return parser.itemData["state_id"]

func round_place(num, places):
    return round(num * pow(10, places)) / pow(10, places)
