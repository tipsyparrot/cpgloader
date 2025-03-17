This project is meant for loading Club Penguin minigames.

# Installation
Please refer to the following docs:
- [Installation](./doc/install.md)
- [Custom settings](./doc/settings.md)
- [Per-game notes](./doc/game_notes.md)

# To-do List
- fix `stamps.unlockAll` in `settings.json`- causes an infinite loop
- implement `lang` in settings
- add scroll bar to debug window
- support as3 games

# Modified classes
`loader.swf` incorporates some classes with dependencies, some of which have been modified:
- `helper.Console`- a custom class for creating a visual logger
- `com.clubpenguin.shell.FakeShell`- takes the main bare minimum functionality from `/play/v2/client/shell.swf`, and modifies some of its retrun values.
- `com.clubpenguin.stamps.FakeStampManager`- a more minimal and more optimized version of the original `com.clubpenguin.stamps.StampManager` class.
- `com.clubpenguin.security.Security`- removed the entire class body, and changed the static `com.clubpenguin.security.Security.doSecurityCheck` method to always returns `true`.