#!/usr/bin/env sh

# Capture targets: p=all screens, s=selection, sf=frozen selection,
# m=focused monitor, w=focused window. Optional second argument: save directory.
# Editing never copies the original. Enter/Ctrl+C copies and saves the edited
# PNG, then closes; Escape cancels. Prefix --copy for clipboard-only capture.
set -eu

mode=edit
if [ "${1:-}" = "--copy" ]; then
	mode=copy
	shift
fi

case "${1:-}" in
	p) set -- screen "${2:-}" ;;
	s) set -- area "${2:-}" ;;
	sf) set -- area "${2:-}" --freeze ;;
	m) set -- output "${2:-}" ;;
	w) set -- active "${2:-}" ;;
	*)
		echo "Usage: $0 [--copy] {p|s|sf|m|w} [save-directory]" >&2
		exit 1
		;;
esac

target=$1
save_dir=${2:-${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots}
freeze=${3:-}
if [ "$mode" = edit ]; then
	mkdir -p "$save_dir"
fi
temp_dir=$(mktemp -d "${XDG_RUNTIME_DIR:-/tmp}/screenshot.XXXXXX")
temp_screenshot="$temp_dir/capture.png"
save_file="$save_dir/$(date +'%y%m%d_%Hh%Mm%Ss')_$$_screenshot.png"
shader=

restore_shader() {
	if [ -n "$shader" ]; then
		hyprshade on "$shader"
		shader=
	fi
}

cleanup() {
	restore_shader
	rm -rf -- "$temp_dir"
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

shader=$(hyprshade current)
hyprshade off

if [ -n "$freeze" ]; then
	grimblast "$freeze" save "$target" "$temp_screenshot"
else
	grimblast save "$target" "$temp_screenshot"
fi
restore_shader

if [ "$mode" = copy ]; then
	wl-copy --type image/png < "$temp_screenshot"
	notify-send -a Screenshot "Screenshot copied"
	exit 0
fi

satty --filename "$temp_screenshot" \
	--output-filename "$save_file" \
	--copy-command 'wl-copy --type image/png' \
	--save-after-copy \
	--early-exit copy \
	--actions-on-enter save-to-clipboard \
	--actions-on-escape exit
