# dotfiles

Personal developer environment setup for macOS — Neovim, Tmux, Zsh, and Tmuxinator project sessions.

## Quick Start

### Fresh machine (full bootstrap)

```bash
git clone git@github.com:tuanle03/dotfiles.git ~/projects/dotfiles
cd ~/projects/dotfiles
make bootstrap
```

`make bootstrap` is **idempotent** — re-running skips work that's already done. It installs everything needed end-to-end:

- Homebrew + CLI tools (`neovim`, `tmux`, `fd`, `fzf`, `the_silver_searcher`, `ripgrep`, `node`, `rbenv`, `ruby-build`, `pyenv`, `gnupg`, `gh`, `pinentry-mac`)
- JetBrainsMono Nerd Font
- `tmuxinator` (Ruby gem, symlinked to `~/.local/bin`)
- `oh-my-zsh` + `powerlevel10k` theme
- All config symlinks (via `make install`)
- Neovim plugins via `:PackerSync` (headless)
- GPG agent with `pinentry-mac`
- SSH ed25519 key (skipped if `~/.ssh/id_ed25519` exists)
- GPG ed25519 key (skipped if a key for your email exists)
- Git config (user, email, signing key, auto-sign commits & tags)

Override identity via env vars:
```bash
GIT_NAME="Foo Bar" GIT_EMAIL=foo@bar.com make bootstrap
```

### Re-run on an existing machine

`make bootstrap` is safe to re-run — existing tools, symlinks, and **especially SSH/GPG keys are never overwritten**.

If you only want to refresh symlinks (e.g., after moving the repo):
```bash
make install
```

### Manual steps after bootstrap

The script prints these at the end:
1. `exec zsh` — reload shell
2. Set **JetBrainsMono Nerd Font** in your terminal (iTerm2/Terminal/Ghostty)
3. Fill API keys: `nvim ~/.zshrc.secrets`
4. `gh auth login` then `gh auth refresh -s admin:public_key,admin:ssh_signing_key,write:gpg_key`
5. Upload keys: `gh ssh-key add ~/.ssh/id_ed25519.pub` and `gpg --armor --export <KEY_ID> | gh gpg-key add -`
6. (Optional) Switch repo to SSH: `git remote set-url origin git@github.com:tuanle03/dotfiles.git`
7. First-time prompt config: `p10k configure` (or copy `~/.p10k.zsh` from old machine)

## What's Included

| Tool | Config | Symlinked to |
|------|--------|--------------|
| Neovim | `nvim/` | `~/.config/nvim` |
| Tmux | `tmux/` | `~/.tmux.conf` etc. |
| Zsh | `zsh/.zshrc` | `~/.zshrc` |
| Tmuxinator | `tmuxinator/` | `~/.config/tmuxinator` |
| Cloudflared | `cloudflared/*.yml` | `~/.cloudflared/` (configs only — credentials are machine-specific, see [cloudflared/README.md](cloudflared/README.md)) |
| Claude Code | `.claude/` | `~/.claude/` (CLAUDE.md, RTK.md, DELEGATION.md, settings.json, agents/ — credentials & session state excluded) |

## Syncing Configs

Configs are symlinked, so edits in your editor are already in the repo. For tmuxinator project files (edited via the `tmuxinator` CLI), run:

```bash
make sync
```

Then `git diff` to review and commit.

## Secrets

API keys and tokens are **never committed**. They live in `~/.zshrc.secrets`, sourced at the end of `.zshrc`. Use `zsh/.zshrc.secrets.example` as the template.

## Neovim

Built on [Packer.nvim](https://github.com/wbthomason/packer.nvim). Config loads in three layers:

- `nvim/init.lua` — core options and plugin setup (nvim-tree, lualine, gitsigns, CopilotChat)
- `nvim/plugin/bundles.lua` — plugin declarations
- `nvim/local.vim` — all keymaps, FZF/ripgrep commands, Rails helpers

**Key bindings (leader = `<Space>`):**

| Key | Action |
|-----|--------|
| `<Leader>nt` | Toggle file tree |
| `<Leader>ff` | FZF file finder |
| `<Leader>fa` | Ripgrep across project |
| `<Leader>gs` | Git status (fugitive) |
| `<Leader>gc` | AI commit message (aicommits) |
| `<Leader>w` / `<Leader>q` | Save / quit |
| `??` | Open CopilotChat |

## Tmux

Prefix is `C-Space`. Vim-style pane navigation (`h/j/k/l`). Config splits across:

- `.tmux.conf` — base settings
- `.tmux.conf.vim` — vi key bindings
- `.tmux.conf.local` — local overrides

## Requirements

- macOS (Apple Silicon or Intel)
- Homebrew (auto-installed by `make bootstrap` if missing)
- Neovim 0.8+, Tmux 3.0+, Zsh 5.0+ (auto-installed by `make bootstrap`)

All other dependencies (Nerd Font, ripgrep, tmuxinator, oh-my-zsh, etc.) are installed by `make bootstrap`.

## Uninstall

Remove just the symlinks (keeps `~/.zshrc.secrets`):
```bash
rm ~/.config/nvim ~/.config/tmuxinator
rm ~/.tmux.conf ~/.tmux.conf.local ~/.tmux.conf.vim
rm ~/.zshrc
```

`make bootstrap` doesn't install anything that can't be safely left alone — to fully remove, also `brew uninstall` the formulas listed in `scripts/bootstrap.sh`.
