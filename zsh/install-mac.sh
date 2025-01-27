#! /bin/bash

brew install fzf git zsh tmux
$(brew --prefix)/opt/fzf/install

curl -sS https://starship.rs/install.sh | sh -s -- --yes
ln -s $PWD/starship.toml $HOME/.config/starship.toml

ln -s ${PWD}/zshrc ${HOME}/.zshrc

chsh -s /usr/local/bin/zsh

mkdir -p ${HOME}/.zsh_funcs
