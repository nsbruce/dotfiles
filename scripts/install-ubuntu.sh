#! /usr/bin/bash

apt-get install --assume-yes batcat

mkdir --parents $HOME/.local/bin
for f in "$PWD"/*; do
  [ "$(basename "$f")" = "install-ubuntu.sh" ] && continue
  ln --symbolic --force "$f" $HOME/.local/bin/
  echo "linking $f"
done
