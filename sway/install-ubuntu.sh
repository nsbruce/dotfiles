# deps for swaylock-effects
apt-get install -y libxkbcommon-dev meson wayland-protocols cmake make libwayland-dev libcairo2-dev scdoc libpam-cracklib

git clone https://github.com/mortie/swaylock-effects
cd swaylock-effects
meson build
ninja -C build
sudo ninja -C build install
sudo chmod a+s /usr/local/bin/swaylock

mkdir -p $HOME/.config/sway
ln -s $PWD/swayconfig $HOME/.config/sway/config


ln -s $PWD/myswaylock $HOME/.local/bin/myswaylock
