#! /bin/bash

# cat replacement
apt-get install -y bat

# better diffs
echo "To install difftastic, get latest release from https://github.com/Wilfred/difftastic/releases and check the docs to see if they're on the apt repos yet. Put executable in .local/bin, then add the following to your ~/.gitconfig:\n[diff]\n    external = difft"

# automatic dark/light mode switching
git clone git@gitlab.com:WhyNotHugo/darkman.git
(
  cd darkman || exit
  make
  sudo make install PREFIX=/usr
  mv darkman.service /etc/systemd/user/darkman.service
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

# tbmk
echo "To install tbmk, go to tbmk github and get latest release. Then put binary in ~/.local/bin along with the config.yaml file, but change the datadir in the yaml to ~/.local/w"

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
