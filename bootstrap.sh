#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

trust_external_formulae() {
  echo "Configuring trusted external Homebrew formulae..."

  if ! brew trust --list 2>/dev/null \
    | grep -Fq "hashicorp/tap/terraform"; then
    brew trust --formula hashicorp/tap/terraform
  else
    echo "✓ Terraform formula is already trusted."
  fi
}

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    echo "✓ Homebrew is already installed."
    return
  fi

  echo "Installing Homebrew..."

  /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

configure_homebrew_environment() {
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  if ! command -v brew >/dev/null 2>&1; then
    echo "Error: Homebrew is not available in PATH."
    exit 1
  fi
}

install_packages() {
  echo "Installing packages from Brewfile..."
  brew bundle --file "$SCRIPT_DIR/Brewfile"
}

main() {
  echo "== mac-bootstrap =="

  install_homebrew
  configure_homebrew_environment

  echo "Homebrew version:"
  brew --version


  trust_external_formulae
  install_packages
  "$SCRIPT_DIR/scripts/setup-symlinks.sh"

  echo
  echo "Bootstrap completed."
}

main "$@"
