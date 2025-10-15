#! /bin/bash

cargo install --locked zellij


mkdir --parents $HOME/.config/zellij
ln -s $PWD/config.kdl $HOME/.config/zellij/config.kdl
