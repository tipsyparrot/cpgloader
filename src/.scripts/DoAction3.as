// DoAction[3]
// main script


// originally used the syntax below
// (before creating the settings.json file)
// this way (by wrapping the object with an array) we can add a full object
// without having to create an empty one and them filling it up with properties individually :)
// might come in handy later...
//
// also, used to store the game to play here. it's easy and user-friendly to keep all the functionality an logic
// in DoAction and DoAction[2], while just initiating from DoAction[3], but it's much easier to make it editable
// via the settings.json file, since you don't need a special program to change it from the actual swf
//
// var settings = [
// 	{
// 		myPlayer: {
// 			Colour: 5,
// 			Hand: 751
// 		}
// 	}
// ];
// var my_game = "fish";
//init(this, my_game, settings[0]);
init(this);

// this.debugText.onScroller = function(dbt) {
// 	dbt.______x = dbt.scroll;
// };