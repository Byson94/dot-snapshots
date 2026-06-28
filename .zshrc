# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME=""

# Sourcing
source $HOME/.powerlevel10k/powerlevel10k.zsh-theme

# OMZ
export ZSH="/home/byson94/.oh-my-zsh"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias clear="printf '\033[2J\033[3J\033[1;1H'"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

