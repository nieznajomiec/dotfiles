#!/usr/bin/env bash
set -euo pipefail

REPO=${REPO:-"git@github.com:yourname/dotfiles.git"}
TARGET=${TARGET:-"$HOME"}
DIR=${DIR:-"$HOME/dotfiles"}

if [ ! -d "$DIR/.git" ]; then
  git clone "$REPO" "$DIR"
fi

if ! command -v stow >/dev/null 2>&1; then
  if command -v apt >/dev/null 2>&1; then sudo apt update && sudo apt install -y stow; fi
fi

cd "$DIR"

PACKAGES=("nvim" "zsh" "git" "tmux" "alacritty")

OS="$(uname -s)"
HOST="$(hostname)"

if [[ "$OS" == "Darwin" ]]; then
  PACKAGES+=("git-mac")
elif [[ "$OS" == "Linux" ]]; then
  PACKAGES+=("git-linux")
fi

if [ -d "host-$HOST" ]; then
  PACKAGES+=("host-$HOST")
fi

stow -t "$TARGET" "${PACKAGES[@]}"
echo "Done. Linked: ${PACKAGES[*]}"
