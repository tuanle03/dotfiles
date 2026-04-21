# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home"

ZSH_THEME="powerlevel10k/powerlevel10k"
export TERM="xterm-256color"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

export PATH="/usr/local/opt/libxslt/bin:$PATH"
export PATH="/usr/local/opt/binutils/bin:$PATH"
export PATH=${PATH}:/usr/local/mysql/bin/
export PATH=$PATH:$MYSQL
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/postgresql@14/bin:$PATH"
export PATH="/usr/local/opt/node@22/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export MONGO_DEFAULT_DB=lixibox_mongodb
export MONGO_DEFAULT_HOST="mongodb://localhost:37017"
export MONGO_DEFAULT_TEST_DB=lixibox_mongodb_test

export GPG_TTY=$(tty)

export LDFLAGS="-L$(brew --prefix zlib)/lib"
export CPPFLAGS="-I$(brew --prefix zlib)/include"
export RUBY_CONFIGURE_OPTS="--with-zlib-dir=$(brew --prefix zlib)"

# Aliases
alias mux='tmuxinator'
alias cl=clear
alias v=vim
alias n=nvim
alias vim=nvim
alias gcm='aicommits --generate 5 --type conventional'
alias drc='docker start lixibox; cl; docker exec -it lixibox /bin/bash; rc'
alias drs='docker start lixibox; cl; docker attach lixibox'
alias rs='bundle exec rails s'
alias rc='bundle exec rails c'
alias rdb='bundle exec rails db:migrate && bundle exec rails db:seed'
alias rspec='bundle exec rspec'
alias sidekiq='bundle exec sidekiq'
alias rbc='bundle exec rubocop'
alias test='bin/rails test'
alias precm='cl; rbc; test'
alias syncmux="~/dotfiles/scripts/sync.sh"

# Heroku autocomplete
HEROKU_AC_ZSH_SETUP_PATH="$HOME/Library/Caches/heroku/autocomplete/zsh_setup"
if [ -f "$HEROKU_AC_ZSH_SETUP_PATH" ]; then
  source "$HEROKU_AC_ZSH_SETUP_PATH"
fi

# Docker CLI completions
fpath=(/Users/tuanle/.docker/completions $fpath)
autoload -Uz compinit
compinit

eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pnpm
export PNPM_HOME="/Users/tuanle/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# API keys and tokens — stored locally, never committed
[ -f ~/.zshrc.secrets ] && source ~/.zshrc.secrets
