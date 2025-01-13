extends Node

var callback = JavaScript.create_callback(self, "callbacktest")

func _ready():
	# Get the JavaScript window object
	var window = JavaScript.get_interface("window")
	if window:
		# Prepare dummy data for the `onChange` method
		var cells = [null, "player1", "player2", null, "player1", null, "player2", null, null] # Example board state
		var player_ids = ["player1", "player2"]
		var win_combo = [0, 1, 2]

		# Serialize arrays to JSON
		var json_cells = to_json(cells)
		var json_player_ids = to_json(player_ids)
		var json_win_combo = to_json(win_combo)
		
		var game_data = {
			"cells": cells,
			"playerIds": player_ids,
			"winCombo": win_combo,
			"lastMovePlayerId": "player2", # ID of the last player who made a move
			"freeCells": 5 # Number of remaining free cells
		}
		
		var players_data = {
			"player1": {
				"avatarUrl": "https://example.com/avatar1.png",
				"displayName": "Player 1",
				"playerId": "player1"
			},
			"player2": {
				"avatarUrl": "https://example.com/avatar2.png",
				"displayName": "Player 2",
				"playerId": "player2"
			}
		}
		
		var your_player_id = "player1" # Example player ID for the current user
		var action_data = {
			"name": "claimCell", # Example action name
			"cellIndex": 4 # Example cell index
		}
		
		var data = {
			"game": game_data,
			"players": players_data,
			"yourPlayerId": "player1",
			"action": {"name": "claimCell", "cellIndex": 2}
		}
		
		# Call the `onChange` method in JavaScript
		window.onChangeFromGodot(to_json(data))
		window.test("test1", "test2", to_json({"test3": "test3"}))
	
	var notification = JavaScript.get_interface("Notification")
	notification.requestPermission().then(callback)

func callbacktest(args):
	print("callback has fired")
	print("args:", args)
