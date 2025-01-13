// Wait for the Rune client to initialize
var initialized = false

function onChange({ game, players, yourPlayerId, action }) {
	const { cells, playerIds, winCombo, lastMovePlayerId, freeCells } = game
	if (!initialized) {
		initialized = true
		console.log(cells, playerIds, players, yourPlayerId)
	}
	console.log(game, players)
}

function onChangeFromGodot(game, players, yourPlayerId, action) {
	console.log("onChangeFromGodot", game, players, yourPlayerId, action)
	onChange(JSON.parse(game), players, yourPlayerId, action)
}


function test(...args) {
	console.log("arg test", args)
	console.log("arg test", args[2])
	console.log("arg test", JSON.parse(args[2]).test3)
}


Rune.initClient({ onChange })
