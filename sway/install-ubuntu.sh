#!/bin/bash

## deps
apt-get install -y sway slurp grim brightnessctl wev

# for brightnessctl to work
usermod -aG video $USER

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

## rofi-calc
apt-get install -y rofi-dev qalc libtool
git clone https://github.com/svenstaro/rofi-calc.git
cd rofi-calc/
mkdir m4
autoreconf -i
mkdir build
cd build/
../configure
make
make install
cd ../..
rm -r rofi-calc

mkdir -p $HOME/.config/rofi
ln -s $PWD/rofi-config.rasi $HOME/.config/rofi/config.rasi

sudo apt-get install -y i3status
mkdir -p ${HOME}/.config/i3status
ln -s ${PWD}/i3statusconfig ${HOME}/.config/i3status/config

# notifications via mako
apt-get install -y jq gperf libnotify-bin
# basu is a dependency of mako
git clone https://git.sr.ht/~emersion/basu
cd basu
meson build
ninja -C build
ninja -C build install
cd -
rm -r basu

git clone https://github.com/emersion/mako
cd mako
meson build
ninja -C build
ninja -C build install
cd -
rm -r mako

mkdir -p $HOME/.config/mako
ln -s $PWD/makoconfig $HOME/.config/mako/config

git clone https://git.sr.ht/~emersion/kanshi
cd kanshi
meson build
ninja -C build
ninja -C build install
cd -
rm -r kanshi

mkdir -p $HOME/.config/kanshi
