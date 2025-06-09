-- Set leader key
vim.g.mapleader = " "

-- General settings
vim.opt.mouse = ''
vim.opt.backspace = { 'indent', 'eol', 'start' } -- Backspace deletes like most programs in insert mode
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.history = 10
vim.opt.laststatus = 2 -- Always display the status line
vim.opt.autowrite = true -- Automatically :write before running commands
vim.opt.list = true
vim.opt.listchars = {
  trail = '·',
}
vim.opt.fillchars = {
  vert = ' ',            -- Change the vertical separator (default is '│')
  vertleft = '┤',        -- Change the left-facing vertical separator
  vertright = '┐',       -- Change the right-facing vertical separator to your desired character
  verthoriz = '┼',       -- Change the overlapping vertical and horizontal separator
  fold = '·',            -- Change the fold column separator
  diff = '╱',            -- Change the column separator in diff mode
  msgsep = '‾',          -- Change the separator for messages
  stlnc = '.',           -- Change the statusline separator
  stl = ' ',             -- Change the statusline separator
  wbr = ' ',             -- Change the statusline separator
  eob = '│'              -- Change the EndOfBuffer character (default is '~')
}

-- Numbers
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.relativenumber = false
vim.cmd('syntax on')

-- Enable filetype plugins and indentation
vim.cmd('filetype plugin indent on')

-- Set up Ag as the grep program if available
if vim.fn.executable('ag') == 1 then
  vim.opt.grepprg = 'ag --nogroup --nocolor'
  vim.g.ctrlp_custom_ignore = {
    dir = '\\.git$|vendor\\|\\.hg$|\\.svn$|\\.yardoc$|public$|app/assets/images$|public$|app/assets/fonts$|data$|log$|node_modules$|bin$|tmp$',
    file = '\\.exe$|\\.so$|\\.min\\.js$|\\.min\\.css$|\\.png$|\\.jpg$|\\.jpeg$|\\.otf$|\\.gif$|\\.svg$|\\.dat$'
  }
end

local bundles_path = vim.fn.expand("~/.config/nvim/bundles.lua")
if vim.fn.filereadable(bundles_path) == 1 then
  dofile(bundles_path)
end

local local_path = vim.fn.expand("~/.config/nvim/local.vim")
if vim.fn.filereadable(local_path) == 1 then
  vim.cmd('source ~/.config/nvim/local.vim')
end

require('gitsigns').setup({
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 300,
    ignore_whitespace = true,
    virt_text_priority = 100,
  }
})

require("CopilotChat").setup({
  context = 'buffers',
  system_prompt = 'Your name is Github Copilot and you are a AI assistant for developers. I am using Ruby on Rails, I need help with the following:',
  prompts = {
    RailsAsk = {
      prompt = "In which Rails project would you like to work?",
    }
  }
})

require('moiday').setup({
  mode = 'light',
  auto = true,
  auto_options = {
    mode = 'auto',
    start = 7,
    finish = 19
  }
})

-- ESLint Linter and Auto Formatter
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d, -- ESLint Linter
    null_ls.builtins.formatting.eslint_d, -- ESLint Auto Formatter
    require("null-ls").builtins.formatting.prettier,
  },
})
