// Wait for the Rune client to initialize
var initialized = false
var initializedGodot = false
var godotGame = document.getElementById("godot-game").contentWindow;
var players = []
var localPlayerId = ""

function initPlayers(allPlayerIds, yourPlayerId) {
	localPlayerId = yourPlayerId
	allPlayerIds.forEach((playerId) => {
		const { displayName, avatarUrl } = Rune.getPlayerInfo(playerId)
		players.push({ displayName, avatarUrl, playerId })
	})
}

function onChange(args) {
	if (!initialized) {
		initialized = true
		console.log("onChange", args.allPlayerIds)
		initPlayers(args.allPlayerIds, args.yourPlayerId)
	}
	
	if (typeof callbacktest === 'function') {
		callbacktest()
	}

	if (!initializedGodot && typeof test_callback === 'function') {
		initializedGodot = true
		test_callback(JSON.stringify(players), localPlayerId)
	}

}

function onChangeFromGodot(game, players, yourPlayerId, action) {
	console.log("onChangeFromGodot", game, players, yourPlayerId, action)
}

function callbackforGodot() {
	console.log("callbackforGodot what")
}

function test(args) {
	console.log("arg test", args)
	if (typeof callbacktest === 'function') {
		callbacktest()
	}
}


Rune.initClient({ onChange })
Rune.runeTest = function(args) {
	console.log("runeTest works", args)
	onChange()
}
