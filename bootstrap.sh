#!/usr/bin/env bash

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Starting mac-bootstrap..."

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."

  /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

echo "Homebrew version:"
brew --version

echo "Installing packages from Brewfile..."
brew bundle --file "$SCRIPT_DIR/Brewfile"

echo "Bootstrap completed."
