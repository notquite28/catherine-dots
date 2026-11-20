# Desktop workflow and recovery

Updated 2026-11-20. This records the Hyprland workflow changes, the retained Niri integration, and the settings captured by `~/chezmoi.sh`.

## Configuration ownership

- Hyprland uses `~/.config/hypr/hyprland.lua` and its `lua/` modules.
- Noctalia v5 owns the bar, notifications, wallpaper, theme generation, session UI, and idle locking. User configuration is `~/.config/noctalia/config.toml`; GUI overrides in `~/.local/state/noctalia/settings.toml` take precedence. The old JSON settings are not the active configuration.
- Vicinae owns clipboard history. Noctalia's `shell.clipboard_enabled` and `shell.clipboard_keep_from_closed_apps` are both false. Standalone cliphist watchers were removed from Hyprland and Niri startup.
- SDDM/start-hyprland remains the session architecture. UWSM was not introduced. Audio and portal services retain systemd/D-Bus activation; redundant manual environment imports and portal startup were removed.
- The portal override at `~/.config/xdg-desktop-portal/portals.conf` uses `default=hyprland;gtk`. Hyprland handles supported capture interfaces, with GTK providing fallback interfaces such as FileChooser and Settings.
- Existing phone tools, hyprpicker, developer tooling, and wireless controls were retained. No additional phone integration was installed.

## Shortcuts

| Shortcut | Action |
|---|---|
| Super+Shift+3 | Edit the focused monitor screenshot |
| Super+Shift+4 | Edit a frozen region screenshot |
| Super+Shift+5 | Edit the focused window screenshot |
| Add Ctrl to those screenshot shortcuts | Copy immediately without opening an editor or saving a permanent file |
| Super+V | Open Vicinae clipboard history |
| Super+Shift+P | Pick a color and copy it |
| Alt+Tab / Alt+Shift+Tab | Open Noctalia's MRU window switcher forward / backward |
| Super+Shift+6 | Start or stop focused-monitor recording |
| Super+Alt+L | Lock the session |
| Super+Shift+E | Graceful logout |
| Super+Shift+O | Manually turn monitors off through Noctalia IPC |

Niri retains its Noctalia and Rofi launcher bindings. Its terminal shortcut uses Ghostty, clipboard history uses Vicinae, and the session-menu shortcut uses Noctalia.

## Screenshots

`~/.local/scripts/screenshot.sh` keeps the unedited capture in a unique runtime directory and opens Satty. Opening or cancelling the editor does not copy the original or save a permanent image. Enter or Ctrl+C copies and saves the finished PNG, then closes the editor. Escape cancels editing. Output goes to `${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots`, unless a second directory argument is supplied.

The `--copy` mode is deliberately different: it copies the original immediately and does not open Satty or save a permanent screenshot. Do not use it for an image that needs redaction first.

Satty opens centered at 1100x800. Its window rule uses `1.0 override` for active and inactive opacity. A plain `1.0` is only a multiplier and still inherits global compositor transparency. Noctalia's native annotator was compared with Satty; its fullscreen layer overlay was not substituted for the requested floating editor. Swappy was uninstalled.

## Clipboard policy and the Vesktop investigation

Vicinae keeps unpinned, untagged history for 30 days, ignores supported password-manager hints, and preserves pinned or tagged entries. Sensitive content without a recognized hint can still enter history.

Vicinae 0.30.1 has no configurable entry-count cap. Keeping its rich history view with 30-day expiry and no count cap was explicitly chosen over replacing it with a bounded storage backend. Do not mistake a history page-size limit for a retention cap.

Raw PNG paste into Vesktop and selecting an image in Vicinae followed by Enter were checked separately. Earlier logs showed clipboard-write confirmation timeouts and later history-row update failures. A temporary Vicinae profile successfully delivered an image through a real Enter-to-paste action into a local native receiver. Targeted checks of the original `selection` and `data_offer` tables passed. The original profile was restored and Vicinae restarted; the user then confirmed Enter-to-paste worked in Vesktop with the original history.

The underlying update failure was not conclusively identified. No claim is made that an upstream Vicinae code regression was patched. No history reset, database repair, or downgrade was performed.

If the problem returns, distinguish these paths before changing screenshot tools:

1. Copy a harmless PNG and try Ctrl+V in Vesktop.
2. Select that image in Vicinae and press Enter with Vesktop's message box as the destination.
3. Inspect `vicinae logs -n 50` for confirmation timeouts or history-update errors. Logs can contain application and window titles; redact them before sharing.
4. Check for additional clipboard collectors or persistence tools. Do not clear the database as a first troubleshooting step.

