
systemctl --user daemon-reload


location="$HOME/.config/systemd/user"
for f in "$location"/*.service; do
    name=$(basename "$f")
    echo "Registering with systemd: ${name}"
    systemctl --user enable --now  $name || true
done
