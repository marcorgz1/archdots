# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval "$(zoxide init zsh)"
# eval "$(starship init zsh)"
source <(fzf --zsh)

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="amresh"
# ZSH_THEME="ultima"

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
alias update-grub='sudo grub-mkconfig -o /boot/gr'
alias empty-trash='autotrash -d 30 --install'

alias mtx='cmatrix -B'
alias ctp='clocktemp -tf 24 -df dd/mm -lat 40.19081000 -lon 3.67887000 -c magenta'
alias msay='momoisay -a hello!'
alias ff='fastfetch --config aesthetic'
alias ytaudio='yt-dlp -f 'ba' -x --no-playlist'

alias i='yay -S --needed'
alias s='yay -Ss'
alias u='yay -U'

alias lp='sudo pacman -Qm'
alias r='yay -Rns'

alias ll='exa -la --icons --group-directories-first'
alias cat='bat --theme=gruvbox-dark'

alias gcl='git clone'
alias ga='git add'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias glg='git log --oneline'

# ============ STARTUP ============
anime-colorscripts -r
fastfetch --config custom


PATH=~/.console-ninja/.bin:$PATH

