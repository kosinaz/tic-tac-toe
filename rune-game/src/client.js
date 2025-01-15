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

function onChange({ game, yourPlayerId, action, allPlayerIds }) {
	console.log("onChange")
	if (!initialized) {
		initialized = true
		initPlayers(allPlayerIds, yourPlayerId)
		return
	}
	const { cells, winCombo, lastMovePlayerId, freeCells } = game
	console.log("cells", cells)
	updateBoardInGodot(JSON.stringify(cells))
}

Rune.initClient({ onChange })
Rune.onGodotReady = function() {
	initPlayersInGodot(JSON.stringify(players), localPlayerId)
}