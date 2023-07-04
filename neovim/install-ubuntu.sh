#!/bin/bash

add-apt-repository -y ppa:neovim-ppa/unstable
apt-get update
apt-get install -y software-properties-common neovim

ln -s ${PWD}/nvim $HOME/.config/nvim