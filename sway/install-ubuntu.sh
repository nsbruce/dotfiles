#!/bin/bash

## add /usr/local to ldconfig
echo "/usr/local/lib/x86_64-linux-gnu" | sudo tee /etc/ld.so.conf.d/local.conf
sudo ldconfig

## deps to build swayfx
apt-get install meson wayland-protocols libpcre2-dev libjson-c-dev libpango-1.0-0 libcairo2-dev

# wayland itself
git clone https://gitlab.freedesktop.org/wayland/wayland
cd wayland
meson setup build -Ddocumentation=false
ninja -C build install
cd - 
rm -rf wayland

# for wlroots, need newer xkbcommon than is available on apt
git clone https://github.com/xkbcommon/libxkbcommon.git
cd libxkbcommon
meson setup build -Denable-x11=false -Dxkb-config-root=/usr/share/X11/xkb -Dx-locale-root=/usr/share/X11/locale
meson compile -C build
ninja -C build install
cd -
rm -rf libxkbcommon

# for wlroots, need newer pixman than is available on apt
git clone https://gitlab.freedesktop.org/pixman/pixman.git
cd pixman
meson setup build
ninja -C build install
cd -
rm -rf pixman

# for wlroots, need newer wayland-protocols than is available on apt
git clone https://gitlab.freedesktop.org/wayland/wayland-protocols.git
cd wayland-protocols
meson setup build
ninja -C build install
cd -
rm -rf wayland-protocols

# for swayfx, need newer wlroots than is available on apt
apt install --assume-yes libdisplay-info-dev libvulkan-dev libliftoff-dev
git clone --branch 0.19.1 https://gitlab.freedesktop.org/wlroots/wlroots.git
cd wlroots
meson setup build --prefix=/usr/local -Dbackends=drm,libinput,x11
ninja -C build
ninja -C build install
cd -
rm -rf wlroots

# wlr replacement, scenefx
apt-get install --assume-yes libgbm-dev
git clone https://github.com/wlrfx/scenefx.git
cd scenefx
meson setup build
ninja -C build
ninja -C build install
cd -
rm -rf scenefx

# for swayfx, need newer libinput that is available on apt
git clone https://gitlab.freedesktop.org/libinput/libinput
cd libinput
meson setup --prefix=/usr build
ninja -C build
ninja -C build install
cd -
rm -rf libinput

apt-get install --assume-yes libjson-c-dev
git clone git@github.com:WillPower3309/swayfx.git
cd swayfx
# mkdir -p subprojects
# cd subprojects
# git clone https://github.com/wlrfx/scenefx.git
# # git clone --branch 0.19.1 https://gitlab.freedesktop.org/wlroots/wlroots.git
# cd -
meson setup build
ninja -C build
ninja -C build install
cd -
rm -rf swayfx

# useful stuff
apt-get install --assume-yes slurp grim brightnessctl wev wl-clipboard swayidle

# for brightnessctl to work
usermod --append --groups video $USER

## deps for swaylock-effects
apt-get install --assume-yes libxkbcommon-dev meson ninja-build libiniparser-dev wayland-protocols cmake make libwayland-dev libcairo2-dev scdoc libpam0g-dev

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

## rofi-file-browser
git clone https://github.com/marvinkreis/rofi-file-browser-extended.git
cd rofi-file-browser-extended
cmake .
make
make install
cd -
rm -r rofi-file-browser-extended

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
