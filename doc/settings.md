Edit [src/settings.json](./src/settings.json), and update the game's property name, as featured in [src/json/games.json](./src/json/games.json) (e.g., for Astro Barrier, it's `"astro"`).

# `my_game`
The game name
# `myPlayer`
An object representing the penguin's clothing items. `myPlayer.<Type>` corresponds to the item ID.

For `myPlayer.Colour`, the color ID represents its ID from [player_colors.json](https://web.archive.org/web/20170329041807if_/media1.clubpenguin.com/play/en/web_service/game_configs/player_colors.json) (see the [color reference](#color-reference) below).

## Color reference
|ID|HEX|Name|
|-|-|-|
|0|0x003366|Blue|
|1|0x003366|Blue|
|2|0x009900|Green|
|3|0xff3399|Pink|
|4|0x333333|Black|
|5|0xcc0000|Red|
|6|0xff6600|Orange|
|7|0xffcc00|Yellow|
|8|0x660099|Purple|
|9|0x996600|Brown|
|10|0xff6666|Peach|
|11|0x006600|Dark Green|
|12|0x0099cc|Light Blue|
|13|0x8ae302|Lime|
|14|0x93a0a4|Sensei Gray|
|15|0x02a797|Aqua|
|16|0xf0f0d8|Arctic White|
|17|0xc378d0|Dot Lavender|

# `stamps`
A way to have certain stamps unlocked before the game launches. Some games may rely on whether or not the player owns certain stamps:
- `stamps.unlockAll`: set to `true` to unlock all stamps (overrides all other stamp settings)
- `stamps.unlockIds`: stamp IDs can be manually specified here to unlock them
- `stamps.unlockByGame`: unlocks all stamps from games if their value is `true`

`unlockIds` and `unlockByGame` can be used together, but these settings are ignored if `unlockAll` is `true`.

> **Notice:** each game instance assumes that the player only stars with whichever stamps are unlocked through the settings. If a stamp is unlocked mid-game, it will be remembered for the current session, so if you wish to have certain stamps unlocked, update your `settings.json` file.