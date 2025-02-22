#! /bin/bash

# cat replacement
apt-get install -y bat

# better diffs
echo "To install difftastic - get latest release from https://github.com/Wilfred/difftastic/releases and check the docs to see if they're on the apt repos yet. Put executable in .local/bin"

# automatic dark/light mode switching
git clone git@gitlab.com:WhyNotHugo/darkman.git
cd darkman
make
sudo make install PREFIX=/usr
mv darkman/darkman.service /etc/systemd/user/darkman.service
chown root:root /etc/systemd/user/darkman.service
chmod 777 /etc/systemd/user/darkman.service
cd -
rm -rf darkman
mkdir -p $HOME/.config/darkman
ln -s $PWD/darkmanconfig.yaml $HOME/.config/darkman/config.yaml
systemctl --user enable --now darkman.service

# lineselect
cargo install lineselect

# tbmk
echo "Go to tbmk github and get latest release. Then put binary in ~/.local/bin along with the config.yaml file, but change the datadir in the yaml to ~/.local/w"
