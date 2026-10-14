#!/bin/bash
# Install the cyberpc-angel theme on any omalauncher setup
# Run as root: bash cyberpc-angel-install.sh

set -euo pipefail

THEME_DIR="$HOME/.local/share/omarchy/themes"
CURRENT_DIR="$HOME/.local/state/omarchy/current"
STYLE_DIR="$HOME/.config/omalauncher/style"
TEMPLATES_DIR="$HOME/.local/share/omarchy/default/themed"

echo "🤖 Installing cyberpc-angel theme for omalauncher..."
echo ""

# 1. Create theme directory
mkdir -p "$THEME_DIR/cyberpc-angel/backgrounds"

# 2. Copy colors.toml
cat > "$THEME_DIR/cyberpc-angel/colors.toml" << 'COLORS'
mode = "dark"

accent = "#00ffff"
selection = "#0a0a24"
muted = "#64649e"

background = "#0a0a24"
dark_background = "#07071c"
darker_background = "#050514"
lighter_background = "#12123a"

foreground = "#c8c8ff"
dark_foreground = "#50508a"
light_foreground = "#a0a0dd"
bright_foreground = "#c8c8ff"

red = "#ff3366"
yellow = "#ffaa00"
orange = "#ff6633"
green = "#00ff88"
cyan = "#00ffff"
blue = "#8080ff"
magenta = "#ff00ff"
brown = "#3a2a4a"

bright_red = "#ff6688"
bright_yellow = "#ffcc44"
bright_green = "#33ffaa"
bright_cyan = "#66ffff"
bright_blue = "#aaaaff"
bright_magenta = "#ff44ff"
COLORS

echo "  ✅ colors.toml"

# 3. Copy backgrounds
echo "  📷 Place backgrounds in:"
echo "     $THEME_DIR/cyberpc-angel/backgrounds/"
echo ""
echo "  Recommended backgrounds from cyberpcangel.com:"
echo "    - 01-blue-angel.png    (blue angel character icon)"
echo "    - 02-cyber-hd.png      (cyberpunk cityscape 2048x2048)"
echo "    - 03-hans-bg.png       (hans variant 2048x2048)"
echo ""
echo "  Download URLs:"
echo "    curl -O https://cyberpcangel.com/wp-content/uploads/2024/12/cyberpc_0.png"
echo "    curl -O https://cyberpcangel.com/wp-content/uploads/2024/10/local__txt2img__q8_0__euler_a__Juggernaut-X-RunDiffusion-NSFW.safetensors__24176_3.png"
echo "    curl -O https://cyberpcangel.com/wp-content/uploads/2024/10/local__txt2img__q8_0__euler_a__hans-v4.4.safetensors__18719.png"
echo ""

# 4. Set theme
echo -n "cyberpc-angel" > "$CURRENT_DIR/theme.name"
echo "  ✅ theme.name → cyberpc-angel"

# 5. Update style.toml
if [ -f "$STYLE_DIR/style.toml" ]; then
    sed -i 's/^theme = ".*/theme = "cyberpc-angel"/' "$STYLE_DIR/style.toml"
    echo "  ✅ style.toml theme updated"
else
    mkdir -p "$STYLE_DIR"
    cat > "$STYLE_DIR/style.toml" << 'STYLE'
version = 1
theme = "cyberpc-angel"
STYLE
    echo "  ✅ style.toml created"
fi

# 6. Update backgrounds symlink
# The launcher reads the background from style.toml, not a symlink
# but we also update the symlink for consistency
BG_NAME="${1:-blue-angel-hero.png}"
if [ -f "$THEME_DIR/cyberpc-angel/backgrounds/$BG_NAME" ]; then
    sed -i "s/^background = \".*\"/background = \"$BG_NAME\"/" "$STYLE_DIR/style.toml"
    ln -sf "$THEME_DIR/cyberpc-angel/backgrounds/$BG_NAME" "$CURRENT_DIR/background" 2>/dev/null || true
    echo "  ✅ background → $BG_NAME"
else
    echo "  ⚠️  Background '$BG_NAME' not found, keeping current"
fi

# 7. Regenerate themed configs
echo ""
echo "  Running theme regeneration..."
if [ -f /usr/local/bin/regen-theme ]; then
    /usr/local/bin/regen-theme
    echo "  ✅ themed configs regenerated"
elif [ -f /root/regen-theme.sh ]; then
    /root/regen-theme.sh
    echo "  ✅ themed configs regenerated"
else
    echo "  ⚠️  No regen script found — regenerate with:"
    echo "     /usr/bin/env -i bash /root/regen-theme.sh"
fi

# 8. Setup background rotation
if [ ! -f /usr/local/bin/bg-rotate.sh ]; then
    cat > /usr/local/bin/bg-rotate.sh << 'ROTATE'
#!/bin/bash
BDIR="$HOME/.local/share/omarchy/themes/cyberpc-angel/backgrounds"
STYLE="$HOME/.config/omalauncher/style/style.toml"
IMGS=$(find "$BDIR" -name '*.png' -type f -printf '%f\n' 2>/dev/null)
if [ -z "$IMGS" ]; then exit 1; fi
CHOICE=$(echo "$IMGS" | shuf -n1)
sed -i "s/^background = \".*\"/background = \"$CHOICE\"/" "$STYLE"
ROTATE
    chmod +x /usr/local/bin/bg-rotate.sh
    echo "  ✅ bg-rotate.sh created"
fi

# 9. Start background rotation if not running
if ! pgrep -f bg-rotate.sh > /dev/null 2>&1; then
    nohup bash -c 'while true; do /usr/local/bin/bg-rotate.sh > /dev/null 2>&1; sleep 180; done' &>/dev/null &
    echo "  ✅ background rotation started (every 3 min)"
fi

echo ""
echo "🤖 Installation complete!"
echo ""
echo "  Restart omalauncher (close from recent apps, reopen) to apply."
echo "  The launcher will cycle through all backgrounds every 3 minutes."
echo ""
