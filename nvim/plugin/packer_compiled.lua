-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/tuanle/.cache/nvim/packer_hererocks/2.1.1748459687/share/lua/5.1/?.lua;/Users/tuanle/.cache/nvim/packer_hererocks/2.1.1748459687/share/lua/5.1/?/init.lua;/Users/tuanle/.cache/nvim/packer_hererocks/2.1.1748459687/lib/luarocks/rocks-5.1/?.lua;/Users/tuanle/.cache/nvim/packer_hererocks/2.1.1748459687/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/tuanle/.cache/nvim/packer_hererocks/2.1.1748459687/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["CopilotChat.nvim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/CopilotChat.nvim",
    url = "https://github.com/CopilotC-Nvim/CopilotChat.nvim"
  },
  ["asyncrun.vim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/asyncrun.vim",
    url = "https://github.com/skywind3000/asyncrun.vim"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/auto-pairs",
    url = "https://github.com/jiangmiao/auto-pairs"
  },
  ["copilot.lua"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/copilot.lua",
    url = "https://github.com/zbirenbaum/copilot.lua"
  },
  ["copilot.vim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["copypath.vim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/copypath.vim",
    url = "https://github.com/bag-man/copypath.vim"
  },
  ["ctags.vim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/ctags.vim",
    url = "https://github.com/ThanhKhoaIT/ctags.vim"
  },
  ["ctrlp.vim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/ctrlp.vim",
    url = "https://github.com/ctrlpvim/ctrlp.vim"
  },
  fzf = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["gist-vim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/gist-vim",
    url = "https://github.com/mattn/gist-vim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gv.vim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/gv.vim",
    url = "https://github.com/junegunn/gv.vim"
  },
  indentline = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/indentline",
    url = "https://github.com/yggdroot/indentline"
  },
  ["matchit.zip"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/matchit.zip",
    url = "https://github.com/vim-scripts/matchit.zip"
  },
  ["moiday.nvim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/moiday.nvim",
    url = "https://github.com/ThanhKhoaIT/moiday.nvim"
  },
  nerdtree = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/nerdtree",
    url = "https://github.com/KhoaRB/nerdtree"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/nvim-compe",
    url = "https://github.com/hrsh7th/nvim-compe"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rails-db-migrate.vim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/rails-db-migrate.vim",
    url = "https://github.com/ThanhKhoaIT/rails-db-migrate.vim"
  },
  ["seoul256.vim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/seoul256.vim",
    url = "https://github.com/junegunn/seoul256.vim"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/splitjoin.vim",
    url = "https://github.com/AndrewRadev/splitjoin.vim"
  },
  ["switch.vim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/switch.vim",
    url = "https://github.com/AndrewRadev/switch.vim"
  },
  tComment = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/tComment",
    url = "https://github.com/vim-scripts/tComment"
  },
  ["tmuxline.vim"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/tmuxline.vim",
    url = "https://github.com/edkolev/tmuxline.vim"
  },
  ["vim-airline"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-airline",
    url = "https://github.com/vim-airline/vim-airline"
  },
  ["vim-airline-themes"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-airline-themes",
    url = "https://github.com/vim-airline/vim-airline-themes"
  },
  ["vim-closer"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-closer",
    url = "https://github.com/rstacruz/vim-closer"
  },
  ["vim-colors-solarized"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-colors-solarized",
    url = "https://github.com/altercation/vim-colors-solarized"
  },
  ["vim-colorschemes"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-colorschemes",
    url = "https://github.com/flazz/vim-colorschemes"
  },
  ["vim-ctrlp-tjump"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-ctrlp-tjump",
    url = "https://github.com/ivalkeen/vim-ctrlp-tjump"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-easymotion",
    url = "https://github.com/easymotion/vim-easymotion"
  },
  ["vim-endwise"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-endwise",
    url = "https://github.com/tpope/vim-endwise"
  },
  ["vim-expand-region"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-expand-region",
    url = "https://github.com/terryma/vim-expand-region"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-gitbranch"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-gitbranch",
    url = "https://github.com/itchyny/vim-gitbranch"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-gitgutter",
    url = "https://github.com/airblade/vim-gitgutter"
  },
  ["vim-hugefile"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-hugefile",
    url = "https://github.com/mhinz/vim-hugefile"
  },
  ["vim-javascript"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-javascript",
    url = "https://github.com/pangloss/vim-javascript"
  },
  ["vim-mergetool"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-mergetool",
    url = "https://github.com/samoshkin/vim-mergetool"
  },
  ["vim-mkdir"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-mkdir",
    url = "https://github.com/pbrisbin/vim-mkdir"
  },
  ["vim-move"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-move",
    url = "https://github.com/KhoaRB/vim-move"
  },
  ["vim-rails"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-rails",
    url = "https://github.com/ThanhKhoaIT/vim-rails"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-rspec"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-rspec",
    url = "https://github.com/thoughtbot/vim-rspec"
  },
  ["vim-ruby"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-ruby",
    url = "https://github.com/vim-ruby/vim-ruby"
  },
  ["vim-rubyformat"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-rubyformat",
    url = "https://github.com/KhoaRB/vim-rubyformat"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/Users/tuanle/.local/share/nvim/site/pack/packer/start/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  }
}

time([[Defining packer_plugins]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
