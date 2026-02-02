FROM ubuntu:24.04

RUN apt-get update && apt-get install --assume-yes --no-install-recommends \
  curl \
  git \
  python3 \
  python3-venv \
  python3-pip \
  shellcheck \
  ca-certificates \
  npm \
  build-essential

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=/root/.cargo/bin:$PATH

RUN curl --output helix.deb --location https://github.com/helix-editor/helix/releases/download/25.07.1/helix_25.7.1-1_amd64.deb && \
    apt-get install -y ./helix.deb && \
    rm helix.deb


RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN curl -sSL https://install.python-poetry.org | python3 -

ENV VIRTUAL_ENV=/venv \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=false
    
ENV PATH=$VIRTUAL_ENV/bin:/root/.local/bin:$PATH

RUN python3 -m venv $VIRTUAL_ENV

RUN uv pip install \
  isort \
  ruff \
  python-lsp-server \
  python-lsp-black \
  pylsp-mypy \
  ty

RUN uv tool install commitizen

RUN npm install --global \
  vscode-langservers-extracted \
  bash-language-server \
  dockerfile-language-server-nodejs \
  @microsoft/compose-language-service

RUN cargo install --git https://github.com/latex-lsp/texlab --locked --tag v5.24.0

WORKDIR /usr/local/bin

RUN curl -Lo marksman https://github.com/artempyanykh/marksman/releases/download/2025-12-13/marksman-linux-x64 && \
    chmod 755 marksman

RUN cargo install --locked zellij

RUN mkdir --parents /root/.config/helix /root/.config/dprint
COPY config.toml languages.toml /root/.config/helix/
COPY dprint.json /root/.config/dprint/

WORKDIR /workspace
