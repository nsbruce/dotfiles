#!/usr/bin/env bash

# waybar is just a better status bar than is stock with sway
apt-install --assume-yes waybar

ln -s $PWD/waybar $HOME/.config/waybar
