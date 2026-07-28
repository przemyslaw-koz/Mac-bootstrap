#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

create_symlink() {
  local source_path="$1"
  local target_path="$2"

  mkdir -p "$(dirname "$target_path")"

  if [[ -e "$target_path" && ! -L "$target_path" ]]; then
    echo "Skipping existing file: $target_path"
    return
  fi

  ln -sfn "$source_path" "$target_path"
  echo "Linked: $target_path -> $source_path"
}

ensure_zsh_source() {
  local source_file="$1"
  local zshrc="$HOME/.zshrc"
  local source_line="[[ -f \"$source_file\" ]] && source \"$source_file\""

  touch "$zshrc"

  if grep -Fqx "$source_line" "$zshrc"; then
    echo "Already configured: $source_file"
    return
  fi

  {
    echo
    echo "# mac-bootstrap"
    echo "$source_line"
  } >> "$zshrc"

  echo "Added to $zshrc: $source_file"
}

main() {
  echo "Configuring symlinks..."

  create_symlink \
    "$REPO_DIR/config/ghostty/config" \
    "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

  create_symlink \
    "$REPO_DIR/config/starship.toml" \
    "$HOME/.config/starship.toml"

  ensure_zsh_source \
    "$REPO_DIR/config/zsh/starship.zsh"

  echo "Symlinks configured."
}

main "$@"
