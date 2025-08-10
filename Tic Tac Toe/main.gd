extends Node

var init_players_callback = JavaScriptBridge.create_callback(init_players)
var update_board_callback = JavaScriptBridge.create_callback(update_board)
var console = JavaScriptBridge.get_interface("console")
var window = JavaScriptBridge.get_interface("window")
var player_id = ""
var player_symbol = "o"

@onready var http_request = $HTTPRequest
@onready var http_request2 = $HTTPRequest2

func _ready():
	# Get the JavaScript window object
	if window:
		window.parent.initPlayersInGodot = init_players_callback
		window.parent.updateBoardInGodot = update_board_callback
		window.parent.Rune.onGodotReady()

func init_players(args):
	var test_json_conv = JSON.new()
	test_json_conv.parse(args[0])
	var data = test_json_conv.data
	player_id = args[1]
	$"%NameLabel1".text = data[0].displayName
	$"%NameLabel2".text = data[1].displayName
	if args[1] == data[0].playerId:
		$"%ControllerLabel1".text = "(you)"
		player_symbol = "o"
	else:
		$"%ControllerLabel1".text = " "
	if args[1] == data[1].playerId:
		$"%ControllerLabel2".text = "(you)"
		player_symbol = "x"
	else:
		$"%ControllerLabel2".text = " "
	var error = http_request.request(data[0].avatarUrl)
	if error != OK:
		print("Failed to start HTTP request. Error code:", error)
	
	error = http_request2.request(data[1].avatarUrl)
	if error != OK:
		print("Failed to start HTTP request. Error code:", error)
		
func update_board(args):
	var test_json_conv = JSON.new()
	test_json_conv.parse(args[0])
	var data = test_json_conv.data
	for i in range(data.size()):
		var cell = data[i]
		if cell == null:
			continue
		if cell == player_id:
			get_node("%SymbolTextureButton" + str(i + 1)).texture_disabled = load("res://assets/" + player_symbol + ".svg")
		elif player_symbol == "x":
			get_node("%SymbolTextureButton" + str(i + 1)).texture_disabled = load("res://assets/o.svg")
		else:
			get_node("%SymbolTextureButton" + str(i + 1)).texture_disabled = load("res://assets/x.svg")
		get_node("%SymbolTextureButton" + str(i + 1)).disabled = true

# Signal handler for HTTPRequest completion
func _on_HTTPRequest_request_completed(_result, response_code, _headers, body):
	if response_code == 200:  # Check if the request was successful
		var image = Image.new()
		var error = image.load_png_from_buffer(body)  # Load image from response body
		if error == OK:
			var texture = ImageTexture.create_from_image(image) #,0
			
			# Set the texture to the TextureRect
			$"%AvatarTextureRect1".texture = texture
		else:
			print("Error loading image:", error)
	else:
		print("Failed to fetch avatar. Response code:", response_code)

# Signal handler for HTTPRequest2 completion
func _on_HTTPRequest2_request_completed(_result, response_code, _headers, body):
	if response_code == 200:  # Check if the request was successful
		var image = Image.new()
		var error = image.load_png_from_buffer(body)  # Load image from response body
		if error == OK:
			var texture = ImageTexture.create_from_image(image) #,0
			
			# Set the texture to the TextureRect
			$"%AvatarTextureRect2".texture = texture
		else:
			print("Error loading image:", error)
	else:
		print("Failed to fetch avatar. Response code:", response_code)


func _on_SymbolTextureButton_pressed(id):
	window.parent.Rune.actions.claimCell(id - 1)
