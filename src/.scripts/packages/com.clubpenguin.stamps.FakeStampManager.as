class com.clubpenguin.stamps.FakeStampManager {
	function FakeStampManager(shell) {
	}

	/* values */
	var _myStamps = {}; // replaces _myStamps for optimization
	// var _allStamps = {byId: {}, byGroupName: {}};
	var _allStamps = {};

	/* static methods */
	static function organizeStamps(stampData) {
		// stampData is stamps.json data
		// var organized = {byId: {}, byGroupName: {}};
		var organized = {};
		var i = 0;
		var j = 0;
		while (i < stampData.length) {
			// var group = data[i];
			// var groupName = group.name;
			// var groupStamps = group.stamps;
			// organized.byGroupName[groupName] = groupStamps;
			var groupStamps = stampData[i].stamps;
			j = 0;
			while (j < groupStamps.length) {
				var stamp = groupStamps[j];
				// organized.byId[stamp.stamp_id] = stamp;
				organized[stamp.stamp_id] = stamp;
				j++;
			}
			i++;
		}
		return organized;
	}

	/* methods */
	function updateStampData(organizedStampData) {
		this._allStamps = organizedStampData;
	}
	function stampIsOwnedByMe(id) {
		console.log("stampIsOwnedByMe() called: " + id);
		console.log(com.clubpenguin.util.JSONParser.stringify(this._myStamps));
		var check = typeof this._myStamps[id] !== "undefined";
		console.log(check);
		return check;
	}
	function setRecentlyEarnedStamp(id) {
		// var stamp = this._allStamps.byId[id];
		var stamp = this._allStamps[id];
		console.log("FakeStampManager instance > setRecentlyEarnedStamp(" + id + "): typeof stamp: " + stamp);
		if (stamp) {
			this._myStamps[id] = stamp;
		} else {
			console.log("setRecentlyEarnedStamp was called but stamp did not exist. id was: " + id);
		}
	}
}