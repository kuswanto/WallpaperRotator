# WallpaperRotator

A macOS Automator app that fetches a random wallpaper from [jalexsan/wallpapers](https://github.com/jalexsan/wallpapers) and sets it as your desktop background. Can be scheduled to rotate automatically every hour.

## How it works

The Automator app runs an AppleScript that:

1. Queries the [GitHub API](https://docs.github.com/en/rest/git/trees) to list all files in the `jalexsan/wallpapers` repo
2. Picks a random image (PNG/JPG/JPEG)
3. Downloads it from `raw.githubusercontent.com` to `~/Pictures/GitHubWallpapers/`
4. Sets it as the desktop wallpaper via `System Events`
5. Deletes any previous wallpapers from the cache folder

## Installation

### App only (manual run)

1. Download `WallpaperRotator.zip` from the repo
2. Unzip and drag `WallpaperRotator.app` to `/Applications`
3. Double-click to run — it'll prompt for any needed permissions

### Scheduled rotation (every hour)

Run the install script:

```bash
./install_wallpaper_schedule.sh
```

**Tip:** Drag and drop the file from Finder into the terminal window instead of typing the path.

This creates a LaunchAgent that runs the app every 3600 seconds. The task appears as "WallpaperRotator" in **System Settings > General > Login Items**.

### Uninstall

```bash
./uninstall_wallpaper_schedule.sh
```

Removes the LaunchAgent, the app, and the wallpaper cache.

## Files

| File | Purpose |
|------|---------|
| `WallpaperRotator.zip` | Zipped Automator application bundle containing the AppleScript workflow |
| `com.user.wallpaperrotator.plist` | LaunchAgent property list for hourly scheduling |
| `install_wallpaper_schedule.sh` | Installs and loads the LaunchAgent |
| `uninstall_wallpaper_schedule.sh` | Unloads and removes the LaunchAgent, app, and cache |

## Permissions

On first run, macOS may ask for:

- **Automation** — permission to control `System Events` (required to change the wallpaper)
- **Files & Folders** — access to `~/Pictures` (for downloading wallpapers)

Grant these in **System Settings > Privacy & Security > Automation** if they don't prompt automatically.
