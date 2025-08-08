echo "Install slurp + wl-screenrec for new ALT+PrintScreen screen recorder"

if ! command -v wl-screenrec &>/dev/null || ! command -v slurp &>/dev/null; then
  yay -S --noconfirm --needed slurp wl-screenrec
fi
