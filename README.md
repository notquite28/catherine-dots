# Catherine Dots

Personal dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Branches

| Branch | Platform |
|--------|----------|
| `main` | Arch Linux (Hyprland/Niri) |
| `mac` | macOS |

## Quick Start

### New Machine Setup

```bash
chezmoi init --apply git@github.com:notquite28/catherine-dots.git
```

Or step-by-step:
```bash
chezmoi init git@github.com:notquite28/catherine-dots.git
chezmoi diff        # preview changes
chezmoi apply       # apply them
```

## Common Commands

| Command | Purpose |
|---------|---------|
| `chezmoi init` | Clone repo to `~/.local/share/chezmoi` |
| `chezmoi apply` | Write files to home |
| `chezmoi diff` | Preview changes |
| `chezmoi edit <file>` | Edit source file |
| `chezmoi cd` | Enter source dir |
| `chezmoi update` | Pull + apply |
| `chezmoi re-add` | Re-add modified files |

## Workflow

### Update Configs Locally

Edit the source file (not the deployed one):
```bash
chezmoi edit ~/.config/hypr/hyprland.conf
```

With live preview:
```bash
chezmoi edit --watch ~/.config/kitty/kitty.conf
```

### Push Changes to Repo

```bash
chezmoi cd
git add .
git commit -m "update hyprland config"
git push
```

### Pull Changes from Repo

```bash
chezmoi update    # git pull + apply
```

## Managed Configs

### Compositor / WM
- `hypr/` - Hyprland compositor
- `niri/` - Niri scrollable-tiling WM

### Bars & UI
- `waybar/` - Status bar (configs for both Hyprland & Niri)
- `mako/` - Notification daemon
- `wlogout/` - Logout menu
- `rofi/` - App launcher

### Terminal
- `kitty/` - Kitty terminal
- `ghostty/` - Ghostty terminal
- `zsh/` - Zsh config

### System
- `noctalia/` - Custom theme system
- `qt5ct/` & `qt6ct/` - Qt theming
- `quickshell/` - Quickshell shell
- `waypaper/` - Wallpaper utility

### CLI Tools
- `fastfetch/` - System info
- `ohmyposh/` - Prompt theme

### Scripts
- `private_dot_local/scripts/` - Utility scripts (screenshots, wallpaper, volume, etc.)

## Dependencies

### Essential
- [chezmoi](https://www.chezmoi.io/)
- [zinit](https://github.com/zdharma-continuum/zinit)
- [oh-my-posh](https://ohmyposh.dev/)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [carapace](https://carapace-sh.github.io/carapace/)
- [eza](https://github.com/eza-community/eza)
- [fastfetch](https://github.com/fastfetch-cli/fastfetch)

### WM/Compositor
- [Hyprland](https://hyprland.org/) or [Niri](https://github.com/YaLTeR/niri)
- [waybar](https://github.com/Alexays/Waybar)
- [mako](https://github.com/emersion/mako)
- [rofi-wayland](https://github.com/lbonn/rofi)
- [wlogout](https://github.com/ArtsyMacaw/wlogout)

### Utilities
- [waypaper](https://github.com/anufrievroman/waypaper)
- [wlogout](https://github.com/ArtsyMacaw/wlogout)
- [yay](https://github.com/Jguer/yay) (AUR helper)

## Theme

Using [Catppuccin Mocha](https://github.com/catppuccin/catppuccin) with custom Noctalia variant.

Theme files located in `dot_themes/` for GTK applications.
