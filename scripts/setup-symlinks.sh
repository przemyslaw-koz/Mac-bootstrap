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

main() {
  echo "Configuring symlinks..."

  create_symlink \
    "$REPO_DIR/config/ghostty/config" \
    "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

  echo "Symlinks configured."
}

main "$@"
