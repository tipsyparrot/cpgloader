class com.clubpenguin.shell.FakeShell {
	function FakeShell() {
		this.stampManager = new com.clubpenguin.stamps.FakeStampManager(this);
	}
	// var stampManager = new com.clubpenguin.stamps.FakeStampManager(this);

	/* static values */

	// static variables
	var UPDATE_MUSIC = "updatemusic";
	var check = "shell check: i am the custom shell!"; // @@ < debug

	// static functions
	static function getCurrentShell() {
		// var shellInstance = new com.clubpenguin.shell.FakeShell();
		// shellInstance.stampManager.updateStampData(_root._organizedStampData);
		// return shellInstance;
		return _global.SHELL;
	}

	/* methods */

	// i18n
	function getLocalizedFrame() {
		return 1;
	}
	function getGamesPath() {
		return "";
	}

	// music
	function startGameMusic(id) {
		this.startMusicById(id);
	}
	function stopMusic() {
		_root.MUSIC.stopMusic();
	}
	function startMusicById(id) {
		var file = "music/" + id + ".swf";
		_root.MUSIC.playMusicURL(file);
	}
	function playMusicById() {}
	function sendMuteMusicPlayer() {}


	// player
	function getMyPlayerId() {
		return 69420;
	}
	function isMyPlayerMember() {
		return true;
	}
	function getMyPlayerHex() {
		return _root.myCrumbs.colors[_root.myPlayer.Colour]
	}
	function isItemOnMyPlayer(id) {
		//return true;

		// for (var type in this.myPenguinItems) {
		for (var type in _root.myPlayer) {
			if (_root.myPlayer[type] === id) {
				return true;
			}
		}
		return false;
	}

	// stamps
	function getStampManager() {
		return this.stampManager;
	}
	function stampEarned(id) {
		//console.log("shell instance > stampEarned(" + id + "): this.stampManager is " + typeof this.stampManager);
		if (this.stampManager.stampIsOwnedByMe(id)) {
			return;
		}
		this.stampManager.setRecentlyEarnedStamp(id);
	}

	function stampIsOwnedByMe(id) {
		//console.log("shellInstance.stampIsOwnedByMe(): " + id);
		//console.log("shellInstance stamp manager type is: " + typeof this.stampManager);
		return this.stampManager.stampIsOwnedByMe(id);
	}

	// misc empty filler functions
	function hideLoading() {}
	function updateListeners() {}
}