#!/usr/bin/env sh

# Use the current session, not whichever compositor happens to be running.
# Hyprland accepts hyprshutdown options, including --dry-run for a safe preview.
case ":${XDG_CURRENT_DESKTOP:-}:" in
	*:Hyprland:*|*:hyprland:*)
		exec hyprshutdown "$@"
		;;
	*:niri:*)
		exec niri msg action quit
		;;
	*)
		echo "Unsupported desktop: ${XDG_CURRENT_DESKTOP:-unset}" >&2
		exit 1
		;;
esac

