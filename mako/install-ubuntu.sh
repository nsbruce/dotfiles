#!/usr/bin/env bash

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
ln -s $PWD/config $HOME/.config/mako/
