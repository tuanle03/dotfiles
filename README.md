# My Dotfiles

Welcome to my dotfiles repository! This collection includes my personal configurations for Vim, Tmux, and Zsh, which I use to enhance my productivity and streamline my development workflow.

## Tmux Configuration

The Tmux configuration file `.tmux.conf` contains my custom settings to improve the usability and appearance of Tmux. It includes key bindings, status bar customizations, and other enhancements.

## Vim Configuration

The Vim folder contains several configuration files:
- `.vimrc`: The main Vim configuration file.
- `.vimrc.bundles`: Configuration for Vim plugins managed by a plugin manager.
- `.vimrc.local`: Local overrides and additional settings specific to my workflow.

## Zsh Configuration

The `.zshrc` file includes my custom settings for Zsh, including aliases, environment variables, and prompt customizations.

## Installation

To use these configurations, you can clone this repository and create symbolic links to the appropriate configuration files in your home directory.

```sh
git clone https://github.com/tuanle03/dotfiles.git ~/dotfiles
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/vim/.vimrc ~/.vimrc
ln -s ~/dotfiles/vim/.vimrc.bundles ~/.vimrc.bundles
ln -s ~/dotfiles/vim/.vimrc.local ~/.vimrc.local
ln -s ~/dotfiles/.zshrc ~/.zshrc
