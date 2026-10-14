# cyberpc-angel theme

Cyberpunk theme for [omalauncher](https://github.com/omalauncher/omalauncher) — designed from the [cyberpcangel.com](https://cyberpcangel.com/) website aesthetic.

## Colors

| Role | Hex | Description |
|------|-----|-------------|
| background | `#0a0a24` | Dark navy |
| foreground | `#c8c8ff` | Lavender |
| cyan | `#00ffff` | Neon cyan (accents, keyboard) |
| magenta | `#ff00ff` | Hot magenta (highlights) |
| green | `#00ff88` | Neon green (success, terminal) |
| red | `#ff3366` | Hot red (errors, alerts) |
| yellow | `#ffaa00` | Amber (warnings) |

## Quick install

```bash
# Download everything
curl -O https://raw.githubusercontent.com/cy-pca/cyberpc-angel-theme/main/cyberpc-angel-install.sh
curl -O https://raw.githubusercontent.com/cy-pca/cyberpc-angel-theme/main/bg-rotate.sh
curl -O https://raw.githubusercontent.com/cy-pca/cyberpc-angel-theme/main/colors.toml

chmod +x cyberpc-angel-install.sh bg-rotate.sh
bash cyberpc-angel-install.sh
```

Then restart omalauncher (close from recent apps, reopen).

## Manual install

1. Place `colors.toml` at `~/.local/share/omarchy/themes/cyberpc-angel/colors.toml`
2. Create `backgrounds/` directory and drop in `.png` files
3. Set `~/.local/state/omarchy/current/theme.name` to `cyberpc-angel`
4. Update `~/.config/omalauncher/style/style.toml`:
   ```toml
   theme = "cyberpc-angel"
   background = "blue-angel-hero.png"
   ```
5. Run theme regeneration (usually `/usr/bin/env -i bash /root/regen-theme.sh`)
6. Restart omalauncher

## Background rotation

`bg-rotate.sh` picks a random background PNG every 3 minutes. Run in the background:

```bash
nohup bash -c 'while true; do /usr/local/bin/bg-rotate.sh >/dev/null 2>&1; sleep 180; done' &>/dev/null &
```

This updates `style.toml` in real time — the launcher picks up the change immediately.

## Backgrounds included

| File | Size | Source |
|------|------|--------|
| `blue-angel-hero.png` | 256×256 | Blue angel character icon |
| `cyber-hd.png` | 2048×2048 | Cyberpunk cityscape |
| `hans-bg.png` | 2048×2048 | Hans variant |

All images from cyberpcangel.com:
- https://cyberpcangel.com/wp-content/uploads/2024/12/cyberpc_0.png
- https://cyberpcangel.com/wp-content/uploads/2024/10/local__txt2img__q8_0__euler_a__Juggernaut-X-RunDiffusion-NSFW.safetensors__24176_3.png
- https://cyberpcangel.com/wp-content/uploads/2024/10/local__txt2img__q8_0__euler_a__hans-v4.4.safetensors__18719.png

## Applies to

- Terminal emulators (kitty, ghostty, alacritty, foot)
- Window manager (hyprland)
- Btop (system monitor)
- Neovim, Helix, VS Code
- Shell prompt (starship)
- Keyboard backlight (CKB)
- Chrome/Chromium
