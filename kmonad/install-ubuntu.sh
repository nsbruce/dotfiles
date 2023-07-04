#!/bin/bash

apt-get install -y docker fzf

# Build the Docker image which will contain the binary.
docker build -t kmonad-builder github.com/kmonad/kmonad.git

# Spin up an ephemeral Docker container from the built image, to just copy the
# built binary to the host's current directory bind-mounted inside the
# container at /host/.
docker run --rm -it -v ${PWD}:/host/ kmonad-builder bash -c 'cp -vp /root/.local/bin/kmonad /host/'
mv ${PWD}/kmonad /usr/local/bin/kmonad

# Clean up build image, since it is no longer needed.
docker rmi kmonad-builder

# setup uinput permissions
groupadd uinput
usermod -aG input $USER
usermod -aG uinput $USER

ln -s ${PWD}/50-kmonad.rules /etc/udev/rules.d/50-kmonad.rules

modprobe uinput
echo "You may need to reboot for uinput to work"

# put the kbd files somewhere useful
mkdir -p /opt/kmonad
chown -R $USER:$USER /opt/kmonad
ln -s ${PWD}/*.kbd /opt/kmonad/


# link zsh functions
ln -s ${PWD}/kmonad.zsh ${ZSH_FUNCS_DIR}/kmonad.zsh
source ${PWD}/kmonad.zsh

# setup systemd service
get_best_kbd
ln -s ${PWD}/kmonad.service /etc/systemd/system/kmonad.service
systemctl enable kmonad.service
systemctl start kmonad