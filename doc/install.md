To install the game:

```sh
git clone https://github.com/tipsyparrot/cpgloader.git
```
The main script's structure is stored in the `src/` folder.

# Setting up games
Download the full game's directory and its associated sub directories, as can be found in [solero's archive](https://icerink.solero.me/media1.clubpenguin.com/play/v2/games/). Save under `src/games`

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

> **Note:** there's no need to download every language folder.

Then, update [`settings.json`](../src/settings.json) in the project's root, and change the `my_game` value to the game's property name key, as can be found in [`games.json`](../src/json/games.json).

Note that this value may not necessarily be the game's folder name. For instance, for Aqua Grabber, the game's folder is called `sub`, while its [`games.json`](../src/json/games.json) property is `aqua`.

Once you're ready, you can launch [loader.swf](../src/loader.swf).

If the game's music is missing, download its music swf (can be found in its wiki's game page) to [src/music](../src/music).