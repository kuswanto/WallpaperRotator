#!/bin/bash

echo "========================================"
echo " Wallpaper Schedule Uninstaller"
echo "========================================"
echo ""

PLIST_NAME="com.user.wallpaperrotator.plist"
DEST_PLIST="$HOME/Library/LaunchAgents/$PLIST_NAME"
APP_PATH="/Applications/WallpaperRotator.app"
WALLPAPER_FOLDER="$HOME/Pictures/GitHubWallpapers"
WRAPPER_DIR="$HOME/Library/Application Support/WallpaperRotator"

# 1. Stop and unload the schedule
echo "🛑 Stopping the background task..."
launchctl unload "$DEST_PLIST" 2>/dev/null

# 2. Remove the LaunchAgent plist
echo "🗑️ Removing the system schedule file..."
if [ -f "$DEST_PLIST" ]; then
    rm "$DEST_PLIST"
fi

# 3. Remove the Custom Naming Shortcut
echo "🧹 Removing the naming shortcut..."
if [ -d "$WRAPPER_DIR" ]; then
    rm -rf "$WRAPPER_DIR"
fi

# 4. Remove the Automator App
echo "🗑️ Removing the Automator application..."
if [ -d "$APP_PATH" ]; then
    rm -rf "$APP_PATH"
fi

# 5. Remove the cached wallpapers
echo "🧹 Cleaning up the downloaded wallpapers cache..."
if [ -d "$WALLPAPER_FOLDER" ]; then
    rm -rf "$WALLPAPER_FOLDER"
fi

echo ""
echo "========================================"
echo " SUCCESS: The wallpaper rotation system has been completely removed."
echo " The last applied wallpaper will remain on your desktop."
echo "========================================"