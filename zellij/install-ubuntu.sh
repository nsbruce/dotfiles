#! /bin/bash

apt-get install build-essential

export PATH="${HOME}"/.cargo/bin:"${PATH}"
cargo install --locked zellij


mkdir --parents "${HOME}"/.config/zellij
ln -s "${PWD}"/config.kdl "${HOME}"/.config/zellij/config.kdl
