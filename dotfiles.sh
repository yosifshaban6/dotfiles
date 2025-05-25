#!/usr/bin/env bash

set -e

# Define files and subpaths to link
FILES=(
  ".zshrc"
  ".wezterm.lua"
  "tmux/.tmux.conf"
)

echo "[*] Linking dotfiles to home..."

for file in "${FILES[@]}"; do
  src="$HOME/dotfiles/$file"
  dest="$HOME/$(basename "$file")"

  # Backup if exists and not a symlink
  if [[ -e "$dest" && ! -L "$dest" ]]; then
    echo " → Backing up $dest to $dest.bak"
    mv "$dest" "$dest.bak"
  fi

  echo " → Linking $src → $dest"
  ln -sf "$src" "$dest"
done

echo "[✓] All dotfiles linked."

echo "[*] Committing dotfiles..."

cd "$HOME/dotfiles" || exit 1

git add .

# Use timestamp as commit message
timestamp=$(date "+%Y-%m-%d %H:%M:%S")
git commit -m "Update dotfiles at $timestamp" || echo "No changes to commit."

git push origin main

echo "[✓] Dotfiles synced with Git."
