# 🛠️ Dotfiles by Tuan Le

Welcome to my personal `dotfiles` repository — a carefully curated setup to boost developer productivity with an opinionated configuration of **Neovim**, **Vim**, **Tmux**, and **Zsh**.

This setup is optimized for daily use in software engineering, with support for modern plugins, key mappings, aesthetics, and system compatibility.

---

## ✨ Features

- 🧠 **Neovim** configured with modular `init.lua`, plugin bundles, and local overrides.
- 🧙‍♂️ **Vim** setup for legacy workflows, mirroring Neovim's key plugins and shortcuts.
- 📦 **Tmux** custom configuration for split panes, session handling, and vim-like navigation.
- 🐚 **Zsh** with sensible defaults, aliases, and improved usability.
- ⚡ Lightning-fast and minimal.

---

## 📁 Directory Structure

```bash
dotfiles/
├── nvim/                  # Neovim config (Lua + Vimscript)
│   ├── init.lua
│   ├── local.vim
│   └── plugin/
│       └── bundles.lua
├── vim/                   # Vim config (legacy support)
│   ├── .vimrc
│   ├── .vimrc.bundles
│   └── .vimrc.local
├── tmux/                  # Tmux config and styles
│   ├── .tmux.conf
│   ├── .tmux.conf.local
│   ├── .tmux.conf.vim
│   └── .tmux.conf.backup
├── .zshrc                 # Zsh shell config
└── README.md              # You are here
```

## 🚀 Installation

1. **Clone the repository**:
   You can clone the repository using either SSH or HTTPS:
   - **SSH** (requires SSH keys set up):
     ```bash
     git clone git@github.com:tuanle03/dotfiles.git ~/.dotfiles
     ```
   - **HTTPS** (no SSH keys required):
     ```bash
     git clone https://github.com/tuanle03/dotfiles.git ~/.dotfiles
     ```
   After cloning, navigate to the repository:
   ```bash
   cd ~/.dotfiles
   ```
2. Backup your existing configuration files (optional but recommended):
    ```bash
    mv ~/.config/nvim ~/.config/nvim.bak
    mv ~/.vimrc ~/.vimrc.bak
    mv ~/.tmux.conf ~/.tmux.conf.bak
    mv ~/.zshrc ~/.zshrc.bak
    ```
3. **Create symlinks**:
You can create symbolic links to the configuration files in your home directory. This allows you to keep your dotfiles organized in one place while still using them in your shell.
    ```bash
    mkdir -p ~/.config/nvim
    ln -sf ~/dotfiles/nvim ~/.config/nvim

    ln -s ~/dotfiles/vim/.vimrc ~/.vimrc
    ln -s ~/dotfiles/vim/.vimrc.bundles ~/.vimrc.bundles
    ln -s ~/dotfiles/vim/.vimrc.local ~/.vimrc.local

    ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
    ln -s ~/dotfiles/tmux/.tmux.conf.local ~/.tmux.conf.local
    ln -s ~/dotfiles/tmux/.tmux.conf.vim ~/.tmux.conf.vim
    ln -s ~/dotfiles/tmux/.tmux.conf.backup ~/.tmux.conf.backup

    ln -s ~/dotfiles/.zshrc ~/.zshrc
    ```
4. **Install Neovim plugins**:
    Open Neovim and run:
    ```vim
    :PackerSync
    ```
    This will install all the plugins defined in your `init.lua`.
5. **Restart your shell**:
    Close and reopen your terminal or run:
    ```bash
    exec zsh
    ```
6. **Reload Tmux configuration**:
    Start a new Tmux session or reload your Tmux configuration:
    ```bash
    tmux source-file ~/.tmux.conf
    ```

## ⚙️ Requirements
- **Neovim**: Version 0.8 or higher
- **Tmux**: Version 3.0 or higher
- **Zsh**: Version 5.0 or higher
- **Git**: For cloning the repository
- Plugins managed by **Packer.nvim** for Neovim
- Font: [Nerd Fonts](https://www.nerdfonts.com/) for icons and glyphs

## 🛠️ Customization
You can customize the configuration by editing the respective files in the `nvim`, `vim`, `tmux`, and `.zshrc` directories. For example:
- **Neovim**: Modify `nvim/init.lua` for core settings, `nvim/plugin/bundles.lua` for plugins, and `nvim/local.vim` for local overrides.
- **Vim**: Edit `.vimrc`, `.vimrc.bundles`, and `.vimrc.local` for Vim-specific settings.
- **Tmux**: Adjust `.tmux.conf`, `.tmux.conf.local`, and `.tmux.conf.vim` for Tmux settings.
- **Zsh**: Modify `.zshrc` for shell settings, aliases, and functions.

## 🧪 Optional: Automatic Setup Script
If you prefer an automated setup, you can use the provided `setup.sh` script. This script will create symlinks for all configuration files and install Neovim plugins.
```bash
chmod +x install.sh
./install.sh
```

## 🖼️ Screenshots
![Screenshot 2025-06-23 at 14 44 42](https://github.com/user-attachments/assets/10192705-99e1-41f0-a94f-db22a882cfe1)

## 🧼 Uninstall
To uninstall the dotfiles, you can remove the symlinks created in your home directory:
```bash
rm ~/.config/nvim
rm ~/.vimrc
rm ~/.vimrc.bundles
rm ~/.vimrc.local
rm ~/.tmux.conf
rm ~/.tmux.conf.local
rm ~/.tmux.conf.vim
rm ~/.tmux.conf.backup
rm ~/.zshrc
```

## 🧠 Philosophy
This dotfiles setup is designed with the following principles in mind:
- **Simplicity**: Keep configurations minimal and easy to understand.
- **Modularity**: Use Lua for Neovim to allow for easy plugin management and configuration.
- **Consistency**: Ensure a consistent experience across Neovim, Vim, Tmux, and Zsh.
- **Performance**: Optimize for speed and responsiveness, avoiding unnecessary bloat.

## 📜 License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 🤝 Contributing
Contributions are welcome! If you have suggestions or improvements, feel free to open an issue or submit a pull request.

## 📫 Contact
For any questions or feedback, you can reach me at [Tuan Le](https://fb.com/tuanle03) or [Email](mailto:letuanvl03@gmail.com).

## 🙏 Acknowledgements
Thanks to the open-source community for providing the tools and plugins that make this setup possible. Special thanks to the maintainers of Neovim, Tmux, and Zsh for their incredible work.
