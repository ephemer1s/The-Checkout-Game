extends Node

class_name State

var state_id: int
var state_machine: StateMachine
var parser: JSONParser

func enter() -> void:
    parser.parse(state_id)
    var animation = parser.itemData["content"]["animation"]
    
    state_machine.owner.face_animation_player.play(animation["face"])
    state_machine.owner.body_animation_player.play(animation["body"])
    state_machine.owner.logo_animation_player.play(animation["logo"])
    state_machine.owner.demon_animation_player.play(animation["demon"])
    state_machine.owner.demon_mask_animation_player.play(animation["mask"])
    # TODO: uncomment to enable this:
    #state_machine.owner.demon_hand_animation_player.play(animation["hand"])

func exit() -> void:
    pass

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

func get_illegible_text() -> Array[String]:
    var shop_text = get_shop_text()
    var demonic_text = get_demonic_text()
    
    var regex = RegEx.new()
    regex.compile("\\[[^\\]]*\\]")
    
    var shop_mosaic = regex.search(shop_text).get_strings() 
    var demonic_mosaic = regex.search(demonic_text).get_strings()
    
    if OS.is_debug_build():
        print("[DEBUG MSG] matched mosaic text list:")
        print(shop_mosaic, demonic_mosaic)
        
    return [shop_mosaic, demonic_mosaic]
    
func get_animation_type_dict() -> String:
    return parser.itemData["content"]["animation"]

#TODO: enable this when the key "background" added to json
#func get_background -> String:
    #return parser.itemData["content"]["background"]

func get_options() -> Array:
    return parser.itemData["content"]["option"]  # option: id:int, tooltip:str, desc:str, next:int
