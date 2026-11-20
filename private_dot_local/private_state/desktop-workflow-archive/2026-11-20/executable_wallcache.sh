#!/usr/bin/env bash
set -euo pipefail

wallpaper="${1:-}"
[[ -f "$wallpaper" ]] || {
    printf 'wallcache: wallpaper is not a file: %s\n' "$wallpaper" >&2
    exit 1
}

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}"
mkdir -p "$cache_dir"

work_dir="$(mktemp -d "$cache_dir/.wallcache.XXXXXX")"
trap 'rm -rf "$work_dir"' EXIT

cp -- "$wallpaper" "$work_dir/wall.set"
magick "$wallpaper" -blur 0x25 "$work_dir/wall.blur"

# Publish the original last. It is the cache generation marker checked by the
# Noctalia hook, so a failed blur render cannot suppress the next retry.
mv -f "$work_dir/wall.blur" "$cache_dir/wall.blur"
mv -f "$work_dir/wall.set" "$cache_dir/wall.set"

if pgrep -x niri >/dev/null && [[ -x "$HOME/.config/niri/scripts/niri-backdrop.sh" ]]; then
    "$HOME/.config/niri/scripts/niri-backdrop.sh" &
fi
