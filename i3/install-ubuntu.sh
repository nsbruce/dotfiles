#!/bin/bash

# first dependencies are self explanatory
# after the first break is to support i3lock-color
# after the second break is other stuff I ended up wanting (ha great explanation right)
apt-get install -y i3 rofi \
    autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev \
    jq gnome-terminal shutter playerctl

mkdir -p ${HOME}/.config/i3
ln -s ${PWD}/i3config ${HOME}/.config/i3/config

mkdir -p ${HOME}/.config/i3status
ln -s ${PWD}/i3statusconfig ${HOME}/.config/i3status/config

mkdir -p ${HOME}/.config/rofi
ln -s ${PWD}/rofi-config.rasi ${HOME}/.config/rofi/config.rasi

# i3lock-color
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
git tag -f "git-$(git rev-parse --short HEAD)"
apt-get remove i3lock
./install-i3lock-color.sh
cd ..
rm -rf i3lock-color

# link scripts
for file in scripts/*; do
    if [ -f "$file" ]; then
        # Extract the filename without the path
        filename=$(basename "$file")

        # Create the destination file path
        destination_file="${HOME}/.local/bin/${filename}"

        # Create a symbolic link to the destination directory
        ln -s "$(realpath "$file")" "$destination_file"

        echo "Linked $filename to $destination_file"
    fi
done