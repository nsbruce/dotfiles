#! /bin/bash

add-apt-repository -y ppa:maveonair/helix-editor
apt update
apt install -y --no-install-recommends helix

mkdir -p $HOME/.config/helix
ln -s $PWD/config.toml $HOME/.config/helix/config.toml
