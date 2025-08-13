#!/bin/bash
# Steins;Gate OS Wallpaper Rotator
WALLPAPER_DIR="$HOME/Pictures/SteinsGate-Wallpapers"
WALLPAPERS=($WALLPAPER_DIR/*)
RANDOM_WALLPAPER="${WALLPAPERS[RANDOM % ${#WALLPAPERS[@]}]}"

# For GNOME
if command -v gsettings >/dev/null; then
  gsettings set org.gnome.desktop.background picture-uri "file://$RANDOM_WALLPAPER"
fi
# For XFCE (uncomment if needed)
# if command -v xfconf-query >/dev/null; then
#   xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s "$RANDOM_WALLPAPER"
# fi
# For KDE (uncomment if needed)
# if command -v qdbus >/dev/null; then
#   qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
#   var allDesktops = desktops();
#   for (i=0;i<allDesktops.length;i++) {
#   d = allDesktops[i];
#   d.wallpaperPlugin = 'org.kde.image';
#   d.currentConfigGroup = Array('Wallpaper', 'org.kde.image', 'General');
#   d.writeConfig('Image', 'file://$RANDOM_WALLPAPER')
#   }"
# fi
