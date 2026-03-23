#! /bin/bash

curl --output helix.deb --location https://github.com/helix-editor/helix/releases/download/25.07.1/helix_25.7.1-1_amd64.deb
apt-get install -y ./helix.deb
rm helix.deb

mkdir -p "${HOME}"/.config/helix
ln -s "${PWD}"/config.toml "${HOME}"/.config/helix/config.toml
ln -s "${PWD}"/languages.toml "${HOME}"/.config/helix/languages.toml

# formatter
curl -fsSL https://dprint.dev/install.sh | sh
mkdir -p "${HOME}"/.config/dprint
ln -s "${PWD}"/dprint.json "${HOME}"/.config/dprint/dprint.json

# bash lsp and linter
apt install -y --no-install-recommends shellcheck
snap install bash-language-server --classic

# markdown lsp
curl -Lo /usr/local/bin/marksman https://github.com/artempyanykh/marksman/releases/download/2025-12-13/marksman-linux-x64 && chmod 755 /usr/local/bin/marksman
