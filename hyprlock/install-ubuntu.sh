#!/usr/bin/env bash
add-apt-repository --yes --ppa ppa:cppiber/hyprland
apt-get update
apt install --assume-yes hyprlock

mkdir --parents "$HOME/.config/hypr"
ln -s "$PWD/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"
