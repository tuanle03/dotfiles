#!/usr/bin/env bash
# Bootstrap a new macOS machine from scratch. Idempotent: re-running is safe.
#
# Skips work that's already done. Does NOT touch existing SSH/GPG keys.
# For full setup of a fresh machine:
#   bash scripts/bootstrap.sh
#
# Required env (override if needed):
#   GIT_NAME    — git user.name        (default: Tuan Le)
#   GIT_EMAIL   — git user.email       (default: peter.le@lixibox.com)
#   NERD_FONT   — homebrew cask name   (default: font-jetbrains-mono-nerd-font)

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GIT_NAME="${GIT_NAME:-Tuan Le}"
GIT_EMAIL="${GIT_EMAIL:-peter.le@lixibox.com}"
NERD_FONT="${NERD_FONT:-font-jetbrains-mono-nerd-font}"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
log()  { echo -e "${GREEN}[bootstrap]${NC} $*"; }
skip() { echo -e "${YELLOW}[skip]${NC} $*"; }
step() { echo -e "\n${BLUE}==>${NC} $*"; }

has() { command -v "$1" >/dev/null 2>&1; }

brew_install() {
  for pkg in "$@"; do
    if brew list --formula "$pkg" >/dev/null 2>&1; then
      skip "brew formula: $pkg"
    else
      log "brew install $pkg"
      brew install "$pkg"
    fi
  done
}

brew_cask_install() {
  for pkg in "$@"; do
    if brew list --cask "$pkg" >/dev/null 2>&1; then
      skip "brew cask: $pkg"
    else
      log "brew install --cask $pkg"
      brew install --cask "$pkg"
    fi
  done
}

# ---------- 1. Homebrew ----------
step "Homebrew"
if ! has brew; then
  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  skip "brew already installed"
fi

# ---------- 2. CLI tools ----------
step "CLI tools"
brew_install neovim tmux fd fzf the_silver_searcher ripgrep node \
             rbenv ruby-build pyenv \
             gnupg gh pinentry-mac

# ---------- 3. Nerd Font ----------
step "Nerd Font"
brew_cask_install "$NERD_FONT"

# ---------- 4. tmuxinator (ruby gem) ----------
step "tmuxinator"
if has tmuxinator; then
  skip "tmuxinator already installed"
else
  log "gem install --user-install tmuxinator"
  gem install --user-install tmuxinator
  GEM_BIN="$(ruby -e 'puts Gem.user_dir')/bin"
  mkdir -p "$HOME/.local/bin"
  ln -sf "$GEM_BIN/tmuxinator" "$HOME/.local/bin/tmuxinator"
  log "symlinked → $HOME/.local/bin/tmuxinator"
fi

# ---------- 5. oh-my-zsh + powerlevel10k ----------
step "oh-my-zsh"
if [ -d "$HOME/.oh-my-zsh" ]; then
  skip "oh-my-zsh already installed"
else
  log "Installing oh-my-zsh"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

step "powerlevel10k"
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ -d "$P10K_DIR" ]; then
  skip "powerlevel10k already cloned"
else
  log "Cloning powerlevel10k"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi

# ---------- 6. Symlink configs ----------
step "Dotfile symlinks"
bash "$DOTFILES/scripts/install.sh"

# ---------- 7. Neovim plugins (packer) ----------
step "Neovim plugins"
PLUGIN_DIR="$HOME/.local/share/nvim/site/pack/packer/start"
PLUGIN_COUNT=$(ls -1 "$PLUGIN_DIR" 2>/dev/null | wc -l | tr -d ' ')
if [ "$PLUGIN_COUNT" -gt 5 ]; then
  skip "$PLUGIN_COUNT plugins already installed (run :PackerSync in nvim to update)"
else
  log "Running PackerSync (headless) — may take a minute"
  nvim --headless +'autocmd User PackerComplete quitall' +PackerSync 2>&1 \
    | tail -3 || true
  # Re-run once: first run errors on missing modules referenced in init.lua
  nvim --headless +'autocmd User PackerComplete quitall' +PackerSync 2>&1 \
    | tail -3 || true
