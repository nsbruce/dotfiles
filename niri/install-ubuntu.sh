apt-get install --assume-yes --no-install-recommends clang libudev-dev libgbm-dev libxkbcommon-dev libegl1-mesa-dev libwayland-dev libinput-dev libdbus-1-dev libsystemd-dev libseat-dev libpipewire-0.3-dev libpango1.0-dev libdisplay-info-dev xdg-desktop-portal-gtk xdg-desktop-portal-gnome gnome-keyring

# xwayland-satellite is a dep since I want xwayland support
git clone https://github.com/Supreeeme/xwayland-satellite.git
cd xwayland-satellite
cargo install --path .
cd -
rm -rf xwayland-satellite

# niri itself
git clone https://github.com/YaLTeR/niri.git
cd niri
cargo install --path . --locked
mv resources/niri-session $HOME/.local/bin/
mv resources/niri.desktop /usr/local/share/wayland-sessions/
mv niri.service /etc/systemd/user/
echo 'You must update the path in /etc/systemd/user/niri.service to $(which niri)'
mv niri-shutdown.target /etc/systemd/user/
cd -
rm -rf niri

mkdir --parents $HOME/.config/niri
ln -s $PWD/config.kdl $HOME/.config/niri/config.kdl

cp swayidle.service ~/.config/systemd/user/
systemctl --userdaemon-reload
systemctl --user add-wants niri.service swayidle.service
