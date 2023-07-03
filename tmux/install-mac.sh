#!/bin/bash

brew install git tmux reattach-to-user-namespace

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

python3 -m pip install --user libtmux

ln -s $PWD/tmux.conf $HOME/.tmux.conf