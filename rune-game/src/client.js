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
		initPlayers(args.allPlayerIds, args.yourPlayerId)
	}
}

Rune.initClient({ onChange })
Rune.onGodotReady = function() {
	initPlayersInGodot(JSON.stringify(players), localPlayerId)
}
