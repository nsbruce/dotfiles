#!/bin/bash

## deps
apt-get install -y sway slurp grim brightnessctl wev wl-clipboard swayidle

# for brightnessctl to work
usermod -aG video $USER

## deps for swaylock-effects
apt-get install -y libxkbcommon-dev meson ninja-build libiniparser-dev wayland-protocols cmake make libwayland-dev libcairo2-dev scdoc libpam0g-dev

git clone https://github.com/mortie/swaylock-effects
cd swaylock-effects
meson build
ninja -C build
ninja -C build install
chmod a+s /usr/local/bin/swaylock
cd -
rm -r swaylock-effects

mkdir -p $HOME/.config/sway
ln -s $PWD/swayconfig $HOME/.config/sway/config


ln -s $PWD/myswaylock $HOME/.local/bin/myswaylock


# misc scripts
ln -s $PWD/open-music-workspace $HOME/.local/bin/open-music-workspace
ln -s $PWD/sway-alias.zsh $ZSH_FUNCS_DIR/sway-alias.zsh
