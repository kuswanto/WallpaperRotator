#!/bin/bash

echo "========================================"
echo " Wallpaper Schedule Installer"
echo "========================================"
echo ""

PLIST_NAME="com.user.wallpaperrotator.plist"
DEST_DIR="$HOME/Library/LaunchAgents"
DEST_PLIST="$DEST_DIR/$PLIST_NAME"
WRAPPER_DIR="$HOME/Library/Application Support/WallpaperRotator"
SYMLINK_PATH="$WRAPPER_DIR/WallpaperRotator"
APP_PATH="/Applications/WallpaperRotator.app"

echo "📂 Preparing system folders..."
mkdir -p "$DEST_DIR"
mkdir -p "$WRAPPER_DIR"

echo "🏷️ Setting up display name..."
# This creates the custom shortcut so macOS reads the correct name
ln -sf /usr/bin/open "$SYMLINK_PATH"

echo "📄 Creating schedule configuration..."
# This writes the configuration file directly into the system folder
cat << EOF > "$DEST_PLIST"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.wallpaperrotator</string>
    <key>ProgramArguments</key>
    <array>
        <string>$SYMLINK_PATH</string>
        <string>-W</string>
        <string>$APP_PATH</string>
    </array>
    <key>StartInterval</key>
    <integer>3600</integer>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOF

echo "🔒 Setting security permissions..."
chmod 644 "$DEST_PLIST"

echo "🚀 Starting the background schedule..."
launchctl unload "$DEST_PLIST" 2>/dev/null
launchctl load "$DEST_PLIST"

echo ""
echo "========================================"
echo " SUCCESS: Your wallpaper schedule is live."
echo " It will now appear as 'WallpaperRotator' in Login Items."
echo "========================================"