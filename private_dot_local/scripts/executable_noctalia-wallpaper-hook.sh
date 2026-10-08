#!/usr/bin/env bash
set -euo pipefail

wallpaper="${NOCTALIA_WALLPAPER_PATH:-}"
[[ -f "$wallpaper" ]] || exit 0

runtime_dir="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
exec 9>"$runtime_dir/noctalia-wallpaper-hook.lock"
flock 9

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}"
if [[ -s "$cache_dir/wall.set" && -s "$cache_dir/wall.blur" ]] && cmp -s "$wallpaper" "$cache_dir/wall.set"; then
    exit 0
fi

"$HOME/.local/scripts/wallcache.sh" "$wallpaper"
