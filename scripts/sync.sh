#!/usr/bin/env bash
# Copies live machine configs back into the dotfiles repo.
# Run this after making changes directly on the machine (e.g. tmuxinator projects).
# If using symlinks (installed via install.sh), edits are already in the repo —
# sync is mainly needed for tmuxinator projects edited via tmuxinator directly.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

GREEN='\033[0;32m'; NC='\033[0m'
log() { echo -e "${GREEN}[sync]${NC} $1"; }

copy_if_changed() {
  local src="$1" dst="$2"
  if [ ! -f "$src" ]; then return; fi
  if ! diff -q "$src" "$dst" &>/dev/null 2>&1; then
    cp "$src" "$dst"
    log "  Updated: $(basename "$dst")"
  fi
}

echo "==> Tmuxinator projects"
for f in "$HOME/.config/tmuxinator/"*.yml; do
  [ -f "$f" ] || continue
  name="$(basename "$f")"
  dst="$DOTFILES/tmuxinator/$name"
  if [ ! -f "$dst" ] || ! diff -q "$f" "$dst" &>/dev/null 2>&1; then
    cp "$f" "$dst"
    log "  $name"
  fi
done

echo "==> Nvim (for non-symlinked setups)"
copy_if_changed "$HOME/.config/nvim/init.lua"           "$DOTFILES/nvim/init.lua"
copy_if_changed "$HOME/.config/nvim/local.vim"          "$DOTFILES/nvim/local.vim"
copy_if_changed "$HOME/.config/nvim/plugin/bundles.lua" "$DOTFILES/nvim/plugin/bundles.lua"

echo "==> Tmux (for non-symlinked setups)"
copy_if_changed "$HOME/.tmux.conf"       "$DOTFILES/tmux/.tmux.conf"
copy_if_changed "$HOME/.tmux.conf.local" "$DOTFILES/tmux/.tmux.conf.local"
copy_if_changed "$HOME/.tmux.conf.vim"   "$DOTFILES/tmux/.tmux.conf.vim"

echo ""
log "Sync complete. Review with: git -C \"$DOTFILES\" diff"
