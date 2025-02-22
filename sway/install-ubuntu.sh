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

## deps for rofi (wayland fork)
apt-get install -y libpango1.0-dev flex bison # libgdk-pixbuf-2.0-dev
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

# apt-get install -y i3status
# mkdir -p ${HOME}/.config/i3status
# ln -s ${PWD}/i3statusconfig ${HOME}/.config/i3status/config

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

# libscfg is a kanshi dependency
git clone https://git.sr.ht/~emersion/libscfg
cd libscfg
meson build
ninja -C build
ninja -C build install
cd -
rm -r libscfg

# kanshi does automatic display switcheroo-ing
git clone https://git.sr.ht/~emersion/kanshi
cd kanshi
meson build
ninja -C build
ninja -C build install
cd -
rm -r kanshi

mkdir -p $HOME/.config/kanshi

# waybar is just a better status bar than is stock with sway
sudo apt install -y \
  clang-tidy \
  gobject-introspection \
  libdbusmenu-gtk3-dev \
  libevdev-dev \
  libfmt-dev \
  libgirepository1.0-dev \
  libgtk-3-dev \
  libgtkmm-3.0-dev \
  libinput-dev \
  libjsoncpp-dev \
  libmpdclient-dev \
  libnl-3-dev \
  libnl-genl-3-dev \
  libpulse-dev \
  libsigc++-2.0-dev \
  libspdlog-dev \
  libwayland-dev \
  scdoc \
  upower \
  libxkbregistry-dev \
  pavucontrol
git clone https://github.com/Alexays/Waybar
cd Waybar
meson build
ninja -C build
ninja -C build install
cd -
rm -r Waybar

ln -s $PWD/waybar $HOME/.config/waybar
# misc scripts
ln -s $PWD/open-music-workspace $HOME/.local/bin/open-music-workspace
ln -s $PWD/sway-alias.zsh $ZSH_FUNCS_DIR/sway-alias.zsh
