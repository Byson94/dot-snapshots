# == P10K Sourcing == 
# Must put it near the top
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# == OMZ ==
export ZSH="/home/byson94/.oh-my-zsh"
ZSH_THEME="refined"

# Performance opts
DISABLE_AUTO_UPDATE="true"
DISABLE_COMPFIX="true"
DISABLE_MAGIC_FUNCTIONS="true"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Sourcing
# source $HOME/.powerlevel10k/powerlevel10k.zsh-theme
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Aliases
alias clear="printf '\033[2J\033[3J\033[1;1H'"

# clearing autosuggestions on paste
# it is important as it would not consider `paste` as an input
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

# binary paths
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH" # custom node path
export PATH="$HOME/.local/bin:$PATH"

. "$HOME/.cargo/env"

export NVM_DIR="/usr/share/nvm"

lazy_nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
}

nvm()  { lazy_nvm; command nvm "$@"; }
node() { lazy_nvm; command node "$@"; }
npm()  { lazy_nvm; command npm "$@"; }
npx()  { lazy_nvm; command npx "$@"; }
