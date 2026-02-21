# Tmux Cheatsheet

**Prefix Key**: `Ctrl-a` (instead of default `Ctrl-b`)

## Sessions

| Key | Action |
|-----|--------|
| `prefix + Ctrl-d` | Detach from session |
| `prefix + S` | Choose session (built-in picker) |
| `prefix + *` | List clients |
| `prefix + o` | SessionX plugin - fuzzy session picker with zoxide |

### Command Line
```bash
tmux new -s <name>              # Create new session with name
tmux ls                          # List all sessions
tmux attach -t <name>           # Attach to session
tmux kill-session -t <name>     # Kill specific session
```

## Windows

| Key | Action |
|-----|--------|
| `prefix + Ctrl-c` | New window (opens in $HOME) |
| `prefix + H` | Previous window |
| `prefix + L` | Next window |
| `prefix + Ctrl-a` | Last window (toggle between two windows) |
| `Alt + 1-9` | Jump directly to window 1-9 (no prefix!) |
| `prefix + "` | Choose window from list |
| `prefix + w` | List windows |
| `prefix + Ctrl-w` | List windows |
| `prefix + r` | Rename current window |
| `prefix + c` | Kill current pane |

## Panes

| Key | Action |
|-----|--------|
| `prefix + \|` | Split vertically (new pane right) |
| `prefix + -` | Split horizontally (new pane below) |
| `prefix + h/j/k/l` | Select pane (vim style) |
| `Alt + h/j/k/l` | Select pane (no prefix - faster!) |
| `prefix + z` | Zoom/unzoom current pane |
| `prefix + x` | Swap pane down |
| `prefix + c` | Kill current pane |
| `prefix + P` | Toggle pane border status |
| `Mouse drag` | Resize panes (mouse enabled!) |

## Copy Mode (Vi-style)

| Key | Action |
|-----|--------|
| `prefix + [` | Enter copy mode |
| `v` | Begin selection (in copy mode) |
| `Ctrl-v` | Rectangle selection (in copy mode) |
| `y` | Copy to system clipboard (Wayland/wl-copy) |
| `Mouse drag` | Select and auto-copy to clipboard |
| `q` | Quit copy mode |
| `h/j/k/l` | Navigate (vim style) |
| `w/b` | Word forward/backward |
| `$` | End of line |
| `0` | Start of line |
| `Ctrl-u` | Scroll up half page |
| `Ctrl-d` | Scroll down half page |
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |

## Plugins

| Key | Action |
|-----|--------|
| `prefix + u` | FZF URL picker - extract and open URLs from pane |
| `prefix + I` | TPM - install plugins |
| `prefix + U` | TPM - update plugins |

### Plugin Features

**Tmux Resurrect/Continuum**
- Auto-saves session every 15 minutes
- Restores on tmux start (continuum enabled)
- `prefix + Ctrl-s` - Manual save
- `prefix + Ctrl-r` - Manual restore

**Tmux SessionX**
- Fuzzy session finder with zoxide integration
- Preview of session windows
- Create/delete sessions from picker
- `Alt + Backspace` (in picker) - Delete selected session
- `Ctrl + r` (in picker) - Rename session
- `Ctrl + w` (in picker) - Window mode
- `?` (in picker) - Toggle preview

**Tmux FZF URL**
- Extracts and opens URLs from terminal output
- Great for opening links from logs

## Miscellaneous

| Key | Action |
|-----|--------|
| `prefix + *` | Toggle synchronize panes (send input to all panes) |
| `prefix + P` | Toggle pane border status |
| `prefix + R` | Reload tmux config |
| `prefix + Ctrl-l` | Refresh client |
| `prefix + :` | Command prompt |
| `prefix + Ctrl-x` | Lock server |

## Configuration Highlights

- **Base index**: Windows and panes start at 1 (easier keyboard access)
- **History**: 1 million lines (vs default 2,000)
- **Clipboard**: System clipboard integration via wl-copy (Wayland)
- **Escape time**: 0ms (better vim/neovim experience)
- **Renumber**: Windows automatically renumber when closed
- **Mouse**: Enabled for clicking, selecting, and resizing
- **Status bar**: Positioned at top
- **Theme**: Catppuccin with rounded window style
- **Fast navigation**: Alt+hjkl for panes, Alt+1-9 for windows (no prefix!)
- **Plugins**: 6 active plugins (TPM, yank, resurrect, continuum, fzf-url, catppuccin, sessionx)

## Tips

1. **Instant window switching**: Use `Alt + 1` through `Alt + 9` to jump to any window instantly!
2. **Quick previous window**: `prefix + Ctrl-a` toggles between your last two windows (like `cd -`)
3. **Fast pane navigation**: Use `Alt + hjkl` to switch panes without pressing prefix
4. **Mouse support**: Click panes to switch, drag borders to resize, drag to select text
5. **Copy mode workflow**: `prefix + [` → navigate → `v` → select → `y` (copies to system clipboard!)
6. **Synchronized panes**: Use `prefix + *` to send commands to all panes at once
7. **URL extraction**: `prefix + u` finds all URLs in current pane - great for opening links from logs
8. **Session workflow**: Use `prefix + o` (sessionx) for fast project switching with zoxide
9. **Intuitive splits**: `|` creates vertical split (looks like a divider), `-` creates horizontal split

## Common Workflows

### Quick Session Creation
```bash
# From terminal
tmux new -s project

# Or use sessionx (prefix + o) to create/switch interactively
```

### Pane Layout Workflow
```
prefix + |          # Split vertically (new pane right) - intuitive!
prefix + -          # Split horizontally (new pane below) - intuitive!
Alt + hjkl          # Navigate between panes (no prefix needed!)
prefix + hjkl       # Navigate between panes (with prefix)
prefix + z          # Zoom focused pane
Mouse drag border   # Resize panes (easier than keyboard!)
```

### Copy Text from Terminal
```
prefix + [          # Enter copy mode (IMPORTANT: do this first!)
/search_term        # Search for text (optional)
n                   # Jump to next match
v                   # Start visual selection
jjj or kkk          # Move to select text
y                   # Copy to system clipboard and exit

# Or use mouse
prefix + [          # Enter copy mode
Mouse drag          # Select text (auto-copies on release)
```
