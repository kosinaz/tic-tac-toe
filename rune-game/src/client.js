// Wait for the Rune client to initialize
var initialized = false
var godotGame = document.getElementById("godot-game").contentWindow;

function onChange() {
	if (!initialized) {
		initialized = true
		console.log("client inited")
	}
	
	if (typeof callbacktest === 'function') {
		callbacktest()
	}
	if (typeof test_callback === 'function') {
		test_callback("my arg from JS")
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
