class com.clubpenguin.shell.FakeShell {
	function FakeShell() {
		// var i = 0;
		// var stampIds = [75, 82, 77, 88, 84, 74, 83, 76, 89, 85];

		// while (i < stampIds.length) {
		// 	this.stampList[stampIds[i]] = true;
		// }
		var stampIds = [7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,130,131,132,133,134,135,136,137,138,139,140,141,142,144,145,146,147,148,149,150,151,152,153,154,155,156,157,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,182,183,184,185,186,187,188,189,190,191,193,197,198,199,200,201,202,203,204,205,206,208,210,212,214,216,218,220,222,224,226,228,230,232,234,236,238,240,242,244,246,248,252,254,256,260,262,264,266,268,270,274,276,278,282,284,286,288,290,292,294,296,298,300,302,304,306,308,310,312,320,322,324,326,328,330,332,334,336,338,340,342,344,346,348,350,352,354,356,358,360,362,364,372,374,376,378,380,382,384,386,388,390,392,394,396,398,400,402,404,406,408,410,414,416,418,420,422,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,443,444,448,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495];
		var i = 0;
		while (i < stampIds.length) {
			this.stampsObj[stampIds[i]] = true;
			i++;
		}
	}
	var stampList = [75, 82, 77, 88, 84, 74, 83, 76, 89, 85];
	var stampsObj = {};

	// var stampList = [{
	// 	"75": true,
	// 	"82": true,
	// 	"77": true,
	// 	"88": true,
	// 	"84": true,
	// 	"74": true,
	// 	"83": true,
	// 	"76": true,
	// 	"89": true,
	// 	"85": true
	// }];
	/* static values */

	// static variables
	var UPDATE_MUSIC = "updatemusic";
	var check = "shell check: i am the custom shell!"; // @@ < debug

	// static functions
	static function getCurrentShell() {
		return new com.clubpenguin.shell.FakeShell();
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


	// player's items, stamps, membership status, etc.
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
	function stampEarned() {}
	function stampIsOwnedByMe(stamp_id) {
		ppconsole.log("shell instance stampIsOwnedByMe() called: " + stamp_id);
		// cant do 'return true' because some files rely on the stamp order
		// as a 'while(hasStamp(id)) {id++}', which creates an endless loop
		// so only return true until id is higher than the highest stamp_id
		// var i = 0;
		// while (i < this.stampList.length) {
		// 	ppconsole.log("checking id: " + stamp_id + " :: this.stampList[0] is: " + this.stampList[0]);
		// 	if (this.stampList[i] === stamp_id) {
		// 		ppconsole.log("true!");
		// 		return true;
		// 	}
		// 	i++;
		// }
		// return false;
		return this.stampsObj[stamp_id];
	}

	// misc empty filler functions
	function hideLoading() {}
	function updateListeners() {}
}