# Tmux Cheatsheet

**Prefix Key**: `Ctrl-a` (instead of default `Ctrl-b`)

## Sessions

| Key | Action |
|-----|--------|
| `prefix + d` | Detach from session |
| `prefix + S` | Choose session (built-in picker) |
| `prefix + o` | SessionX plugin - fuzzy session picker with zoxide |
| `prefix + Ctrl-y` (in sessionx) | Create new window from selection |

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
| `prefix + "` | Choose window from list |
| `prefix + w` | List windows |
| `prefix + Ctrl-w` | List windows |
| `prefix + r` | Rename current window |
| `prefix + c` | Kill current pane |

## Panes

| Key | Action |
|-----|--------|
| `prefix + s` | Split horizontally (new pane below) |
| `prefix + v` | Split vertically (new pane right) |
| `prefix + \|` | Split window (default) |
| `prefix + h` | Select pane left |
| `prefix + j` | Select pane down |
| `prefix + k` | Select pane up |
| `prefix + l` | Select pane right |
| `prefix + z` | Zoom/unzoom current pane |
| `prefix + x` | Swap pane down |
| `prefix + K` | Clear pane |

### Resize Panes (Repeatable)

| Key | Action |
|-----|--------|
| `prefix + ,` | Resize pane left (20 cols) |
| `prefix + .` | Resize pane right (20 cols) |
| `prefix + -` | Resize pane down (7 rows) |
| `prefix + =` | Resize pane up (7 rows) |

**Note**: These are repeatable (-r flag), so you can press `prefix` once then hit the resize key multiple times.

## Copy Mode (Vi-style)

| Key | Action |
|-----|--------|
| `prefix + [` | Enter copy mode |
| `v` | Begin selection (in copy mode) |
| `y` | Yank/copy (tmux-yank plugin) |
| `q` | Quit copy mode |
| `Ctrl-u` | Scroll up half page |
| `Ctrl-d` | Scroll down half page |
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |

## Plugins

| Key | Action |
|-----|--------|
| `prefix + p` | Floax - floating terminal window |
| `prefix + u` | FZF URL picker - extract and open URLs from pane |
| `prefix + I` | TPM - install plugins |
| `prefix + U` | TPM - update plugins |

### Plugin Features

**Tmux Resurrect/Continuum**
- Auto-saves session every 15 minutes
- Restores on tmux start (continuum enabled)
- `prefix + Ctrl-s` - Manual save
- `prefix + Ctrl-r` - Manual restore

**Tmux Thumbs**
- `prefix + Space` - Hint mode for copying text

**Tmux SessionX**
- Fuzzy session finder with zoxide integration
- Preview of session windows
- Create/delete sessions from picker

**Tmux Floax**
- Opens floating terminal (80% width/height)
- Magenta border, changes to pane directory

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

- **Base index**: Windows start at 1 (easier keyboard access)
- **History**: 1 million lines (vs default 2,000)
- **Clipboard**: System clipboard integration enabled
- **Escape time**: 0ms (better vim/neovim experience)
- **Renumber**: Windows automatically renumber when closed
- **Status bar**: Positioned at top
- **Detach behavior**: Stays in tmux when closing sessions

## Tips

1. **Quick window switching**: `prefix + Ctrl-a` toggles between your last two windows (like `cd -`)
2. **Synchronized panes**: Use `prefix + *` to send commands to all panes at once
3. **URL extraction**: `prefix + u` finds all URLs in current pane - great for opening links from logs
4. **Session workflow**: Use `prefix + o` (sessionx) for fast project switching with zoxide
5. **Floating terminals**: `prefix + p` opens a centered floating terminal (perfect for quick commands)
6. **Copy mode navigation**: Use vim motions (`hjkl`, `w`, `b`, `$`, `0`, etc.) in copy mode

## Common Workflows

### Quick Session Creation
```bash
# From terminal
tmux new -s project

# Or use sessionx (prefix + o) to create/switch interactively
```

### Pane Layout Workflow
```
prefix + v          # Split vertically
prefix + s          # Split horizontally in new pane
prefix + hjkl       # Navigate between panes
prefix + z          # Zoom focused pane
prefix + ,.         # Resize as needed
```

### Copy Text from Terminal
```
prefix + [          # Enter copy mode
/search_term        # Search for text
v                   # Start selection
y                   # Yank/copy
```
