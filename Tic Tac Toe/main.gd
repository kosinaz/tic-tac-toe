extends Node

var callback = JavaScript.create_callback(self, "callbacktest")
var console = JavaScript.get_interface("console")
var window = JavaScript.get_interface("window")

onready var http_request = $HTTPRequest
onready var http_request2 = $HTTPRequest2

func _ready():
	# Get the JavaScript window object
	if window:
		window.parent.test_callback = callback
		window.parent.Rune.runeTest("my arg from Godot")
		

func callbacktest(args):
	print("player id: ", args[1])
	var data = JSON.parse(args[0]).result
	$"%NameLabel1".text = data[0].displayName
	$"%NameLabel2".text = data[1].displayName
	$"%ControllerLabel1".text = "(you)" if args[1] == data[0].playerId else " "
	$"%ControllerLabel2".text = "(you)" if args[1] == data[1].playerId else " "
	
	print("Requesting avatar URL: ", data[0].avatarUrl)
	
	var error = http_request.request(data[0].avatarUrl)
	if error != OK:
		print("Failed to start HTTP request. Error code:", error)
	
	error = http_request2.request(data[1].avatarUrl)
	if error != OK:
		print("Failed to start HTTP request. Error code:", error)

# Signal handler for HTTPRequest completion
func _on_HTTPRequest_request_completed(_result, response_code, _headers, body):
	if response_code == 200:  # Check if the request was successful
		var image = Image.new()
		var error = image.load_png_from_buffer(body)  # Load image from response body
		if error == OK:
			var texture = ImageTexture.new()
			texture.create_from_image(image, 0)
			
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
			var texture = ImageTexture.new()
			texture.create_from_image(image, 0)
			
			# Set the texture to the TextureRect
			$"%AvatarTextureRect2".texture = texture
		else:
			print("Error loading image:", error)
	else:
		print("Failed to fetch avatar. Response code:", response_code)
