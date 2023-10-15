#!/bin/bash

## deps for swaylock-effects
apt-get install -y libxkbcommon-dev meson wayland-protocols cmake make libwayland-dev libcairo2-dev scdoc libpam-cracklib

git clone https://github.com/mortie/swaylock-effects
cd swaylock-effects
meson build
ninja -C build
sudo ninja -C build install
sudo chmod a+s /usr/local/bin/swaylock
rm -r swaylock-effects

mkdir -p $HOME/.config/sway
ln -s $PWD/swayconfig $HOME/.config/sway/config


ln -s $PWD/myswaylock $HOME/.local/bin/myswaylock

## deps for rofi (wayland fork)
apt-get install -y libpango1.0-dev libgdk-pixbuf-2.0-dev flex bison
git clone https://github.com/lbonn/rofi
cd rofi
meson setup build
ninja -C build
sudo ninja -C build install
cd -
rm -r rofi

mkdir -p $HOME/.config/rofi
ln -s $PWD/rofi-config.rasi $HOME/.config/config.rasi