fi

# ---------- 8. GPG agent (pinentry-mac) ----------
step "GPG agent"
mkdir -p "$HOME/.gnupg"
chmod 700 "$HOME/.gnupg"
if [ -f "$HOME/.gnupg/gpg-agent.conf" ] && \
   grep -q "pinentry-mac" "$HOME/.gnupg/gpg-agent.conf"; then
  skip "gpg-agent.conf already configured"
else
  log "Writing gpg-agent.conf"
  cat > "$HOME/.gnupg/gpg-agent.conf" <<EOF
pinentry-program $(brew --prefix)/bin/pinentry-mac
default-cache-ttl 28800
max-cache-ttl 28800
EOF
  gpgconf --kill gpg-agent || true
fi

# ---------- 9. SSH key (ed25519) ----------
step "SSH key"
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ -f "$SSH_KEY" ]; then
  skip "SSH key already exists at $SSH_KEY"
else
  log "Generating ed25519 SSH key (no passphrase)"
  mkdir -p "$HOME/.ssh"; chmod 700 "$HOME/.ssh"
  ssh-keygen -t ed25519 -C "$GIT_EMAIL" -f "$SSH_KEY" -N "" -q
  eval "$(ssh-agent -s)" >/dev/null
  ssh-add --apple-use-keychain "$SSH_KEY" 2>/dev/null || ssh-add "$SSH_KEY"
fi

SSH_CONFIG="$HOME/.ssh/config"
if [ -f "$SSH_CONFIG" ] && grep -q "Host github.com" "$SSH_CONFIG"; then
  skip "~/.ssh/config already has github.com entry"
else
  log "Writing ~/.ssh/config"
  cat >> "$SSH_CONFIG" <<'EOF'
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF
  chmod 600 "$SSH_CONFIG"
fi

# ---------- 10. GPG key ----------
step "GPG key"
if gpg --list-secret-keys --with-colons "$GIT_EMAIL" 2>/dev/null | grep -q '^sec:'; then
  skip "GPG key for $GIT_EMAIL already exists"
else
  log "Generating GPG ed25519 key (no passphrase, expires in 2 years)"
  gpg --batch --gen-key <<EOF
%no-protection
Key-Type: EDDSA
Key-Curve: ed25519
Subkey-Type: ECDH
Subkey-Curve: cv25519
Name-Real: $GIT_NAME
Name-Email: $GIT_EMAIL
Expire-Date: 2y
%commit
EOF
fi

# ---------- 11. git config ----------
step "git config"
GPG_KEY_ID=$(gpg --list-secret-keys --with-colons "$GIT_EMAIL" 2>/dev/null \
  | awk -F: '/^sec:/ {print $5; exit}')
git config --global user.name        "$GIT_NAME"
git config --global user.email       "$GIT_EMAIL"
git config --global user.signingkey  "$GPG_KEY_ID"
git config --global commit.gpgsign   true
git config --global tag.gpgsign      true
git config --global gpg.program      "$(command -v gpg)"
log "user=$GIT_NAME <$GIT_EMAIL> signingkey=$GPG_KEY_ID"

# ---------- 12. Final hints ----------
step "Done!"
cat <<EOF

Next manual steps:
  1. Reload shell:                 exec zsh
  2. Configure terminal font:      set 'JetBrainsMono Nerd Font' in iTerm2/Terminal
  3. Fill API keys:                nvim ~/.zshrc.secrets
  4. Login GitHub CLI:             gh auth login
                                   gh auth refresh -s admin:public_key,admin:ssh_signing_key,write:gpg_key
  5. Upload keys to GitHub:        gh ssh-key add ~/.ssh/id_ed25519.pub --title "\$(scutil --get ComputerName)"
                                   gpg --armor --export $GPG_KEY_ID | gh gpg-key add -
  6. (Optional) Switch repo to SSH:
                                   git -C $DOTFILES remote set-url origin git@github.com:tuanle03/dotfiles.git
  7. First-time p10k prompt:       p10k configure   (or copy ~/.p10k.zsh from old machine)

EOF
