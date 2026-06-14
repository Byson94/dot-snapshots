# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME=""

# Sourcing
source $HOME/.powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end

bindkey '^[[H' beginning-of-line
bindkey '[1~' beginning-of-line

bindkey '^[[F' end-of-line
bindkey '[4~' end-of-line

# Aliases
alias clear="printf '\033[2J\033[3J\033[1;1H'"
alias gp="git push"
alias gpf="git push --force-with-lease"

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
