# Install UserBased Systemd Services
You can add your own systemd starting services here, just add it and enable like below:

```bash
systemctl --user daemon-reload
systemctl --user enable --now omarchy-battery-monitor.timer || true
```
