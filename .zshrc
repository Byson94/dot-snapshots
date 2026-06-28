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
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# User configuration

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

HISTORY_SUBSTRING_SEARCH_PREFIXED=1

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey '^[[H' beginning-of-line
bindkey '[1~' beginning-of-line

bindkey '^[[F' end-of-line
bindkey '[4~' end-of-line

function cstm_history {
  local clear list
  zparseopts -E c=clear l=list

  if [[ -n "$clear" ]]; then
    print -nu2 "This will delete your entire shell history. Are you sure? [y/N] "
    builtin read -E
    if [[ "$REPLY" = [yY] ]]; then
      print -nu2 >| "$HISTFILE"
      fc -p "$HISTFILE"
      print -u2 "History file deleted."
    fi
  elif [[ -n "$list" ]]; then
    builtin fc "$@"
  else
    builtin fc -l "$@" 1
  fi
}

alias history='cstm_history'

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

