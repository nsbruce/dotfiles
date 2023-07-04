#! /bin/bash

# Install git
apt-get install -y git

ln -s ${PWD}/gitignore ${HOME}/.gitignore_global
git config --global core.excludesfile ${HOME}/.gitignore_global