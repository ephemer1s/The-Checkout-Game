#extends Node
extends AudioStreamPlayer

#@onready var bgmplayer_shop = AudioStreamPlayer.new()
#@onready var bgmplayer_demon = AudioStreamPlayer.new()
#@onready var bgmplayer_demon2 = AudioStreamPlayer.new()
@onready var dummy_player = AudioStreamPlayer.new()
@onready var bgmshop = load("res://assets/sfx/shop_bgm.mp3")
@onready var bgmdemon = load("res://assets/sfx/demon_bgm.mp3")
@onready var bgmambient = load("res://assets/sfx/demon_ambient.mp3")
var fading = false
var offset = -15


# Called when the node enters the scene tree for the first time.
func _ready():
    add_child(dummy_player)
    play_bgm("shop")
    
    #bgmplayer_shop.stream = load("res://assets/sfx/shop_bgm.mp3")
    #bgmplayer_demon.stream = load("res://assets/sfx/demon_bgm.mp3")
    #bgmplayer_demon2.stream = load("res://assets/sfx/demon_ambient.mp3")
#
    #bgmplayer_shop.autoplay = true
    #bgmplayer_shop.play()
    pass

func play_bgm(song) -> void:
    ''' hard cut, play designated bgm directly
    '''
    if song == "shop":
        stream = bgmshop
    elif song == "demon":
        stream = bgmdemon
    volume_db = 0 + offset
    play()

func switch_bgm(song) -> void:
    ''' fade in & out, play designated bgm with fading
    '''
    if song == "shop":
        dummy_player.stream = bgmshop
    elif song == "demon":
        dummy_player.stream = bgmdemon
    dummy_player.volume_db = -60 + offset
    dummy_player.play()
    fading = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if fading:
        volume_db -= 15 * delta
        dummy_player.volume_db += 15 * delta
        
        if dummy_player.volume_db >= 0 + offset:
            volume_db = 0 + offset
            dummy_player.volume_db = -60 + offset
            stream = dummy_player.stream
            play(dummy_player.get_playback_position())
            
            dummy_player.stop()
            fading = false
        
    pass


    
