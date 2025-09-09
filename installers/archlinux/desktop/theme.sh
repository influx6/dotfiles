#!/bin/bash

# Use dark mode for QT apps too (like kdenlive)
if ! yay -Q kvantum-qt5 &>/dev/null; then
  yay -S --noconfirm kvantum-qt5
fi

# Prefer dark mode everything
if ! yay -Q gnome-themes-extra &>/dev/null; then
  yay -S --noconfirm gnome-themes-extra # Adds Adwaita-dark theme
fi

# Allow icons to match the theme
if ! yay -! yaru-icon-theme &>/dev/null; then
  yay -S --noconfirm yaru-icon-theme
fi

gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface icon-theme "Yaru-blue"

# Setup theme links
mkdir -p $Dotfiles/omarchy/themes
# for f in $Dotfiles/omarchy/themes/*; do ln -nfs "$f" $Dotfiles/omarchy/themes/; done

# Set initial theme
mkdir -p $Dotfiles/omarchy/current
ln -snf $Dotfiles/omarchy/themes/tokyo-night $Dotfiles/omarchy/current/theme
ln -snf $Dotfiles/omarchy/current/theme/backgrounds/1-scenery-pink-lakeside-sunset-lake-landscape-scenic-panorama-7680x3215-144.png $Dotfiles/omarchy/current/background

# Set specific app links for current theme
ln -snf $Dotfiles/omarchy/current/theme/neovim.lua ~/.config/nvim/lua/plugins/theme.lua

mkdir -p ~/.config/btop/themes
ln -snf $Dotfiles/omarchy/current/theme/btop.theme ~/.config/btop/themes/current.theme

mkdir -p ~/.config/mako
ln -snf $Dotfiles/omarchy/current/theme/mako.ini ~/.config/mako/config
