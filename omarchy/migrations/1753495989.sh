echo "Allow updating of timezone by right-clicking on the clock (or running omarchy-cmd-tzupdate)"
if ! command -v tzupdate &>/dev/null; then
  bash ~/.local/share/omarchy/install/config/timezones.sh
  ~/.local/share/omarchy/bin/omarchy-refresh-waybar
fi
