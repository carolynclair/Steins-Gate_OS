#!/bin/bash
# Steins;Gate OS Automated Installer
set -e

echo "[SGOS] Starting installation..."

# 1. Copy GTK theme
mkdir -p ~/.themes
cp -r ../themes/steinsgate-gtk ~/.themes/

# 2. Copy wallpapers
mkdir -p ~/Pictures/SteinsGate-Wallpapers
cp -r ../assets/wallpapers/* ~/Pictures/SteinsGate-Wallpapers/

# 3. Copy sounds
mkdir -p ~/.local/share/sounds/sgos
cp -r ../assets/sounds/* ~/.local/share/sounds/sgos/

# 4. Copy Conky config
cp ../conky/memory_nodes.txt ~/.conkyrc

# 5. Copy autostart entry
mkdir -p ~/.config/autostart
cp ../autostart/conky.desktop ~/.config/autostart/

# 6. Set up systemd timers (wallpaper + Notion log push)
mkdir -p ~/.config/systemd/user
cp ../sg-notion-push.py ~/.local/bin/sg-notion-push
chmod +x ~/.local/bin/sg-notion-push
cp ../systemd/sg-notion-push.* ~/.config/systemd/user/ 2>/dev/null || true
cp ../systemd/steinsgate-wallpaper.* ~/.config/systemd/user/ 2>/dev/null || true
systemctl --user daemon-reload
systemctl --user enable --now sg-notion-push.timer 2>/dev/null || true
systemctl --user enable --now steinsgate-wallpaper.timer 2>/dev/null || true

echo "[SGOS] Installation complete! Please select the 'steinsgate-gtk' theme in your appearance settings."
