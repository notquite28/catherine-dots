#!/usr/bin/env bash
set -euo pipefail

# List of files and directories to add to chezmoi
DATE=$(date +%Y-%m-%d)
BACKUP_DIR="$HOME/pkg_name_bak"
PKG_FILE_NAME="pkgs_$DATE.txt"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Export package list
echo "Exporting package list to $BACKUP_DIR/$PKG_FILE_NAME"
yay -Qq >"$BACKUP_DIR/$PKG_FILE_NAME"

files=(
	"chezmoi.sh"
	".face.icon"
	".zshrc"
	"vencord.json"
	"pkg_name_bak" # Changed from absolute path to relative
	".local/scripts"
	".local/state/noctalia/settings.toml"
	".config/fastfetch"
	".config/kitty"
	".config/hypr"
	".config/niri"
	".config/ohmyposh"
	".config/rofi"
	".config/vicinae"
	".config/waybar"
	".config/noctalia"
	".config/ghostty"
	".config/quickshell"
	".config/waypaper"
	".config/wlogout"
	".config/zsh"
	".config/mako"
	".config/qt5ct"
	".config/qt6ct"
	".themes"
)

# Change to home directory
cd "$HOME" || exit 1

# Refuse to snapshot obvious local secrets into chezmoi.
if [ -e "$HOME/.zshrc.local" ] && [ -n "$(chezmoi managed "$HOME/.zshrc.local")" ]; then
	echo "ERROR: ~/.zshrc.local is managed by chezmoi; remove it before continuing" >&2
	exit 1
fi

if [ -e "$HOME/.weatherapikey" ]; then
	echo "Skipping ~/.weatherapikey; keep API keys outside chezmoi" >&2
fi

if grep -Eq '(^|[[:space:]])(export[[:space:]]+)?[A-Za-z_]*(API_KEY|TOKEN|SECRET|PASSWORD)[A-Za-z_]*=' "$HOME/.zshrc"; then
	echo "ERROR: ~/.zshrc appears to contain a secret; move it to ~/.zshrc.local first" >&2
	exit 1
fi

# Mirror deletions into the source state. `chezmoi add` updates and discovers
# files, but intentionally retains managed files that were removed at home.
echo "Removing deleted files from chezmoi..."
while IFS= read -r status_line; do
	[[ ${status_line:0:1} == "D" ]] || continue
	chezmoi forget --force -- "$HOME/${status_line:3}"
done < <(chezmoi status)

# Add package list to chezmoi
echo "Adding package list to chezmoi..."
chezmoi add "$BACKUP_DIR/$PKG_FILE_NAME"

# Loop through the files and add each one to chezmoi
echo "Adding config files to chezmoi..."
for file in "${files[@]}"; do
	if [ -e "$file" ]; then
		chezmoi add "$file"
	else
		echo "Warning: $file does not exist"
	fi
done

echo "Review changes with: chezmoi diff"
echo "Then commit manually with: chezmoi git -- status && chezmoi git -- commit -m 'update dotfiles'"

echo "Backup complete!"
