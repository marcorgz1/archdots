# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
source <(fzf --zsh)

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ENABLE_CORRECTION="true"

plugins=(
  git
  zsh-autosuggestions
)

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $ZSH/oh-my-zsh.sh

# User configuration

alias ls='ls -sal'
alias z..='z ..'
alias zshrc='nvim ~/.zshrc'
alias hyprpanelcfg='hyprpanel toggleWindow settings-dialog'
alias logout='hyprctl dispatch exit'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

alias mtx='cmatrix -B -c -r'
alias ctp='clocktemp -tf 24 -df dd/mm -lat 40.19081000 -lon 3.67887000 -c magenta'
alias msay='momoisay -a hello!'

alias i='yay -S'
alias s='yay -s'
alias r='yay -Rns'

alias ll='exa -la'

alias gcl='git clone'
alias ga='git add'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias glg='git log --oneline'

# ============ STARTUP ============

fastfetch --config custom

