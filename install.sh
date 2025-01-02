#!/bin/bash


case $1 in
    -p|--primary)
        echo "Installing primary dotfiles"
        directories=( git zsh fonts tmux i3 kmonad neovim ghostty )
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


if [[ "$EUID" -eq 0 ]]; then
    # if user is root don't prefix with sudo
    install_prefix=""
else
    # if user is not root prefix with sudo but make sure to keep env variables ($HOME)
    install_prefix="sudo -E"
fi


case "$(uname -s)" in
    Darwin)
        install_cmd="./install-mac.sh"
        ;;
    Linux)
        install_cmd="./install-ubuntu.sh"
        $install_prefix apt-get update
        ;;
    *)
        echo "OS not supported"
        exit 1
        ;;
esac


for directory in ${directories[@]}
do
    # Run the install for each
    cd $directory || exit 1
    echo "Installing $directory"
    $install_prefix $install_cmd
    cd ..
    echo ""
done
