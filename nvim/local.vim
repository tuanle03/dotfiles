syntax enable
syntax on
set t_Co=256
" colorscheme seoul256
" colorscheme gruvbox

" let g:solarized_termtrans = 1
" let g:solarized_termcolors=256
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"

set timeoutlen=400 ttimeoutlen=0
set clipboard=unnamed
set diffopt+=vertical
set splitright
set splitbelow
set nobackup
set foldmethod=indent
set foldlevelstart=20
set redrawtime=10000
set scrolloff=8
set wildmenu

" START: For vue project
let &includeexpr = "substitute(v:fname, '^dashboard', 'app/javascript/dashboard', '')"
set suffixesadd+=.vue,.js,.ts
set path+=app/javascript,app/javascript/dashboard,app/javascript/dashboard/components,app/javascript/dashboard/components/widgets
" END: For vue project

" set noswapfile
highlight! link SignColumn LineNr
highlight Search ctermbg=none ctermfg=none cterm=underline guibg=none gui=none guifg=red
highlight LineNr guibg=#052229 guifg=#4f5b66
highlight Normal guibg=NONE ctermbg=NONE
" highlight VertSplit ctermfg=234 ctermbg=234
" highlight CursorLineNr term=bold ctermfg=232 ctermbg=244
" highlight CursorLine ctermfg=none ctermbg=none guifg=none guibg=none
" set cursorline
" highlight Visual ctermbg=blue

" vim-gitgutter
" let g:gitgutter_realtime = 1

command W w
command ForceKillRails !kill -9 $(cat tmp/pids/server.pid)

" vim-copypath
nnoremap <silent> yp :CopyPath<CR>
nnoremap <silent> yfn :CopyFileName<CR>

" Insert Mode

" Normal Mode
" ZoomFullPanel
nmap Z :NERDTreeClose<CR><C-w>\|
" UnZoom
nmap zz <C-w>=

" Quit all
nmap ~~ :qa!<CR>

nmap ! :!<Space>clear;<Space>
" nmap , *
nmap F za
nmap K kJ
" nmap <CR> *
" nmap <S-CR> N
nmap H ^
nmap L $
nmap + :vertical resize +20<cr>
nmap _ :vertical resize -20<cr>
nmap <C-f> <PageDown>

nnoremap <TAB> >>
nnoremap <S-TAB> <<
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv

