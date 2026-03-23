#! /bin/bash

apt-get install -y build-essential

curl -Lo zellij.tar.gz https://github.com/zellij-org/zellij/releases/download/v0.43.1/zellij-x86_64-unknown-linux-musl.tar.gz && tar xzf zellij.tar.gz && rm zellij.tar.gz && mv zellij /usr/local/bin/

mkdir --parents "${HOME}"/.config/zellij
ln -s "${PWD}"/config.kdl "${HOME}"/.config/zellij/config.kdl
