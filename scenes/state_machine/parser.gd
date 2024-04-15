extends Node

class_name JSONParser

var data_file_path: String
var itemData: Dictionary
#var animation: Dictionary
#var background: String

func get_file_path(state_id: int)-> String:
    var filepath = ""
    if state_id > 100:
         filepath = "res://resources/common/endings/end" + str(state_id) + ".json"
    elif state_id < 10:
         filepath = "res://resources/common/states/sta0" + str(state_id) + ".json"
    else:
         filepath = "res://resources/common/states/sta" + str(state_id) + ".json"
    data_file_path = filepath
    return filepath # does not guarantee the legitimacy (existence) of filepath.

func load_json(filePath: String)-> Dictionary: 
    if FileAccess.file_exists(filePath):
        var dataFile = FileAccess.open(filePath, FileAccess.READ)
        var dataParsed = JSON.parse_string(dataFile.get_as_text())
        
        if dataParsed is Dictionary:
            if OS.is_debug_build():
                print("[DEBUG MSG] loaded file to parser:")
                itemData = dataParsed
                return dataParsed
        else:
            print("[ERROR] Error loading file to parser:", filePath)
            
    else:
        print("[ERROR] file not exist:", filePath)
    return {}

func parse(state_id: int) -> Dictionary:
    return load_json(get_file_path(state_id))
    

# Called when the node enters the scene tree for the first time.
func _ready():
    #data_file_path = "res://resources/common/states/sta00.json"
    #itemData = load_json(data_file_path)
    pass
    

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