vmap ) <Plug>(expand_region_expand)
vmap ( <Plug>(expand_region_shrink)

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nmap ss :SplitjoinSplit<cr>
nmap sj :SplitjoinJoin<cr>
nmap sw :Switch<cr>

" Find
" map <Leader>ag :Ag!<SPACE>""<LEFT>
" nmap fs :Ag! "<cword>" -G "\.(css\|sass\|scss)" --ignore "*.min.css" --ignore-dir "app/assets/stylesheets/components" --ignore-dir "app/assets/webpack"<CR>
" nmap fj :Ag! "<cword>" -G "\(js\|es6\|tsx\|ts)" --ignore "*.min.js" --ignore-dir "app/assets/javascripts/components" --ignore-dir "app/assets/webpack"<CR>
" nmap fr :Ag! "<cword>" -G "\.rb"<CR>
" nmap fv :Ag! "<cword>" -G "\.(haml\|erb)"<CR>
" nmap fm :Ag! "<cword>" -G "\.rb" -r "app/models"<CR>
" nmap fc :Ag! "<cword>" -G "\.rb" -r "app/controllers"<CR>
" nmap fb :Ag! "<cword>" -G \_blueprint\.rb -r "app/blueprints"<CR>
" nmap fa :Ag! "<cword>" -G "\.(rb\|erb\|js\|es6\|css\|sass\|scss\|yml\|rake\|haml\|go\|tsx\|ts)" --ignore "*.min.*" --ignore-dir "app/assets/javascripts/components" --ignore-dir "app/assets/stylesheets/components" --ignore-dir "app/assets/webpack"<CR>
"
" map <Leader>fs :Ag! -G "\.(css\|scss\|sass)" --ignore "*.min.css" --ignore-dir "app/assets/stylesheets/components" --ignore-dir "app/assets/webpack"<SPACE>
" map <Leader>fj :Ag! -G "\.(js\|es6\|tsx\|ts)" --ignore "*.min.js" --ignore-dir "app/assets/javascripts/components" --ignore-dir "app/assets/webpack"<SPACE>
" map <Leader>fr :Ag! -G "\.rb"<SPACE>
" map <Leader>fv :Ag! -G "\.(haml\|erb)"<SPACE>
" map <Leader>fm :Ag! -G "\.rb" -r "app/models"<SPACE>
" map <Leader>fc :Ag! -G "\.rb" -r "app/controllers"<SPACE>
" map <Leader>fb :Ag! -G \_blueprint\.rb -r "app/blueprints"<SPACE>
" map <Leader>fa :Ag! -G "\.(rb\|erb\|js\|css\|sass\|scss\|yml\|rake\|haml\|es6\|go\|tsx\|ts)" --ignore "*.min.*" --ignore-dir "app/assets/javascripts/components" --ignore-dir "app/assets/stylesheets/components" --ignore-dir "app/assets/webpack"<SPACE>
"

" Ripgrep Search
nmap <Leader>ag :Rg<SPACE>

" Find method
let g:ruby_host_prog = '~/.gem/ruby/2.7.0/bin/neovim-ruby-host'
nmap - :RubyJump<CR>
nmap gm :RubyJumpCursor<CR>

nnoremap '' <c-^>

" Common
map ?? :CopilotChatReset<CR>:CopilotChat<SPACE>
vmap ?? :CopilotChatReset<CR>:CopilotChat<SPACE>

map <Leader>w :update<CR>           "Save file
map <Leader>q :q<CR>           "Quit file
map <Leader>va <ESC>ggVG<CR>   "Select all file
map <C-c> "*y<CR>
map <C-a> <ESC>gg<S-v>G<ESC>

map <Leader>bi :PluginInstall<CR>
map <Leader>` :Start! ctags -R ./ --languages=ruby --exclude={.git,log,app/assets/webpack,node_modules,"*.min.js","*.min.css"}<CR>
map <Leader>`` :Start! ctags -R ./ $(bundle list --paths) --languages=ruby --exclude={.git,log,app/assets/webpack,node_modules,"*.min.js","*.min.css"}<CR>
" map <Leader>f :FixWhitespace<CR>
map <Leader>n <C-w>v<C-h>''
map <Leader>h :GundoToggle<CR>
map <Leader>nt :NERDTreeToggle<CR>
map <Leader>nn :NERDTreeFocus<CR>
map <Leader>tf :NERDTreeFind<CR>
map <Leader>rm :Remove!<CR>
map <Leader>sg :sp<CR>:grep<SPACE>
map <Leader>sv :source $MYVIMRC<CR>
map <Leader>te :tabe<SPACE>
map <Leader>tc :tabclose<CR>
map <Leader>v "*p<CR>
map <Leader>vi :tabe ~/.config/nvim/local.vim<CR>
map <Leader>p hplde
map <Leader>b :mark<SPACE>

" Git
nmap <Leader>gs :G<CR>
nmap <Leader>gco :Gread<CR>
nmap <Leader>ga :Gwrite<CR>
nmap <Leader>gac :Git commit -am ""<LEFT>
nmap <Leader>gb :G<SPACE>blame<CR>
nmap <Leader>gv :GBrowse %<CR>
nmap <Leader>gc :! clear; aicommits --generate 4 --exclude 'sorbet/*'; clear<CR>
nmap <Leader>gp :G push<CR>
nmap <Leader>gd :Gdiffsplit<CR>
nmap <Leader>gf :Gvdiffsplit!<CR>

nmap <Leader>gl :diffget //2<CR>
" fullpath => fugitive:///Users/khoa/projects/lixibox/.git//2/app/models/package_type.rb

nmap <Leader>gr :diffget //3<TAB><CR>
" fullpath => fugitive:///Users/khoa/projects/lixibox/.git//3/app/models/package_type.rb

" Rails
map <Leader>aj <ESC>:e app/assets/javascripts/application.js<CR>
map <Leader>as <ESC>:e app/assets/stylesheets/application.scss<CR>
map <Leader>av :AV<CR>
map <Leader>bb :!bundle install<CR>
map <Leader>d <ESC>obyebug<ESC>
map <Leader>dv <ESC>o- byebug<ESC>
map <Leader>g :e Gemfile<CR>
map <Leader>r <ESC>ggO# frozen_string_literal: true<CR><ESC>D

map <Leader>b :Vblueprint<SPACE>

map <Leader>c :Vcontroller<SPACE>
map <Leader>vc :Vcontroller<CR>
map <Leader>ec :Econtroller<CR>
map <Leader>oc :Econtroller<SPACE>

map <Leader>vh :Vhelper<SPACE>
map <Leader>vf :Vfactory<SPACE>

map <Leader>m :Vmodel<SPACE>
map <Leader>em :Emodel<SPACE>

map <Leader>vv :Vview<SPACE>
map <Leader>ev :Eview<CR>
map <Leader>rv :RV<CR>
map " ds"
map !! cs"'

map <Leader>rt :e config/routes.rb<CR>
map <Leader>sc :sp db/schema.rb<CR>
" map <Leader>cv :REview <C-r><C-w>.html.haml

nmap f1 :set foldlevel=1<CR>
nmap f2 :set foldlevel=2<CR>
nmap f3 :set foldlevel=3<CR>
nmap f4 :set foldlevel=4<CR>
nmap f5 :set foldlevel=5<CR>
nmap f6 :set foldlevel=6<CR>
nmap f7 :set foldlevel=7<CR>
nmap f8 :set foldlevel=8<CR>

" Tabs
nmap <Leader>1 1gt
nmap <Leader>2 2gt
nmap <Leader>3 3gt
nmap <Leader>4 4gt
nmap <Leader>5 5gt
nmap <Leader>6 6gt
nmap <Leader>7 7gt
nmap <Leader>8 8gt
nmap <Leader>9 9gt

" Auto fix Rubocop
map <Leader>rf :!bundle exec rubocop -a %<CR>

" Ctrl-P
nnoremap <c-]> :CtrlPtjump<cr>
vnoremap <c-]> :CtrlPtjumpVisual<cr>
" nmap <c-p>m :CtrlPModels<cr>
" nmap <c-p>c :CtrlPControllers<cr>
" nmap <c-p>v :CtrlPViews<cr>
" nmap <c-p>l :CtrlPLibs<cr>
" nmap <c-p>d :CtrlPMigrations<cr>

map <Leader>dm :RailsMigrate<CR>
map <Leader>dd :RailsMigrateDown<CR>
map <Leader>du :RailsMigrateUp<CR>
map <Leader>dr :RailsMigrateRedo<CR>
let g:rails_migrate_command = "Dispatch bundle exec rake"

let g:rails_migrate_command = "Dispatch bundle exec rake"
map <Leader>dmt :!rails db:migrate RAILS_ENV=test<CR>

" vim-rspec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
" map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "Dispatch bundle exec rspec {spec} -c -fprogress --color"
let g:rspec_runner = "os_x_iterm2"
let g:dispatch_quickfix_height=15
let g:dispatch_tmux_height=5

" Navigate
" imap <C-h> <C-o>h
" imap <C-j> <C-o>j
" imap <C-k> <C-o>k
" imap <C-l> <C-o>l

nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
if has('nvim')
  map <BS> <C-W>h
else
  map <C-h> <C-w>h
endif

" Multi Cursor
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" let g:ag_format="%l:%f:%m"

" Plugin 'matze/vim-move'
let g:move_key_modifier = 'C'

" " AG search
" if executable('ag')
"   " Use ag over grep
"   set grepprg=ag\ --nogroup\ --nocolor
"
"   " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"   let g:ctrlp_user_command = 'ag %s -l -g ""' " --nocolor
"   " let g:ctrlp_user_command = 'ag %s -l -g'
" endif

" Ripgrep
" set grepprg=rg\ --vimgrep
" set grepformat^=%f:%l:%c:%m
" let g:ctrlp_user_command = 'rg %s --files --vimgrep --color=never --glob ""'
" let g:ctrlp_use_caching = 0

" let g:ctrlp_user_command = 'ag %s -l -g ""' " --nocolor

" autocmd BufWritePre * FixWhitespace
autocmd BufWritePre * :%s/\s\+$//e "FixWhitespace

" Syntax
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_ruby_checkers = ['rubocop']
" let g:tmuxline_powerline_separators = 1
" let g:airline#extensions#tmuxline#enabled = 0

let g:ale_lint_on_text_changed = 'always'
let g:ale_ruby_rubocop_executable = 'bundle'

let g:tmuxline_preset = {
      \'a'    : '#S',
      \'win'  : ['#I', '#W'],
      \'cwin' : [' #I', '#W'],
      \'x'    : '',
      \'y'    : ["#(~/dotfiles/sh/git_branch.sh)"],
      \'z'    : ['#(~/.tmux/plugins/tmux-cpu/scripts/cpu_percentage.sh)'],
      \'options' : {'status-justify' : 'left'} }

" Airline
set encoding=utf-8
set guifont="Inconsolata\-g\ for\ Powerline"
set laststatus=2

let base16colorspace=256
let g:Powerline_symbols = 'fancy'
let g:airline_theme= 'papercolor'
let g:airline#extensions#po#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b' ],
    \ [ 'error', 'warning']
    \ ]
let g:airline#extensions#ctrlp#color_template = 'insert'
let g:airline#extensions#ctrlp#color_template = 'normal'
let g:airline#extensions#ctrlp#color_template = 'visual'
let g:airline#extensions#ctrlp#color_template = 'replace'

" Tabline
let g:airline#extensions#tabline#enabled = 1           " enable airline tabline
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right
let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline
let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline
let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''

function! AirlineInit()
  let g:airline_section_a = airline#section#create(['mode'])
  let g:airline_section_b = airline#section#create_left(['file'])
  let g:airline_section_c = airline#section#create([])
  let g:airline_section_x = ""
  let g:airline_section_y = ""
  " let g:airline_section_z = airline#section#create(['gitmessage'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()


if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" NERDTree
let g:webdevicons_enable = 0
let g:NERDTreeDirArrowExpandable = ""
let g:NERDTreeDirArrowCollapsible = ""
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''
highlight NERDTreeOpenable ctermfg=7
highlight NERDTreeClosable ctermfg=15
highlight Directory cterm=bold ctermfg=173

" Syntastic
let g:syntastic_error_symbol = ""
let g:syntastic_warning_symbol = ""

" Gitgutter
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_modified_removed = ''

highlight GitGutterAdd    guifg=#009900 ctermfg=2 guibg=NONE ctermbg=NONE
highlight GitGutterChange guifg=#bbbb00 ctermfg=3 guibg=NONE ctermbg=NONE
highlight GitGutterDelete guifg=#ff2222 ctermfg=1 guibg=NONE ctermbg=NONE


""""""""""""""""""""""""""""""""""""""""
""            EasyMotion              ||
map  ' <Plug>(easymotion-sn)
omap ' <Plug>(easymotion-tn)<Paste>
map  m <Plug>(easymotion-next)
map  M <Plug>(easymotion-prev)
""            END EasyMotion          ||
""""""""""""""""""""""""""""""""""""""""

" CtrlPtjump
let g:ctrlp_tjump_shortener = ['/.*/.*/gems/', '.../']
let g:ctrlp_tjump_only_silent = 1
let g:ctrlp_tjump_skip_tag_name = 1
let g:ctrlp_lazy_update = 0

function! CurrentFuncNameRuby()
  let l:index = line('.')
  while l:index > 1
    let l:line_string = getline(l:index)
    let l:line_words = split(l:line_string, ' ')
    let l:def_index = index(l:line_words, 'def')
    if (l:def_index >= 0)
      let l:func_name = split(l:line_words[l:def_index + 1], "(")[0]
      let l:command_string = ":Vview " . l:func_name . '.html.haml!'
      execute l:command_string
      return
    endif
    let l:index -= 1
  endwhile
  echo 'Not detect method name'
endfunction

map <Leader>cv :call CurrentFuncNameRuby()<CR>

" Ignore
" let NERDTreeIgnore=['tmp', 'log/', 'tags', 'package.json.sample',
"       \ 'dump.rdb', 'config.ru', 'public', 'node_modules',
"       \ 'bin', 'README', 'README.md', 'circle.yml', '\.otf$',
"       \ '\.png$', '\.jpg$', '\.gif$', '\.jpeg$', '\.svg$', '\.eot$', '\.ttf$', '\.woff$', '\.woff2$']
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.git$\|\.sass-cache$|\.hg$\|\.svn$\|\.yardoc\|sorbet|client\/node_modules$\|public$|log\|tmp$',
      \ 'file': '\.min\.js$\|\.json5$\|\.eot$\|\.tff$\|\.woff$\|\.woff2$\|\.json$\|\.png$\|\.jpeg$\|\.jpg$\|\.ico$\|\.so$\|\.dat$|\.DS_Store$'
      \ }

let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" " COC-TAB
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" JSX
" let g:jsx_ext_required = 0
" let g:jsx_pragma_required = 1

let g:github_enterprise_urls = ['https://github.com']

" Ruby Auto Format
let g:rubyformat_on_save = 0

let g:syntastic_html_tidy_ignore_errors = [
      \'File to import not found or unreadable: bootstrap']

" UltiSnips
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<C-j>"
" let g:UltiSnipsJumpBackwardTrigger="<C-k>"
" let g:UltiSnipsEditSplit="vertical"

" FZF
command! -bang -nargs=* RGgo
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading  --color=always --smart-case -g "*.{go,yml}" -- '.shellescape(<q-args>), 1,
  \   {}, <bang>0)

command! -bang -nargs=* RGrails
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading  --color=always --smart-case -g "*.{rb,erb,js,es6,css,sass,scss,yml,rake,haml,vue,go,ts,tsx}" -- '.shellescape(<q-args>), 1,
  \   {}, <bang>0)

command! -bang -nargs=* RGspec
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading  --color=always --smart-case -g "spec/**/*.{rb}" -- '.shellescape(<q-args>), 1,
  \   {}, <bang>0)

command! -bang -nargs=* RGmodel
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "app/models/**/*.rb" -- '.shellescape(<q-args>), 1,
  \   {}, <bang>0)

command! -bang -nargs=* RGcontroller
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "app/controllers/**/*.rb" -- '.shellescape(<q-args>), 1,
  \   {}, <bang>0)

command! -bang -nargs=* RGview
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "app/views/**/*.{haml,erb}" -- '.shellescape(<q-args>), 1,
  \   {}, <bang>0)

command! -bang -nargs=* RGruby
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "*.rb" -- '.shellescape(<q-args>), 1,
  \   {}, <bang>0)

command! -bang -nargs=* RGstyle
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "*.{css,sass,scss}" -- '.shellescape(<q-args>), 1,
  \   {}, <bang>0)

command! -bang -nargs=* RGjs
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "*.{js,es6}" -- '.shellescape(<q-args>), 1,
  \   {}, <bang>0)

command! -bang -nargs=* RGblueprint
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "app/blueprints/**/*_blueprint.rb" -- '.shellescape(<q-args>), 1,
  \   {}, <bang>0)

command! -bang -nargs=* FindByFilename
  \ call fzf#run({
  \   'source': 'rg --color=always --files | grep -i --color=always ' . shellescape(<q-args>),
  \   'sink': 'e',
  \   'options': '--ansi --exact',
  \   'down': '40%'
  \ })

" FZF Mapping
nmap fg :RGgo <C-R><C-W><CR>
nmap fa :RGrails <C-R><C-W><CR>
nmap ft :RGspec<SPACE>
nmap fm :RGmodel <C-R><C-W><CR>
nmap fv :RGview <C-R><C-W><CR>
nmap fc :RGcontroller <C-R><C-W><CR>
nmap fs :RGstyle <C-R><C-W><CR>
nmap fj :RGjs <C-R><C-W><CR>
nmap fr :RGruby <C-R><C-W><CR>
nmap fb :RGblueprint <C-R><C-W><CR>
nmap ff :FindByFilename <C-R><C-W><CR>
nmap <Leader>ff :Files<CR>
nmap <Leader>fg :RGgo<SPACE>
nmap <Leader>fa :RGrails<SPACE>
nmap <Leader>ft :RGspec<SPACE>
nmap <Leader>fm :RGmodel<SPACE>
nmap <Leader>fv :RGview<SPACE>
nmap <Leader>fc :RGcontroller<SPACE>
nmap <Leader>fs :RGstyle<SPACE>
nmap <Leader>fj :RGjs<SPACE>
nmap <Leader>fr :RGruby<SPACE>
nmap <Leader>fb :RGblueprint<SPACE>

" FZF Search
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --hidden --no-ignore -l "" -g "!{log,.git,.terragrunt-cache,tmp,sorbet,node_modules,vendor/bundle}/" -g "!tmp/cache" -g "!*.{jpg,png,svg,cache,min.css,min.js,min.scss}"'
elseif executable('fd')
  let $FZF_DEFAULT_OPTS = '--ansi'
  let $FZF_DEFAULT_COMMAND = 'fd --hidden --color always -E "{.git,.terragrunt-cache,log,tmp}/*","*.{jpg,png,svg,cache}","*.min.{scss,css,js}"'
else
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
endif

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'horizontal' } }
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

set autoread
au BufRead,BufNewFile *.es6 set filetype=javascript
" au CursorHoldI * checktime

set tags^=./.git/tags;

" GPT setup
let g:chat_gpt_model='gpt-4'
let g:chat_gpt_max_tokens=2000
let g:chat_gpt_split_direction='vertical'
let g:chat_gpt_lang='VietNam and shorten the introduction of the response'
let g:chat_gpt_session_mode='0'

set background=dark

function! AutoSetColorScheme()
  let l:hour = str2nr(strftime("%H"))

  if l:hour >= 7 && l:hour < 18
    colorscheme catppuccin-macchiato
  else
    colorscheme catppuccin-mocha
  endif
endfunction

autocmd VimEnter * call AutoSetColorScheme()
