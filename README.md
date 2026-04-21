# dotfiles

Personal developer environment setup for macOS — Neovim, Tmux, Zsh, and Tmuxinator project sessions.

## Quick Start

```bash
git clone git@github.com:tuanle03/dotfiles.git ~/dotfiles
cd ~/dotfiles
make install
```

That's it. The install script symlinks all configs, installs packer.nvim, and creates a `~/.zshrc.secrets` template for your API keys.

**After install:**
1. Fill in `~/.zshrc.secrets` with your API keys
2. Open Neovim and run `:PackerSync`
3. Reload Tmux: `tmux source-file ~/.tmux.conf`

## What's Included

| Tool | Config | Symlinked to |
|------|--------|--------------|
| Neovim | `nvim/` | `~/.config/nvim` |
| Tmux | `tmux/` | `~/.tmux.conf` etc. |
| Zsh | `zsh/.zshrc` | `~/.zshrc` |
| Tmuxinator | `tmuxinator/` | `~/.config/tmuxinator` |

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

- macOS, Neovim 0.8+, Tmux 3.0+, Zsh 5.0+
- [Nerd Fonts](https://www.nerdfonts.com/) for icons
- `ripgrep` — `brew install ripgrep`
- `tmuxinator` — `gem install tmuxinator`

## Uninstall

```bash
rm ~/.config/nvim ~/.config/tmuxinator
rm ~/.tmux.conf ~/.tmux.conf.local ~/.tmux.conf.vim
rm ~/.zshrc ~/.zshrc.secrets
```
