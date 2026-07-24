#!/usr/bin/env bash
add-apt-repository ppa:cppiber/hyprland
apt-get update
apt install --assume-yes hyprlock

ln -s $PWD/hyprlock.conf $HOME/.config/hypr/hyprlock.conf
