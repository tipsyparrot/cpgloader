// DoAction
// helper functions
function loadJSON(file, cb) {
	var loader = new com.clubpenguin.util.JSONLoader();
	var handler = com.clubpenguin.util.Delegate.create(loader, function(event) {
		if (event.type === com.clubpenguin.util.JSONLoader.FAIL) {
			console.log("!!! failed to load json. file was: " + file);
			return;
		}
		if (cb) {
			cb(event.target.data);
		}
	});
	loader.addEventListener(com.clubpenguin.util.JSONLoader.COMPLETE, handler);
	loader.addEventListener(com.clubpenguin.util.JSONLoader.FAIL, handler);
	loader.load(file);
}
/*
function loadAS3Game(container, file, cb) {
	var hybridLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
	hybridLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, mx.utils.Delegate.create(this, cb));
	hybridLoader.loadClip(file, container);
}
*/
function applyCustomSettings(container, settings) {
	// stamps
	applyCustomSettingsStamps(container, settings);
}
function applyCustomSettingsStamps(container, settings) {
	var shell = _global.getCurrentShell();
	var stamps = settings.stamps;
	// check unlockAll setting
	if (stamps.unlockAll) {
		for (var id in shell.stampManager._allStamps) {
			console.log("unlocking all stamps. curr id: " + id);
			shell.stampEarned(id);
		}
		// no need to process other stuff
		return;
	}
	// unlock by explicit ids
	var unlockIds = stamps.unlockIds;
	if (unlockIds.length) {
		var i = 0;
		while (i < unlockIds.length) {
			shell.stampEarned(unlockIds[i]);
			i++;
		}
	}
	// unlock by game name
	console.log("unlock stamps by game name");
	console.log(stamps);
	var unlockByGame = stamps.unlockByGame;
	for (var gameToUnlock in unlockByGame) {
		console.log("checking game: " + gameToUnlock + ": " + unlockByGame[gameToUnlock]);
		if (unlockByGame[gameToUnlock]) {
			// unlock all stamps from this game
			console.log("@@> true: unlock all stamps from " + gameToUnlock);
			console.log("upupdiwndiwn::@@@:~" + com.clubpenguin.util.JSONParser.stringify(shell.stampManager._allActivityStamps));
			for (var id in shell.stampManager._allActivityStamps[gameToUnlock]) {
				console.log("unlock id: " + id);
				shell.stampEarned(id);
			}
		}
	}
}

function loadGame(container, file, cb) {
	console.log("loadGame(): " + file);
	var listener = new Object();
	listener.onLoadInit = function() {
		console.log("@@@@@ onLoadInit");
	}
	listener.onLoadComplete = function(e) {
		com.clubpenguin.util.Loader.removeEventListener(listener);
		if (cb) {
			cb();
		}
	};
	com.clubpenguin.util.Loader.addEventListener(listener);
	// container.createEmptyMovieClip("gameLayer", container.getNextHighestDepth());
	// com.clubpenguin.util.Loader.loadAllMovies(container.gameLayer, ["games/" + file]);
	com.clubpenguin.util.Loader.loadAllMovies(container, ["games/" + file]);
}

function setupRoot(container, settings) {
	// defaults, rebuild settings if necessary
	var defaultColorId = 12;
	var defaultHandId = 0;
	settings = settings || {};
	settings.myPlayer = settings.myPlayer || {};
	settings.myPlayer.Colour = settings.myPlayer.Colour || defaultColorId;
	settings.myPlayer.Hand = settings.myPlayer.Hand || defaultHandId;
	// implement
	container._organizedStampData = {};
	container.myMediaPath = "";
	container.isTestServer = true;
	container.myCrumbs = {};
	container.myCrumbs.colors = ["0x003366", "0x003366", "0x009900", "0xff3399", "0x333333", "0xcc0000", "0xff6600", "0xffcc00", "0x660099", "0x996600", "0xff6666", "0x006600", "0x0099cc", "0x8ae302", "0x93a0a4", "0x02a797", "0xf0f0d8", "0xc378d0"];
	container.myPlayer = settings.myPlayer;
	_global.SHELL = new com.clubpenguin.shell.FakeShell();
	_global.getCurrentShell = com.clubpenguin.shell.FakeShell.getCurrentShell;
}

function setupMusicLayer(container) {
	container.createEmptyMovieClip("dependencyHolder",container.getNextHighestDepth());
	container.MUSIC = new com.clubpenguin.shell.Music(dependencyHolder.createEmptyMovieClip("music", container.dependencyHolder.getNextHighestDepth()));
}

function rearrangeLayout(container) {
	container.game_mc.gameLayer._x = 0;
	container.game_mc.gameLayer._y = 0;
	container.debugText._x = 900;
	container.debugText._x = 760;
}

function init(container) {
	// first, load settings
	loadJSON("settings.json", function(settings) {
		// add root objects
		setupRoot(container, settings);
		// add music object for files that require it
		setupMusicLayer(container);
		// load stamps.json file
		loadJSON("json/stamps.json", function(stampsData) {
			var organizedStamps = com.clubpenguin.stamps.FakeStampManager.organizeStamps(stampsData);
			var shell = _global.getCurrentShell();
			shell.stampManager.updateStampData(organizedStamps);
			// done updating the shell - apply custom settings
			applyCustomSettings(container, settings);
			// load games.json file
			loadJSON("json/games.json", function(gamesData) {
				// get the game object by its property name from the settings
				var gameName = settings.my_game;
				var gameData = gamesData[gameName];
				// check if game can be found
				if (!gameData) {
					// the game's value in the setting is invalid
					console.log("game data for title '" + gameName + "' was not found. please check your spelling, and make sure that games.json is in the correct location/not corrupted");
					return;
				}
				// get game's path
				var path = gameData.path;
				// create game layer
				container.game_mc.createEmptyMovieClip("gameLayer", container.game_mc.getNextHighestDepth());
				// load game
				loadGame(container.game_mc.gameLayer, path, function() {
					// game loaded
					console.log("game loaded!");
					// move console output to the right, and move game to the origin
					rearrangeLayout(container);
				});
			});
		});
	});
}