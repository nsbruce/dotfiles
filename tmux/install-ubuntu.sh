#!/bin/bash

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

apt-get install -y xsel python3-pip tmux

python3 -m pip install --user libtmux

ln -s $PWD/tmux.conf $HOME/.tmux.conf