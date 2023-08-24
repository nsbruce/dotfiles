#! /bin/bash

# Install git
apt-get install -y git

ln -s ${PWD}/gitignore ${HOME}/.gitignore_global
git config --global core.excludesfile ${HOME}/.gitignore_global

ln -s ${PWD}/git-funcs.zsh ${ZSH_FUNCS_DIR}/git-funcs.zsh
source ${PWD}/git-funcs.zsh