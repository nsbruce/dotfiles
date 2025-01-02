#! /bin/bash

apt-get install -y fzf tmux git zsh

# install and link prompt
curl -sS https://starship.rs/install.sh | sh
ln -s $PWD/starship.toml $HOME/.config/starship.toml

ln -s ${PWD}/zshrc ${HOME}/.zshrc

chsh -s $(which zsh)

mkdir -p ${HOME}/.zsh_funcs
