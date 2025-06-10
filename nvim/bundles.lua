vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Define bundles via GitHub repos
  -- Uncomment the plugins you want to use
  -- use 'christoomey/vim-run-interactive'
  -- use 'kchmck/vim-coffee-script'
  -- use 'tpope/vim-eunuch'
  -- use 'slim-template/vim-slim'
  -- use 'mattn/webapi-vim'
  -- use 'nanotech/jellybeans.vim'
  -- use 'tomtom/tcomment_vim'
  -- use 'croaky/vim-colors-github'
  -- use 'neomake/neomake'
  -- use 'Lokaltog/vim-powerline'

  -- CtrlP
  use 'ctrlpvim/ctrlp.vim'
  use 'ivalkeen/vim-ctrlp-tjump'
  -- use 'iurifq/ctrlp-rails.vim'

  use {'junegunn/fzf', run = function() return vim.fn['fzf#install']() end }
  use 'junegunn/fzf.vim'

  -- Used plugins
  use 'pangloss/vim-javascript'
  use 'terryma/vim-expand-region'
  use 'junegunn/vim-easy-align'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'junegunn/gv.vim' -- Git versions
  use 'vim-ruby/vim-ruby'
  use 'tpope/vim-surround'
  use 'AndrewRadev/splitjoin.vim'
  -- use 'scrooloose/syntastic'
  -- use 'w0rp/ale'
  use 'vim-scripts/tComment'
  use 'airblade/vim-gitgutter'
  use 'lewis6991/gitsigns.nvim' -- Inline git message
  use 'samoshkin/vim-mergetool' -- Merge tool
  use 'AndrewRadev/switch.vim'

  use 'pbrisbin/vim-mkdir'
  use 'bag-man/copypath.vim'
  use 'skywind3000/asyncrun.vim'

  -- Unused plugins
  -- use 'mxw/vim-jsx'
  -- use 'leafgarland/typescript-vim'
  -- use 'ap/vim-css-color'
  -- use 'sjl/gundo.vim'
  -- use 'mbbill/undotree'

  use 'vim-scripts/matchit.zip'
  use 'mhinz/vim-hugefile'

  -- use 'terryma/vim-multiple-cursors'
  use 'mg979/vim-visual-multi'

  use 'edkolev/tmuxline.vim'
  -- use 'bronson/vim-trailing-whitespace'
  use 'christoomey/vim-tmux-navigator'
  use 'mattn/gist-vim'
  -- use 'rking/ag.vim'
  -- use 'KhoaRB/nerdtree'
  use 'ryanoasis/vim-devicons'
  use 'tpope/vim-unimpaired'
  use 'yggdroot/indentline'
  use 'KhoaRB/vim-move'
  use 'rstacruz/vim-closer'
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-endwise'
  use 'easymotion/vim-easymotion'
  use 'itchyny/vim-gitbranch' -- Show git branch in status line

  -- THEME
  use 'altercation/vim-colors-solarized'
  use 'junegunn/seoul256.vim'
  use 'flazz/vim-colorschemes'
  use 'catppuccin/nvim'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'folke/tokyonight.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  }

  -- TMP
  -- use 'bendavis78/vim-polymer'

  -- Display
  use 'KhoaRB/vim-rubyformat'

  -- Tagbar
  -- use 'majutsushi/tagbar'

  -- Rspec
  use 'thoughtbot/vim-rspec'
  use 'tpope/vim-dispatch'

  -- Auto complete
  -- use 'ervandew/supertab'
  use 'hrsh7th/nvim-compe'
  -- use 'sirver/ultisnips'
  -- use 'honza/vim-snippets'
  -- use 'msanders/snipmate.vim'
  -- use 'Shougo/neocomplcache'
  -- use 'neoclide/coc.nvim', { branch = 'release' }

  use 'github/copilot.vim'
  use {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    requires = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    }
  }

  -- use '~/.vim/plugged/click2open.vim'
  -- use 'ThanhKhoaIT/byebug.vim'
  use 'ThanhKhoaIT/vim-rails'
  use 'ThanhKhoaIT/ctags.vim'
  use 'ThanhKhoaIT/rails-db-migrate.vim'
  -- use 'ThanhKhoaIT/git-message.vim'
  use 'ThanhKhoaIT/moiday.nvim'

  -- use 'APZelos/blamer.nvim'

  -- Style
  -- use 'junegunn/vim-emoji'
  -- use 'equalsraf/neovim-gui-shim'

  -- NeoVim
  -- use { 'nvim-treesitter/nvim-treesitter',
  --   run = ':TSUpdate'
  -- }

  -- use 'CoderCookE/vim-chatgpt'
  --

  -- use {
  --   'jose-elias-alvarez/null-ls.nvim',
  --   requires = { 'nvim-lua/plenary.nvim' }
  -- }
  use {
    "nvimtools/none-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }

end)
