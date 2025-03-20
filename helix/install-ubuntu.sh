#! /bin/bash

add-apt-repository -y ppa:maveonair/helix-editor
apt update
apt install -y --no-install-recommends helix

mkdir -p $HOME/.config/helix
ln -s $PWD/config.toml $HOME/.config/helix/config.toml
ln -s $PWD/languages.toml $HOME/.config/helix/languages.toml

# formatter

cargo install --locked dprint
mkdir -p $HOME/.config/dprint
ln -s $PWD/dprint.json $HOME/.config/dprint/dprint.json
