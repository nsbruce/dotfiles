#!/bin/bash

case "$(uname -s)" in
    Darwin)
        install_cmd="./install-mac.sh"
        ;;
    Linux)
        install_cmd="./install-ubuntu.sh"
        ;;
    *)
        echo "OS not supported"
        exit 1
        ;;
esac


case $1 in
    -p|--primary)
        echo "Installing primary dotfiles"
        directories=( git zsh fonts tmux i3 kmonad neovim  )
        ;;
    -r|--remote)
        echo "Installing remote dotfiles"
        directories=( git zsh tmux neovim  )
        ;;
    -h|--help)
        echo "Usage: ./install.sh [-p|--primary] [-r|--remote]"
        exit 0
        ;;
esac

# if user is root don't prefix with sudo
if [[ "$EUID" -eq 0 ]]; then
    install_prefix=""
else
    install_prefix="sudo"
fi


for directory in ${directories[@]}
do
    # Run the install for each
    cd $directory || exit 1
    echo "Installing $directory"
    $install_prefix $install_cmd
    cd ..
    echo ""
done