# Catherine Dots

Personal dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Branches

| Branch | Platform |
|--------|----------|
| `main` | Arch Linux (Hyprland/Niri) |
| `mac` | macOS |

## Quick Start

### New Machine Setup

**macOS (mac branch):**
```bash
chezmoi init --apply git@github.com:notquite28/catherine-dots.git --branch mac
```

**Arch Linux (main branch):**
```bash
chezmoi init --apply git@github.com:notquite28/catherine-dots.git
```

Or step-by-step:
```bash
chezmoi init --branch mac git@github.com:notquite28/catherine-dots.git
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
chezmoi edit ~/.config/zsh/.zshrc
```

With live preview:
```bash
chezmoi edit --watch ~/.config/kitty/kitty.conf
```

### Push Changes to Repo

```bash
chezmoi cd
git add .
git commit -m "update zsh config"
git push
```

### Pull Changes from Repo

```bash
chezmoi update    # git pull + apply
```

## Managed Files (mac branch)

- `~/.zshrc`
- `~/.config/zsh/.zshrc`
- `~/.config/ghostty/config`
- `~/.config/kitty/kitty.conf`
- `~/.config/fastfetch/config.jsonc`

## Dependencies

- [chezmoi](https://www.chezmoi.io/)
- [zinit](https://github.com/zdharma-continuum/zinit)
- [oh-my-posh](https://ohmyposh.dev/)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [carapace](https://carapace-sh.github.io/carapace/)
- [eza](https://github.com/eza-community/eza)
- [fastfetch](https://github.com/fastfetch-cli/fastfetch)
