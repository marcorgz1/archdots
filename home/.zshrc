. "$HOME/.atuin/bin/env"

eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
eval "$(starship init zsh)"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="agnoster"

plugins=(
    git
    zsh-autosuggestions
    zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh

source /usr/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ENABLE_CORRECTION="true"

# Aliases

alias ctp='clocktemp -tf 24 -df dd/mm -c blue -lat 40 -lon -3'
alias hyprpanelcfg='hyprpanel toggleWindow settings-dialog'
alias mtx='cmatrix -r -b'
alias pipes='sh ~/pipes.sh/pipes.sh -t 5'
alias t='tmux'
alias ta='tmux attach'
alias tl='tmux ls'
alias z..='z ..'
alias ls='lsd -a'
alias ll='lsd -l'
alias ll -a='lsd -la'

alias lgit='lazygit'
alias ggbranch='git branch'
alias ggcheckout='git checkout'
alias ggswitch='git switch'
alias gsw='git switch'
alias gginit='git init'
alias ggclone='git clone'
alias gcl='git clone'
alias ggadd='git add'
alias ga='git add'
alias ggcommit='git commit -m'
alias gcm='git commit -m'
alias ggpush='git push'
alias gp='git push'
alias ggpull='git pull'
alias gpl='git pull'
alias ggstatus='git status'
alias gst='git status'
alias ggmerge='git merge'
alias gm='git merge'
alias gglog="git log"

alias ff='fastfetch --config boxes'
alias nh='nitch -f'
alias of='onefetch'

alias open="thunar"
alias py='python3'
alias zshrc='nvim ~/.zshrc'
alias pnpm dev='pnpm run dev'

alias ff='fastfetch --config custom'
alias cf='customfetch'
alias nh='nitch'

# System info
fastfetch --config custom
# Thundery (weather info)
thundery
# customfetch
nitch

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

PATH=~/.console-ninja/.bin:$PATH

# pnpm
export PNPM_HOME="/home/marco1/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export PATH=$PATH:/home/marco1/.spicetify
