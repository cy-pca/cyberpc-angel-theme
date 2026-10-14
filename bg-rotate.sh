#!/bin/sh
# Randomly pick a background from the cyberpc-angel theme

BACKGROUND_DIR="$HOME/.local/share/omarchy/themes/cyberpc-angel/backgrounds"
STYLE_FILE="$HOME/.config/omalauncher/style/style.toml"

# List only png files (no videos)
IMAGES=$(find "$BACKGROUND_DIR" -name '*.png' -type f -printf '%f\n' | sort)

if [ -z "$IMAGES" ]; then
    echo "No PNG backgrounds found"
    exit 1
fi

# Pick random image
CHOICE=$(echo "$IMAGES" | shuf -n1)

# Update style.toml - replace the background line
sed -i "s/^background = \".*\"/background = \"$CHOICE\"/" "$STYLE_FILE"

echo "Switched to: $CHOICE"
