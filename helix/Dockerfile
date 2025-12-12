FROM ubuntu:24.04

RUN until apt-get update && apt-get install -y --no-install-recommends \
  curl \
  git \
  python3 \
  python3-venv \
  python3-pip \
  shellcheck \
  ca-certificates; do sleep 0.5; done
RUN curl --output helix.deb --location https://github.com/helix-editor/helix/releases/download/25.07.1/helix_25.7.1-1_amd64.deb && \
    apt-get install -y ./helix.deb && \
    rm helix.deb

RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV VIRTUAL_ENV=/venv \
    PATH=/venv/bin:/root/.local/bin:$PATH

RUN python3 -m venv /venv

RUN uv pip install \
  isort \
  ruff \
  python-lsp-server \
  python-lsp-black \
  pylsp-mypy \
  ty
