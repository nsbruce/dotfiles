apt-get install --assume-yes clang libudev-dev libgbm-dev libxkbcommon-dev libegl1-mesa-dev libwayland-dev libinput-dev libdbus-1-dev libsystemd-dev libseat-dev libpipewire-0.3-dev libpango1.0-dev libdisplay-info-dev

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
cd -
rm -rf niri

mkdir --parents $HOME/.config/niri
ln -s $PWD/config.kdl $HOME/.config/niri/config.kdl
