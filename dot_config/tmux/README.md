# Tmux Cheatsheet

**Prefix Key**: `Ctrl-a` (instead of default `Ctrl-b`)

## Sessions

| Key | Action |
|-----|--------|
| `prefix + d` | Detach from session |
| `prefix + s` | Choose session |

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
| `prefix + c` | New window |
| `prefix + n` | Next window |
| `prefix + p` | Previous window |
| `prefix + 0-9` | Select window by number |
| `Alt + 1-9` | Jump directly to window 1-9 (no prefix!) |
| `prefix + w` | List windows |
| `prefix + ,` | Rename current window |
| `prefix + &` | Kill current window |

## Panes

| Key | Action |
|-----|--------|
| `prefix + \|` | Split vertically (new pane right) |
| `prefix + -` | Split horizontally (new pane below) |
| `prefix + h/j/k/l` | Select pane (vim style) |
| `Alt + h/j/k/l` | Select pane (no prefix - faster!) |
| `prefix + z` | Zoom/unzoom current pane |
| `prefix + x` | Kill current pane |
| `prefix + q` | Show pane numbers |
| `Mouse drag` | Resize panes (mouse enabled!) |

## Copy Mode (Vi-style)

| Key | Action |
|-----|--------|
| `prefix + [` | Enter copy mode |
| `v` | Begin selection (in copy mode) |
| `Ctrl-v` | Rectangle selection (in copy mode) |
| `y` | Copy selection and exit |
| `q` | Quit copy mode |
| `h/j/k/l` | Navigate (vim style) |
| `w/b` | Word forward/backward |
| `Ctrl-u` | Scroll up half page |
| `Ctrl-d` | Scroll down half page |
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |

## Miscellaneous

| Key | Action |
|-----|--------|
| `prefix + r` | Reload tmux config |
| `prefix + :` | Command prompt |
| `prefix + ?` | List all key bindings |

## Configuration Highlights

- **Base index**: Windows and panes start at 1 (easier keyboard access)
- **Renumber**: Windows automatically renumber when closed
- **Mouse**: Enabled for clicking, selecting, and resizing
- **Theme**: Catppuccin Mocha (custom)
- **Fast navigation**: Alt+hjkl for panes, Alt+1-9 for windows (no prefix!)

## Tips

1. **Instant window switching**: Use `Alt + 1` through `Alt + 9` to jump to any window instantly!
2. **Fast pane navigation**: Use `Alt + hjkl` to switch panes without pressing prefix
3. **Mouse support**: Click panes to switch, drag borders to resize
4. **Copy mode workflow**: `prefix + [` → navigate → `v` → select → `y`
5. **Intuitive splits**: `|` creates vertical split, `-` creates horizontal split

## Common Workflows

### Pane Layout Workflow
```
prefix + |          # Split vertically (new pane right)
prefix + -          # Split horizontally (new pane below)
Alt + hjkl          # Navigate between panes (no prefix needed!)
prefix + hjkl       # Navigate between panes (with prefix)
prefix + z          # Zoom focused pane
Mouse drag border   # Resize panes
```

### Copy Text from Terminal
```
prefix + [          # Enter copy mode
/search_term        # Search for text (optional)
n                   # Jump to next match
v                   # Start visual selection
hjkl                # Move to select text
y                   # Copy and exit copy mode
```
