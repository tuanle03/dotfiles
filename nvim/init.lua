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

require('nvim-web-devicons').setup({
  default = true,
})

vim.cmd([[
  command! NERDTree NvimTreeToggle
  command! NERDTreeToggle NvimTreeToggle
  command! NERDTreeFind NvimTreeFindFile
  command! NERDTreeRefresh NvimTreeRefresh
  command! NERDTreeFocus NvimTreeFocus
  command! NERDTreeClose NvimTreeClose
]])
-- Set up nvim-tree
require("nvim-tree").setup({
  filters = {
    -- dotfiles = true, -- Hide dotfiles
    custom = {
      '.git', -- Hide .git directory
      'node_modules', -- Hide node_modules directory
      'vendor', -- Hide vendor directory
      'tmp', -- Hide tmp directory
      'log', -- Hide log files
      'public', -- Hide public directory
    },
  },
  renderer = {
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    }
  },
  git = {
    enable = true,
  },
  view = {
    width = 30,
    side = 'left',
  },
})

-- Set up lualine
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'catppuccin-mocha',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      {
        'branch',
        icon = '', -- Git branch icon
        colored = true, -- Color the branch name
        fmt = function(branch)
          local win_width = vim.api.nvim_win_get_width(0)
          local max_length = math.floor(win_width * 0.2106) -- 21.06% of the window width

          if #branch > max_length then
            local head = branch:sub(1, math.floor(max_length * 0.6)) -- 60% of max_length
            local tail = branch:sub(-math.floor(max_length * 0.4)) -- 40% of max_length
            return head .. '...' .. tail
          else
            return branch
          end
        end,
      },
      {
        'diff',
        colored = true, -- Color the diff indicators
        symbols = { added = ' ', modified = ' ', removed = ' ' }, -- Symbols for added, modified, and removed
      }
    },
    lualine_c = {
      {
        'filename',
        path = 1, -- 0: Just the filename, 1: Relative path, 2: Absolute path
        shorting_target = 40, -- Shorten the filename to fit in the status line
      }
    },
    lualine_x = { 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
})
