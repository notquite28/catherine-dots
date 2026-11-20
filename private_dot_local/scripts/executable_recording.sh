#!/usr/bin/env sh
# Super+Shift+6 toggles a focused-monitor recording in Videos/Recordings.
# Capture system output audio only. SIGINT lets the recorder finalize the MP4.
set -eu

unit=desktop-recording.service
exec 9>"${XDG_RUNTIME_DIR:?}/desktop-recording-toggle.lock"
flock -n 9 || exit 0

if systemctl --user is-active --quiet "$unit"; then
	systemctl --user stop "$unit"
	notify-send -a Recording "Recording stopped" "Saved in ${XDG_VIDEOS_DIR:-$HOME/Videos}/Recordings"
	exit 0
fi

monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
[ -n "$monitor" ] || exit 1
save_dir="${XDG_VIDEOS_DIR:-$HOME/Videos}/Recordings"
mkdir -p "$save_dir"
output="$save_dir/$(date +'%Y%m%d_%H%M%S')_$$_recording.mp4"

systemd-run --user --collect --unit="$unit" --service-type=exec \
	--property=KillSignal=SIGINT \
	--property=SuccessExitStatus=SIGINT \
	--property=TimeoutStopSec=15s \
	--setenv="WAYLAND_DISPLAY=${WAYLAND_DISPLAY:?}" \
	/usr/bin/gpu-screen-recorder -w "$monitor" -f 60 -k h264 \
	-a default_output -ac aac -o "$output"
notify-send -a Recording "Recording starting on $monitor" "Press Super+Shift+6 again to stop."
