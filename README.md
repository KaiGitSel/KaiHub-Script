# KaiHub release folder

Usage: `loadstring(game:HttpGet("https://raw.githubusercontent.com/KaiGitSel/KaiHub-Script/main/loader.lua"))()`

Publish only `loader.lua`, `version.json`, `builds/`, `lib/`, `configs/` and `README.md`. `version-test.json` and `version.next.json` are local files and are never published as such (`version.next.json` is copied over `version.json` at release time, then deleted from the working tree).

## version.json (no version numbers)
```
{ "games": { "<GameId>": { "file": "builds/kaihub-<game>-<YYYYMMDD>[-n].lua", "kill": false, "message": "" } },
  "file": "<AL build, transition only>", "kill": false, "message": "", "discord": "https://discord.gg/..." }
```
- The loader matches `game.GameId` (not PlaceId; lobby and match places share it). Per-game `file` picks the build.
- No entry for the current game: "KaiHub: this game is not supported yet", nothing runs.
- `kill` / `message`: per-game value wins over the top-level one; missing = top-level applies.
- Build names must be unique on every release (`kaihub-al-20261026.lua`, same day: `kaihub-al-20261026-2.lua`). Roblox HttpGet caches by URL, so a reused name can serve the old build.
- Top-level `file` is read only by the old loader (before `games`). Keep it (AL build) during the raw.githubusercontent cache window and for anyone with an old copy; the new loader ignores it.
- Game ids: Anime Legacy (al) = 10765902945, Anime Adventures (aa) = 3183403065.

## Release steps
1. Luraph build of each changed game (Kaisel does it) -> `builds/kaihub-<game>-<YYYYMMDD>.lua`.
2. Put the exact file names into `version.next.json` (`games.*.file` and top-level `file` = AL build).
3. `copy version.next.json version.json`, delete `version.next.json`.
4. `git add loader.lua version.json builds lib configs README.md`, commit, push (Kaisel approval).
5. Check raw `version.json` and each build URL return 200.
6. Rejoin the game (HttpGet URL cache), run the loader, smoke test.
Local test: point `BASE` at a copy that serves `version-test.json` as `version.json` and run `loader.lua` in each game.

## Configs
`configs/AA-AprilFools-KaiHub.json` (single line, import through Settings -> Configs). Note: after import the bot plays by itself: it joins its own match, replays, and sets the Auto Execute flag.
