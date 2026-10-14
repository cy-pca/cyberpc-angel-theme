# cyberpc-angel theme

Cyberpunk theme for [omalauncher](https://github.com/omalauncher/omalauncher) inspired by [cyberpcangel.com](https://cyberpcangel.com/). Features a dark navy background with cyan, magenta, and lavender accents.

## What's included

- **colors.toml** — Complete cyberpunk palette (navy `#0a0a24`, cyan `#00ffff`, magenta `#ff00ff`, lavender `#c8c8ff`)
- **Backgrounds** — 3 high-res PNGs from cyberpcangel.com
- **Config templates** — All `.tpl` files for themed apps (ghostty, kitty, hyprland, btop, neovim, helix, VS Code, etc.)
- **Install script** — One-command setup with background rotation

## Quick install

```bash
# Clone this repo and run
bash cyberpc-angel-install.sh
```

## Manual install

1. Copy `colors.toml` to `~/.local/share/omarchy/themes/cyberpc-angel/colors.toml`
2. Copy `backgrounds/` to `~/.local/share/omarchy/themes/cyberpc-angel/backgrounds/`
3. Set `~/.local/state/omarchy/current/theme.name` to `cyberpc-angel`
4. Update `~/.config/omalauncher/style/style.toml`:
   ```toml
   theme = "cyberpc-angel"
   background = "blue-angel-hero.png"
   ```
5. Run theme regeneration (usually `/usr/local/bin/regen-theme`)
6. Restart omalauncher

## Background rotation

`bg-rotate.sh` randomly cycles through the included backgrounds every 3 minutes. Start it in the background:

```bash
nohup bash -c 'while true; do /usr/local/bin/bg-rotate.sh >/dev/null 2>&1; sleep 180; done' &>/dev/null &
```

## Color palette

| Color | Hex | Usage |
|-------|-----|-------|
| Dark Navy | `#0a0a24` | Background |
| Lavender | `#c8c8ff` | Foreground, text |
| Cyan | `#00ffff` | Primary accent, keyboard, highlights |
| Magenta | `#ff00ff` | Secondary accent |
| Neon Green | `#00ff88` | Terminal, success states |
| Hot Red | `#ff3366` | Errors, alerts |
| Amber | `#ffaa00` | Warnings |
| Electric Blue | `#8080ff` | Blue accent |

## Applies to

- Terminals (ghostty, kitty, alacritty, foot)
- Window manager (hyprland)
- Btop system monitor
- Editors (neovim, helix, VS Code)
- Shell prompt (starship)
- Keyboard backlight (CKB)
- Chrome/Chromium
