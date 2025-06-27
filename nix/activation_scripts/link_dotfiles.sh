#!/usr/bin/env bash

set -e

if [ -z "$HOME" ]; then
  HOME="/home/arthurx"
fi

DOTFILES="/home/arthurx/.config/dotfiles/nix"

# Array of source:destination pairs
declare -a SYMLINKS=(
  "${DOTFILES}/zsh/zshrc:.zshrc"
  "${DOTFILES}/zsh/zsh_aliases:.zsh_aliases"
  "${DOTFILES}/alacritty/alacritty.toml:.config/alacritty.toml"
  "${DOTFILES}/starship/starship.toml:.config/starship.toml"
  "${DOTFILES}/zed/settings.json:.config/zed/settings.json"
  "${DOTFILES}/zed/keymap.json:.config/zed/keymap.json"
  "${DOTFILES}/fonts/PixelCodeLigatureLess-Regular.otf:.local/share/fonts/PixelCodeLigatureLessRegular.otf"
  "${DOTFILES}/fonts/PixelCodeLigatureLess-RegularItalic.otf:.local/share/fonts/PixelCodeLigatureLessRegularItalic.otf"
  "${DOTFILES}/tmux/tmux.conf:.tmux.conf"
)

echo "Creating direct symlinks for dotfiles..."

for pair in "${SYMLINKS[@]}"; do
  src="${pair%%:*}"
  dest="${HOME}/${pair##*:}"

  # Create parent directory if it doesn't exist
  mkdir -p "$(dirname "$dest")"

  # Create symlink (force overwrite if exists)
  echo "Linking: $src -> $dest"
  ln -sf "$src" "$dest"
done

echo "Dotfiles linking complete!"