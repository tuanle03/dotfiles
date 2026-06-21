#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
log()  { echo -e "${GREEN}[install]${NC} $1"; }
warn() { echo -e "${YELLOW}[warn]${NC} $1"; }

symlink() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    warn "Backing up existing $(basename "$dst") → $dst.bak"
    mv "$dst" "$dst.bak"
  fi
  ln -sf "$src" "$dst"
  log "  $dst → $src"
}

echo "==> Neovim"
symlink "$DOTFILES/nvim" "$HOME/.config/nvim"

echo "==> Tmux"
symlink "$DOTFILES/tmux/.tmux.conf"       "$HOME/.tmux.conf"
symlink "$DOTFILES/tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"
symlink "$DOTFILES/tmux/.tmux.conf.vim"   "$HOME/.tmux.conf.vim"

echo "==> Tmuxinator"
symlink "$DOTFILES/tmuxinator" "$HOME/.config/tmuxinator"

echo "==> Cloudflared"
# Configs reference per-tunnel credentials-file UUIDs that only exist after
# `cloudflared tunnel create` on this machine. See cloudflared/README.md
# for the full bootstrap. Symlinks are still useful so edits stay tracked.
symlink "$DOTFILES/cloudflared/config.yml" "$HOME/.cloudflared/config.yml"
symlink "$DOTFILES/cloudflared/cnmoew.yml" "$HOME/.cloudflared/cnmoew.yml"

echo "==> Zsh"
symlink "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
if [ ! -f "$HOME/.zshrc.secrets" ]; then
  cp "$DOTFILES/zsh/.zshrc.secrets.example" "$HOME/.zshrc.secrets"
  warn "Created ~/.zshrc.secrets from template — add your API keys there"
fi

echo "==> Claude Code"
# Global config only — credentials (.credentials.json) and session state
# (projects/, sessions/, logs) stay machine-local and are never tracked.
symlink "$DOTFILES/.claude/CLAUDE.md"     "$HOME/.claude/CLAUDE.md"
symlink "$DOTFILES/.claude/RTK.md"        "$HOME/.claude/RTK.md"
symlink "$DOTFILES/.claude/DELEGATION.md" "$HOME/.claude/DELEGATION.md"
symlink "$DOTFILES/.claude/settings.json" "$HOME/.claude/settings.json"
symlink "$DOTFILES/.claude/agents"        "$HOME/.claude/agents"

echo "==> Neovim plugins (packer.nvim)"
PACKER="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ ! -d "$PACKER" ]; then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER"
  log "  Installed — open nvim and run :PackerSync"
else
  log "  Already installed"
fi

echo ""
log "Done! Next steps:"
log "  1. Fill in ~/.zshrc.secrets with your API keys"
log "  2. Open nvim and run :PackerSync"
log "  3. Reload tmux: tmux source-file ~/.tmux.conf"
