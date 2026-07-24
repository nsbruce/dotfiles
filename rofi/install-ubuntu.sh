#!/usr/bin/env bash


## deps for rofi (wayland fork)
apt-get install -y libpango1.0-dev flex bison cmake libgdk-pixbuf-2.0-dev libxcb-util-dev libxcb-xkb-dev libxkbcommon-x11-dev libxcb-ewmh-ewmh-dev libmpdclient-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-xinerama0-dev libxcb-keysyms1-dev libstartup-notification0-dev
git clone https://github.com/lbonn/rofi
cd rofi
meson setup build
ninja -C build
ninja -C build install
cd -
rm -r rofi

## rofi-calc
apt-get install -y rofi-dev qalc libtool
git clone https://github.com/svenstaro/rofi-calc.git
cd rofi-calc/
meson setup build
meson compile -C build/
cd build || exit
meson install
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
ln -s $PWD/config.rasi $HOME/.config/rofi/config.rasi
ln -s $PWD/web-search.py $HOME/.config/rofi/
