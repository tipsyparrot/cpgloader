This project is meant for creating an easy way for loading and playing Club Penguin files.

The goal is to allow downloading a game's assets and running them as-is, with no modification of the original files as much as possible (e.g. security check removal, insertion of shells, adding player data, etc.), while only having to run [`loader.swf`](./src/loader.swf)

# To-do List
- Implement stamps unlockling via `settings.json`
- `lang` in settings
- add scroll bar to debug window

# How to use
## Downloading game files
First, download the full game's directory and its associated sub directories, as can be found in [solero's archive](https://icerink.solero.me/media1.clubpenguin.com/play/v2/games/). Save under [src/games](./src/games).

For instance, in the case of Astro Barrier, the file structure would be:
```
src
├── games
│   ├── astro
│   │   ├── AstroBarrier.swf
│   │   ├── bootstrap.swf
│   │   └── lang
│   │       └── en
│   │           └── locale.swf
```

> **Note:** it's okay to skip language folders that you're not going to use. In this example, only the `lang/en/` folder is used.

## Updating settings
Edit [src/settings.json](./src/settings.json), and update the game's property name, as featured in [src/json/games.json](./src/json/games.json) (e.g., for Astro Barrier, it's `"astro"`).

### Settings
### `my_game`
The game name
### `myPlayer`
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

# Modified classes
`loader.swf` incorporates some classes with dependencies, some of which have been modified:
- `helper.Console`- a custom class for creating a visual logger
- `com.clubpenguin.shell.FakeShell`- takes the main bare minimum functionality from `/play/v2/client/shell.swf`, and modifies some of its retrun values.
- `com.clubpenguin.security.Security`- removed the entire class body, and changed the static `com.clubpenguin.security.Security.doSecurityCheck` method to always returns `true`;