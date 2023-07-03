#! /bin/bash

brew install fzf git zsh tmux
$(brew --prefix)/opt/fzf/install

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

ln -s ${PWD}/p10k.zsh ${HOME}/.p10k.zsh
ln -s ${PWD}/zshrc ${HOME}/.zshrc

chsh -s /usr/local/bin/zsh

mkdir -p ${HOME}/.zsh_funcs