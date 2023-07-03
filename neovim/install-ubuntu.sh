#!/bin/bash

sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -y software-properties-common neovim

ln -s ${PWD}/nvim $HOME/.config/nvim