Existing clipboard databases and old favorites remain local and are not part of the snapshot. They may contain images copied before the private-edit workflow was introduced.

## Idle, logout, and default applications

Idle lock is enabled after 600 seconds. Idle screen-off and automatic suspend are explicitly disabled. Manual monitor-off remains available through its shortcut.

Hyprland's logout shortcut and Noctalia's logout action call `~/.local/scripts/compositor-logout.sh`, which selects the current desktop using `XDG_CURRENT_DESKTOP`. Hyprland uses hyprshutdown; Niri retains its native quit path. The helper was verified with `--dry-run --no-fork`, without closing applications or exiting the session.

Folders use Dolphin, common image formats use Gwenview, and PDFs use Okular. KDE terminal actions and the shared Hyprland terminal variable use Ghostty. These settings are captured in `~/.config/mimeapps.list`, `~/.config/kdeglobals`, and the Hyprland configuration.

Gwenview, Okular, and hyprshutdown were installed. Okular's Phonon dependency uses the enabled repository's MPV backend because the VLC dependency downloads failed on available mirrors. Package signature checking was not disabled. The dated package inventory records the installed package names, not a portable installation script.

## Recording

`~/.local/scripts/recording.sh` toggles a transient `desktop-recording.service`. It records the monitor focused at start, at 60 FPS, with H.264 video and AAC system-output audio. The microphone is not captured.

Files are written to `${XDG_VIDEOS_DIR:-$HOME/Videos}/Recordings`. Stopping sends SIGINT and waits for the recorder to finalize the MP4. The service can also be stopped with:

```sh
systemctl --user stop desktop-recording.service
```

For failures, inspect:

```sh
journalctl --user -u desktop-recording.service
```

A short recording was verified with ffprobe, and a frame was decoded successfully. The temporary test recording was deleted.

## Archived and legacy settings

The snapshot script includes `~/.local/state/desktop-workflow-archive`, including the 2026-11-20 archive:

- `noctalia-settings.json` and `noctalia-plugins.json`: legacy Noctalia settings and plugin registry.
- `wallpaper.sh`, `wallcache.sh`, and `noctalia-wallpaper-hook.sh`: retired swww/cache workflow. No active cache consumer was found; editor-history references were not treated as active consumers.
- `generate-rofi-theme.sh`: retired JSON-based generator. The active Noctalia TOML template still generates the Rofi theme.
- `cliphist.sh`: retired helper that depended on missing Fuzzel and mixed a POSIX sh shebang with Bash-only syntax.

These files are historical references, not startup hooks. They are outside the active scripts directory. Do not copy the whole archive back into live configuration.

Older Hyprland backups under `~/.config/hypr/old-conf-backups/` and `hyprland.lua.bak`, and legacy Noctalia `colors.json`, remain included through the existing directory snapshot rules. They are not the active configuration.

## Snapshot and restore

Run:

```sh
~/chezmoi.sh
```

The script exports the package inventory, mirrors local deletions out of the source state, captures active settings and the workflow archive, and stops on detected secrets. It does not commit, push, install packages, or apply the source state back over the live desktop. Review and publish using the repository's README workflow.

To locate an archived source file without assuming chezmoi's encoded directory names:

```sh
chezmoi source-path ~/.local/state/desktop-workflow-archive/2026-11-20/noctalia-settings.json
```

On another machine, review monitor names, NVIDIA environment settings, home-directory paths, and lock-screen layout before applying:

```sh
chezmoi diff
chezmoi apply
noctalia msg config-reload
hyprctl reload config-only
hyprctl configerrors
```

Applying the new source state does not necessarily remove old files that have become unmanaged on another machine. Archive any old live Noctalia JSON settings and retired helper scripts there rather than reactivating them.

Useful policy checks:

```sh
noctalia msg config-get idle
noctalia msg config-get shell.clipboard_enabled
noctalia msg config-get shell.clipboard_keep_from_closed_apps
niri validate -c ~/.config/niri/config.kdl
```

Repository-only documentation stays under `docs/`, excluded from application into the home directory by `.chezmoiignore`.

## References

- [Hyprland useful utilities](https://wiki.hypr.land/useful-utilities/)
- [Noctalia 5.5 configuration](https://docs.noctalia.dev/noctalia/v5.5.0/configuration/)
- [Noctalia idle behavior](https://docs.noctalia.dev/noctalia/v5.5.0/services/idle/)
- [Vicinae clipboard management](https://docs.vicinae.com/clipboard)
- [hyprshutdown](https://wiki.hypr.land/hypr-ecosystem/user/hyprshutdown/)
