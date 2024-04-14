extends Control

@onready var card = $Card
@onready var friend = $Friend
@onready var money = $Money
@onready var contract = $Contract
@onready var bag = $Bag
@onready var animation_player = $AnimationPlayer

@onready var contract_area = $Contract/ContractArea2D
@onready var card_area = $Card/CardArea2D
@onready var friend_area = $Friend/FriendArea2D
@onready var money_area = $Money/MoneyArea2D
var cur_state = State.READY
var hovering = false
enum State {
    READY,
    HOVERED_BAG,
    BAG_READY,
    HOVERED_CARD,
    HOVERED_CONTRACT,
    HOVERED_MONEY,
}

func _ready() -> void:
    card.visible = false
    friend.visible = false
    money.visible = false
    contract.visible = false
    contract.material.set_shader_parameter("onoff", 0)
    money.material.set_shader_parameter("onoff", 0)
    friend.material.set_shader_parameter("onoff", 0)
    card.material.set_shader_parameter("onoff", 0)
    bag.connect("mouse_entered", on_mouse_entered_bag)
    bag.connect("mouse_exited", on_mouse_exited_bag)
    card_area.connect("mouse_entered", on_mouse_entered_card)
    card_area.connect("mouse_exited", on_mouse_exited_card)
    money_area.connect("mouse_entered", on_mouse_entered_money)
    money_area.connect("mouse_exited", on_mouse_exited_money)
    friend_area.connect("mouse_entered", on_mouse_entered_friend)
    friend_area.connect("mouse_exited", on_mouse_exited_friend)
    contract_area.connect("mouse_entered", on_mouse_entered_contract)
    contract_area.connect("mouse_exited", on_mouse_exited_contract)

func on_mouse_entered_card() -> void:
    if cur_state == State.BAG_READY:
        card.material.set_shader_parameter("onoff", 1)
        animation_player.play("card_enter")

func on_mouse_exited_card() -> void:
    if cur_state == State.BAG_READY:
        card.material.set_shader_parameter("onoff", 0)
        animation_player.play("card_exit")

func on_mouse_entered_money() -> void:
    if cur_state == State.BAG_READY:
        money.material.set_shader_parameter("onoff", 1)
        animation_player.play("money_enter")

func on_mouse_exited_money() -> void:
    if cur_state == State.BAG_READY:
        money.material.set_shader_parameter("onoff", 0)
        animation_player.play("money_exit")

func on_mouse_entered_friend() -> void:
    if cur_state == State.BAG_READY:
        friend.material.set_shader_parameter("onoff", 1)
        animation_player.play("friend_enter")

func on_mouse_exited_friend() -> void:
    if cur_state == State.BAG_READY:
        friend.material.set_shader_parameter("onoff", 0)
        animation_player.play("friend_exit")

func on_mouse_entered_contract() -> void:
    contract.material.set_shader_parameter("onoff", 1)
    if cur_state == State.BAG_READY:
        animation_player.play("contract_enter")

func on_mouse_exited_contract() -> void:
    contract.material.set_shader_parameter("onoff", 0)
    if cur_state == State.BAG_READY:
        animation_player.play("contract_exit")

func on_mouse_entered_bag() -> void:
    hovering = true
    if cur_state == State.READY:
        bag.material.set_shader_parameter("onoff", 1)
        cur_state = State.HOVERED_BAG
        animation_player.play("mouse_enter")

func on_mouse_exited_bag() -> void:
    hovering = false
    if cur_state == State.HOVERED_BAG:
        bag.material.set_shader_parameter("onoff", 0)
        cur_state = State.READY
        animation_player.play("mouse_exit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if Input.is_action_just_pressed("confirm") and cur_state == State.HOVERED_BAG:
        bag.material.set_shader_parameter("onoff", 0)
        contract.material.set_shader_parameter("onoff", 0)
        money.material.set_shader_parameter("onoff", 0)
        friend.material.set_shader_parameter("onoff", 0)
        card.material.set_shader_parameter("onoff", 0)
        card.visible = true
        friend.visible = true
        money.visible = true
        contract.visible = true
        animation_player.play("on_click")
        bag.modulate = Color(0.25, 0.25, 0.25)
        await animation_player.animation_finished
        cur_state = State.BAG_READY
    elif Input.is_action_just_pressed("confirm") and cur_state == State.BAG_READY:
        animation_player.play("on_cancel")
        await animation_player.animation_finished
        bag.modulate = Color(1,1,1)
        card.visible = false
        friend.visible = false
        money.visible = false
        contract.visible = false
        if not hovering:
            cur_state = State.READY
            animation_player.play("mouse_exit")
        else:
            bag.material.set_shader_parameter("onoff", 1)
            cur_state = State.HOVERED_BAG
