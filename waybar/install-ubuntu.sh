#!/usr/bin/env bash

# waybar is just a better status bar than is stock with sway
apt install --assume-yes waybar pavucontrol

mkdir --parents "$HOME/.config/waybar"
ln -s "$PWD/colors.css" "$PWD/style.css" "$PWD/config" "$HOME/.config/waybar/"
cp "$PWD/get-vpn-state.zsh" "$HOME/.config/waybar/"
cp "$PWD/toggle-vpn.zsh" "$HOME/.config/waybar/"

systemctl --user start waybar.service
