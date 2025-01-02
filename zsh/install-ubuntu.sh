#! /bin/bash

apt-get install -y fzf tmux git zsh

# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
# ln -s ${PWD}/p10k.zsh ${HOME}/.p10k.zsh

# install and link prompt
curl -sS https://starship.rs/install.sh | sh
ln -s $PWD/starship.toml $HOME/.config/starship.toml

ln -s ${PWD}/zshrc ${HOME}/.zshrc

chsh -s $(which zsh)

mkdir -p ${HOME}/.zsh_funcs
