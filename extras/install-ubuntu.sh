#! /bin/bash

apt-get install -y bat golang wl-clipboard gopass-jsonapi pipx

# automatic dark/light mode switching
git clone git@gitlab.com:WhyNotHugo/darkman.git
(
  cd darkman || exit
  make
  sudo make install PREFIX=/usr
  mv contrib/darkman.service /etc/systemd/user/darkman.service
  chown root:root /etc/systemd/user/darkman.service
  chmod 777 /etc/systemd/user/darkman.service
)
rm -rf darkman
mkdir -p "${HOME}"/.config/darkman
ln -s "${PWD}"/darkmanconfig.yaml "${HOME}"/.config/darkman/config.yaml
systemctl --user enable --now darkman.service

# lineselect
export PATH=$HOME/.cargo/bin:$PATH
cargo install lineselect

# power efficiency
add-apt-repository ppa:linrunner/tlp
apt update
apt install tlp tlp-rdw
systemctl enable tlp.service
systemctl start tlp.service

# libscfg is a kanshi dependency
git clone https://git.sr.ht/~emersion/libscfg
(
  cd libscfg || exit
  meson build
  ninja -C build
  ninja -C build install
)
rm -r libscfg

# kanshi does automatic display switcheroo-ing
git clone https://git.sr.ht/~emersion/kanshi
(
  cd kanshi || exit
  meson build
  ninja -C build
  ninja -C build install
)
rm -r kanshi

mkdir -p "${HOME}"/.config/kanshi

# wpaperd handles rotating wallpapers
cargo install wpaperd

# devcontainers are how I like to do my development
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
apt install nodejs
npm config set prefix ~/.local
npm install -g @devcontainers/cli

pipx install commitizen

# gopass
curl https://packages.gopass.pw/repos/gopass/gopass-archive-keyring.gpg | sudo tee /usr/share/keyrings/gopass-archive-keyring.gpg >/dev/null
cat << EOF | sudo tee /etc/apt/sources.list.d/gopass.sources
Types: deb
URIs: https://packages.gopass.pw/repos/gopass
Suites: stable
Architectures: all amd64 arm64 armhf
Components: main
Signed-By: /usr/share/keyrings/gopass-archive-keyring.gpg
EOF
sudo apt update
sudo apt install gopass gopass-archive-keyring

echo "Ensure you own .mozilla, then run gopass-jsonapi configure"

echo "To install displaylink go to the synaptics website and follow instructions. You can add an apt source and just do an apt install"

echo "To install difftastic, get latest release from https://github.com/Wilfred/difftastic/releases and check the docs to see if they're on the apt repos yet. Put executable in .local/bin, then add the following to your ~/.gitconfig:\n[diff]\n    external = difft"

echo "To install tbmk, go to tbmk github and get latest release. Then put binary in ~/.local/bin along with the config.yaml file, but change the datadir in the yaml to ~/.local/w"
