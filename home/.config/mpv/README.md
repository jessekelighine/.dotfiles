---
title:  "MPV"
author: "jessekelighine.com"
date:   "2023-03-07"
---

# Miscellaneous

(**2023-03-07**) Due to a problem from `yt-dlp`, YouTube cannot be played. The
error message is `EDL specifies no segments.'`.  A work-around is to patch
the script `./scripts/ytdl_hook.lua` with the following change:
```lua
-       local url = edl_track or track.url
+       local url = track.url
```
For `mpv` to use this local script, use the `--ytdl=no` option.

# Controls

- [mpv manual](https://mpv.io/manual/master/)

- `<Left>` and `<Right>`: Seek backward/forward 5 seconds.
- `<Up>` and `<Down>`: Seek forward/backward 1 minute.
- `<CR>`: Go to the next track in the playlist.
- `9` and `0`: Decrease/increase volume.
- `m`: Mute sound.
- `[` and `]`: Decrease/increase current playback speed by 10%.
- `{` and `}`: Halve/double current playback speed.

# YouTube

## Playlist

The YouTube player format is `www.youtube.com/playlist?list=` and then the list id.
For example:

```bash
mpv 'https://www.youtube.com/playlist?list=PLQVLoPxRqFQwOTsThayy9ovz69-10Pvma' --no-video # GoodGood
```
